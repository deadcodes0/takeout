<template>
  <el-dialog
    v-model="visible"
    title="选择位置"
    width="600px"
    :close-on-click-modal="false"
    @close="handleClose"
  >
    <div class="location-picker">
      <!-- 搜索框 -->
      <div class="search-box">
        <el-input
          v-model="searchKeyword"
          placeholder="搜索地点"
          :suffix-icon="searchIconVisible ? '' : 'Search'"
          @keyup.enter="handleSearch"
          clearable
        >
          <template #append>
            <el-button @click="handleSearch" :loading="searching">搜索</el-button>
          </template>
        </el-input>
      </div>

      <!-- 地图容器 -->
      <div id="location-picker-map" class="map-container"></div>

      <!-- 搜索结果列表 -->
      <div class="search-results" v-if="searchResults.length > 0">
        <div
          v-for="item in searchResults"
          :key="item.id"
          class="search-item"
          @click="handleSelectSearchResult(item)"
        >
          <div class="search-item-name">{{ item.name }}</div>
          <div class="search-item-address">{{ item.address || item.formatted_address }}</div>
        </div>
      </div>

      <!-- 当前选中位置信息 -->
      <div class="selected-info" v-if="selectedLocation">
        <span class="selected-label">已选择：</span>
        <span class="selected-name">{{ selectedLocation.name }}</span>
        <span class="selected-address">{{ selectedLocation.address }}</span>
      </div>

      <!-- 当前位置按钮 -->
      <div class="current-location-btn">
        <el-button
          @click="handleGetCurrentLocation"
          :loading="locating"
          size="small"
        >
          <el-icon><Location /></el-icon>
          获取当前位置
        </el-button>
      </div>
    </div>

    <template #footer>
      <el-button @click="handleClose">取消</el-button>
      <el-button type="primary" @click="handleConfirm" :disabled="!selectedLocation">
        确认选择
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, shallowRef, watch, onMounted, onUnmounted, computed } from 'vue'
import { ElMessage } from 'element-plus'
import { Location } from '@element-plus/icons-vue'
import AMapLoader from '@amap/amap-jsapi-loader'
import { AMAP_CONFIG } from '@/config/amap.config'

// Props & Emits
const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  }
})
const emit = defineEmits(['update:modelValue', 'confirm'])

const visible = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
})

// 状态
const searchKeyword = ref('')
const searching = ref(false)
const locating = ref(false)
const searchResults = ref([])
const selectedLocation = ref(null)
const searchIconVisible = computed(() => !!searchKeyword.value)

// 地图实例（使用 shallowRef 避免深层响应式性能损耗）
const map = shallowRef(null)
const AMapRef = shallowRef(null)
const placeSearch = shallowRef(null)
const geocoder = shallowRef(null)
const marker = shallowRef(null)

// 需要加载的所有插件（一次性加载，避免多次调用 AMapLoader.load）
const PLUGINS = [
  'AMap.PlaceSearch',
  'AMap.Geocoder',
  'AMap.Geolocation',
  'AMap.Scale',
  'AMap.ToolBar'
]

/**
 * 加载高德地图 JSAPI（仅在首次时调用）
 */
const loadAMap = async () => {
  if (AMapRef.value) return AMapRef.value

  try {
    const AMap = await AMapLoader.load({
      key: AMAP_CONFIG.KEY,
      version: '2.0',
      plugins: PLUGINS
    })

    // SKILL.md 强制要求：设置 appname 埋点
    AMap.getConfig().appname = 'amap-jsapi-skill'

    AMapRef.value = AMap
    return AMap
  } catch (e) {
    console.error('高德地图加载失败', e)
    throw e
  }
}

/**
 * 初始化地图
 */
const initMap = async () => {
  try {
    const AMap = await loadAMap()

    // 创建地图实例
    map.value = new AMap.Map('location-picker-map', {
      viewMode: '2D',
      zoom: 15,
      center: [116.397428, 39.90923] // 默认北京中心
    })

    // 添加比例尺
    map.value.addControl(new AMap.Scale())

    // 初始化 PlaceSearch
    placeSearch.value = new AMap.PlaceSearch({
      pageSize: 10,
      pageIndex: 1,
      city: '全国'
    })

    // 初始化 Geocoder
    geocoder.value = new AMap.Geocoder({
      radius: 1000,
      extensions: 'all'
    })

    // 初始化 Marker
    marker.value = new AMap.Marker({
      map: map.value,
      draggable: true
    })

    // 地图加载完成回调
    map.value.on('complete', () => {
      console.log('地图加载完成')
    })

    // 点击地图微调位置
    map.value.on('click', (e) => {
      const lng = e.lnglat.getLng()
      const lat = e.lnglat.getLat()

      // 移动标记到点击位置
      marker.value.setPosition([lng, lat])
      map.value.setCenter([lng, lat])

      // 逆地理编码获取地址信息
      geocoder.value.getAddress([lng, lat], (geoStatus, geoResult) => {
        if (geoStatus === 'complete' && geoResult.regeocode) {
          const addressComponent = geoResult.regeocode.addressComponent
          selectedLocation.value = {
            name: geoResult.regeocode.formattedAddress || '',
            address: geoResult.regeocode.formattedAddress || '',
            lng: lng,
            lat: lat,
            province: addressComponent.province || '',
            city: addressComponent.city || '',
            district: addressComponent.district || ''
          }
        } else {
          selectedLocation.value = {
            name: '选定位置',
            address: `${lng.toFixed(6)}, ${lat.toFixed(6)}`,
            lng: lng,
            lat: lat,
            province: '',
            city: '',
            district: ''
          }
        }
      })
    })
  } catch (e) {
    ElMessage.error('地图加载失败，请检查网络连接')
    console.error('初始化地图失败', e)
  }
}

