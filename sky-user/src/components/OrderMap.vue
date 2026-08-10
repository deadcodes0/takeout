<template>
  <div class="delivery-map-wrapper">
    <!-- 信息栏 -->
    <div class="map-info-bar" v-if="routeInfo">
      <span class="info-item">
        <el-icon><Clock /></el-icon>
        预计 {{ routeInfo.duration }} 分钟送达
      </span>
      <span class="info-item">
        <el-icon><Location /></el-icon>
        距离约 {{ routeInfo.distance }} km
      </span>
    </div>
    <div class="map-info-bar loading-bar" v-else-if="loading">
      <span>正在规划配送路线...</span>
    </div>

    <!-- 地图容器 -->
    <div
      :id="mapId"
      class="map-container"
      :class="{ 'map-error': mapError }"
    >
      <div v-if="mapError" class="map-error-msg">
        <el-icon :size="32"><WarningFilled /></el-icon>
        <p>地图加载失败</p>
        <el-button size="small" @click="initMap">重试</el-button>
      </div>
    </div>

    <!-- 无坐标时的提示 -->
    <div v-if="!hasCoordinates" class="no-coords-tip">
      <el-alert
        title="该地址暂无坐标信息，无法显示配送路线"
        type="warning"
        :closable="false"
        show-icon
      />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, watch } from 'vue'
import { Clock, Location, WarningFilled } from '@element-plus/icons-vue'
import { useDeliveryMap } from '@/composables/useDeliveryMap'
import { useAmap } from '@/composables/useAmap'

const props = defineProps({
  /** 订单ID（用于配送完成后更新状态） */
  orderId: {
    type: Number,
    default: null
  },
  /** 收货地址经度 */
  longitude: {
    type: Number,
    default: null
  },
  /** 收货地址纬度 */
  latitude: {
    type: Number,
    default: null
  },
  /** 地图容器唯一 ID（用于多个地图共存） */
  mapId: {
    type: String,
    default: 'delivery-map'
  },
  /** 弹窗是否可见（用于 map.resize） */
  dialogVisible: {
    type: Boolean,
    default: true
  }
})

const emit = defineEmits([])

const hasCoordinates = computed(() => {
  return props.longitude != null && props.latitude != null
})

const loading = ref(false)
const mapError = ref(false)
const routeInfo = ref(null)
let mapInstance = null

const { calculateDeliveryRoute } = useDeliveryMap()
const { load: loadAMap } = useAmap()

/**
 * 初始化地图并渲染配送路线
 */
const initMap = async () => {
  if (!hasCoordinates.value) return

  loading.value = true
  mapError.value = false
  routeInfo.value = null

  try {
    const AMap = await loadAMap()

    // 销毁旧地图
    if (mapInstance) {
      mapInstance.destroy()
      mapInstance = null
    }

    // 创建地图实例
    mapInstance = new AMap.Map(props.mapId, {
      viewMode: '2D',
      zoom: 13,
      center: [116.397428, 39.90923],
      mapStyle: 'amap://styles/normal'
    })

    // 计算路线并渲染
    const result = await calculateDeliveryRoute(
      mapInstance,
      props.longitude,
      props.latitude
    )

    routeInfo.value = result
  } catch (error) {
    console.error('配送地图初始化失败', error)
    mapError.value = true
  } finally {
    loading.value = false
  }
}

// 坐标变化时重新渲染
watch(
  () => [props.longitude, props.latitude],
  () => {
    if (hasCoordinates.value) {
      initMap()
    }
  }
)

// 弹窗重新显示时，通知地图重新计算尺寸
watch(() => props.dialogVisible, (visible) => {
  if (visible && mapInstance) {
    setTimeout(() => mapInstance.resize(), 100)
  }
})

// 组件挂载后初始化
onMounted(() => {
  if (hasCoordinates.value) {
    initMap()
  }
})

// 组件卸载时销毁地图
onUnmounted(() => {
  if (mapInstance) {
    mapInstance.destroy()
    mapInstance = null
  }
})
</script>

<style scoped>
.delivery-map-wrapper {
  width: 100%;
  margin: 10px 0;
}

.map-info-bar {
  display: flex;
  gap: 20px;
  padding: 8px 12px;
  background: #f0f9eb;
  border-radius: 4px;
  margin-bottom: 8px;
  font-size: 14px;
  color: #303133;
}

.map-info-bar.loading-bar {
  background: #f5f7fa;
  color: #909399;
}

.info-item {
  display: flex;
  align-items: center;
  gap: 4px;
}

.map-container {
  width: 100%;
  height: 280px;
  border-radius: 8px;
  border: 1px solid #e4e7ed;
  position: relative;
}

.map-container.map-error {
  display: flex;
  align-items: center;
  justify-content: center;
}

.map-error-msg {
  text-align: center;
  color: #909399;
}

.map-error-msg p {
  margin: 8px 0;
}

.no-coords-tip {
  margin-top: 8px;
}
</style>