/**
 * 搜索地点
 */
const handleSearch = async () => {
  if (!searchKeyword.value) return
  if (!placeSearch.value) {
    ElMessage.warning('地图尚未加载完成')
    return
  }

  searching.value = true
  try {
    placeSearch.value.search(searchKeyword.value, (status, result) => {
      searching.value = false
      if (status === 'complete' && result.poiList) {
        searchResults.value = result.poiList.pois || []
      } else if (status === 'no_data') {
        searchResults.value = []
        ElMessage.info('未找到相关地点')
      } else {
        searchResults.value = []
        console.error('搜索失败', status, result)
      }
    })
  } catch (error) {
    searching.value = false
    ElMessage.error('搜索失败')
  }
}

/**
 * 选择搜索结果
 */
const handleSelectSearchResult = (item) => {
  if (!map.value || !geocoder.value) return

  const location = item.location
  if (location) {
    const lng = location.lng
    const lat = location.lat

    // 更新地图中心和标记
    map.value.setCenter([lng, lat])
    marker.value.setPosition([lng, lat])

    selectedLocation.value = {
      name: item.name,
      address: item.address || item.formatted_address || '',
      lng: lng,
      lat: lat,
      province: item.pname || '',
      city: item.cityname || '',
      district: item.adname || ''
    }
  }
}

/**
 * 获取当前位置
 */
const handleGetCurrentLocation = () => {
  if (!AMapRef.value || !map.value || !geocoder.value) {
    ElMessage.warning('地图尚未加载完成')
    return
  }

  locating.value = true
  const AMap = AMapRef.value
  const geolocation = new AMap.Geolocation({
    enableHighAccuracy: true,
    timeout: 10000,
    showButton: false,
    showMarker: false,
    zoomToAccuracy: true
  })

  geolocation.getCurrentPosition((status, result) => {
    locating.value = false
    if (status === 'complete') {
      const lng = result.position.lng
      const lat = result.position.lat

      map.value.setCenter([lng, lat])
      marker.value.setPosition([lng, lat])

      // 逆地理编码获取地址信息
      geocoder.value.getAddress([lng, lat], (geoStatus, geoResult) => {
        if (geoStatus === 'complete' && geoResult.regeocode) {
          const addressComponent = geoResult.regeocode.addressComponent
          selectedLocation.value = {
            name: geoResult.regeocode.formattedAddress || '',
            address: geoResult.regeocode.formattedAddress || '',
            lng: lng,
            lat: lat,
            province: addressComponent.province || '',
            city: addressComponent.city || '',
            district: addressComponent.district || ''
          }
          ElMessage.success('定位成功')
        } else {
          selectedLocation.value = {
            name: '当前位置',
            address: `${lng}, ${lat}`,
            lng: lng,
            lat: lat,
            province: '',
            city: '',
            district: ''
          }
        }
      })
    } else {
      ElMessage.error('定位失败，请检查定位权限')
    }
  })
}

/**
 * 确认选择
 */
const handleConfirm = () => {
  if (selectedLocation.value) {
    emit('confirm', selectedLocation.value)
    visible.value = false
  }
}

/**
 * 关闭弹窗
 */
const handleClose = () => {
  searchKeyword.value = ''
  searchResults.value = []
  visible.value = false
}

// 监听弹窗打开，初始化地图
watch(visible, async (val) => {
  if (val) {
    // 等待 DOM 渲染后初始化地图
    await new Promise(resolve => setTimeout(resolve, 100))
    if (!map.value) {
      await initMap()
    }
  }
})

// 组件卸载时销毁地图
onUnmounted(() => {
  if (map.value) {
    map.value.destroy()
    map.value = null
  }
})
</script>

<style scoped>
.location-picker {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.search-box {
  display: flex;
  gap: 10px;
}

.map-container {
  width: 100%;
  height: 350px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.search-results {
  max-height: 150px;
  overflow-y: auto;
  border: 1px solid #eee;
  border-radius: 4px;
}

.search-item {
  padding: 8px 12px;
  cursor: pointer;
  border-bottom: 1px solid #eee;
}

.search-item:hover {
  background-color: #f5f7fa;
}

.search-item:last-child {
  border-bottom: none;
}

.search-item-name {
  font-weight: bold;
  color: #303133;
}

.search-item-address {
  font-size: 12px;
  color: #909399;
  margin-top: 2px;
}

.selected-info {
  padding: 8px;
  background-color: #f0f9eb;
  border-radius: 4px;
  font-size: 14px;
}

.selected-label {
  color: #67c23a;
  font-weight: bold;
}

.selected-name {
  font-weight: bold;
  color: #303133;
}

.selected-address {
  color: #909399;
  margin-left: 8px;
}

.current-location-btn {
  text-align: center;
}
</style>
