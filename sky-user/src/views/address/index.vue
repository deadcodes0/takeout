<template>
  <div class="address-container">
    <div class="address-header">
      <el-button @click="goBack" :icon="ArrowLeft" circle></el-button>
      <h2>收货地址</h2>
      <el-button type="primary" @click="showAddDialog">新增地址</el-button>
    </div>

    <!-- 地址列表 -->
    <div class="address-list">
      <div v-if="addressList.length > 0">
        <div
          v-for="address in addressList"
          :key="address.id"
          class="address-item"
        >
          <div class="address-content">
            <div class="address-top">
              <span class="name">{{ address.consignee }}</span>
              <span class="phone">{{ address.phone }}</span>
              <el-tag v-if="address.sex === '1'" size="small">先生</el-tag>
              <el-tag v-else size="small">女士</el-tag>
              <el-tag v-if="address.label" type="info" size="small">{{ address.label }}</el-tag>
              <el-tag v-if="address.isDefault === 1" type="success" size="small">默认</el-tag>
            </div>
            <p class="address-detail">
              {{ address.provinceName }}{{ address.cityName }}{{ address.districtName }}{{ address.detail }}
            </p>
          </div>
          <div class="address-actions">
            <el-button
              v-if="address.isDefault !== 1"
              type="success"
              size="small"
              @click="setDefault(address)"
            >
              设为默认
            </el-button>
            <el-button type="primary" size="small" @click="editAddress(address)">
              编辑
            </el-button>
            <el-button type="danger" size="small" @click="deleteAddress(address)">
              删除
            </el-button>
          </div>
        </div>
      </div>
      <el-empty v-else description="暂无收货地址" />
    </div>

    <!-- 新增/编辑地址弹窗 -->
    <el-dialog
      v-model="dialogVisible"
      :title="isEdit ? '编辑地址' : '新增地址'"
      width="500px"
    >
      <el-form :model="addressForm" :rules="rules" ref="formRef" label-width="80px">
        <el-form-item label="收货人" prop="consignee">
          <el-input v-model="addressForm.consignee" placeholder="请输入收货人姓名" />
        </el-form-item>
        <el-form-item label="性别" prop="sex">
          <el-radio-group v-model="addressForm.sex">
            <el-radio label="1">先生</el-radio>
            <el-radio label="0">女士</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="addressForm.phone" placeholder="请输入手机号" />
        </el-form-item>
        <el-form-item label="省份" prop="provinceName">
          <el-input v-model="addressForm.provinceName" placeholder="请输入省份" />
        </el-form-item>
        <el-form-item label="城市" prop="cityName">
          <el-input v-model="addressForm.cityName" placeholder="请输入城市" />
        </el-form-item>
        <el-form-item label="区县" prop="districtName">
          <el-input v-model="addressForm.districtName" placeholder="请输入区县" />
        </el-form-item>
        <el-form-item label="详细地址" prop="detail">
          <el-input
            v-model="addressForm.detail"
            type="textarea"
            :rows="2"
            placeholder="请输入详细地址（街道、门牌号等）"
          />
          <el-button
            type="primary"
            link
            @click="showLocationPicker"
            style="margin-top: 8px"
          >
            <el-icon><Location /></el-icon>
            获取当前位置
          </el-button>
        </el-form-item>
        <el-form-item label="标签" prop="label">
          <el-radio-group v-model="addressForm.label">
            <el-radio label="家">家</el-radio>
            <el-radio label="公司">公司</el-radio>
            <el-radio label="学校">学校</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="设为默认">
          <el-switch v-model="addressForm.isDefault" :active-value="1" :inactive-value="0" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="submitting" @click="submitAddress">
          确定
        </el-button>
      </template>
    </el-dialog>

    <!-- 地图定位弹窗 -->
    <LocationPicker
      v-model="locationPickerVisible"
      @confirm="handleLocationConfirm"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ArrowLeft, Location } from '@element-plus/icons-vue'
import LocationPicker from '@/components/LocationPicker.vue'
import {
  getAddressList,
  addAddress,
  updateAddress,
  deleteAddress as deleteAddressApi,
  setDefaultAddress
} from '@/api/address'
import { useDeliveryMap } from '@/composables/useDeliveryMap'

const { geocodeAddress } = useDeliveryMap()

const router = useRouter()

// 返回上一页
const goBack = () => {
  router.back()
}

// 地址列表
const addressList = ref([])

// 弹窗
const dialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref(null)
const submitting = ref(false)
const locationPickerVisible = ref(false)

// 地址表单
const addressForm = reactive({
  id: null,
  consignee: '',
  sex: '1',
  phone: '',
  provinceCode: '',
  provinceName: '',
  cityCode: '',
  cityName: '',
  districtCode: '',
  districtName: '',
  detail: '',
  label: '家',
  isDefault: 0
})

// 表单验证规则
const rules = {
  consignee: [{ required: true, message: '请输入收货人姓名', trigger: 'blur' }],
  sex: [{ required: true, message: '请选择性别', trigger: 'change' }],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ],
  provinceName: [{ required: true, message: '请输入省份', trigger: 'blur' }],
  cityName: [{ required: true, message: '请输入城市', trigger: 'blur' }],
  districtName: [{ required: true, message: '请输入区县', trigger: 'blur' }],
  detail: [{ required: true, message: '请输入详细地址', trigger: 'blur' }],
  label: [{ required: true, message: '请选择标签', trigger: 'change' }]
}

// 初始化
onMounted(async () => {
  await loadAddressList()
})

// 加载地址列表
const loadAddressList = async () => {
  try {
    const res = await getAddressList()
    if (res.code === 1) {
      addressList.value = res.data || []
    }
  } catch (error) {
    console.error('加载地址失败', error)
  }
}

// 显示新增弹窗
const showAddDialog = () => {
  isEdit.value = false
  resetForm()
  dialogVisible.value = true
}

// 编辑地址
const editAddress = (address) => {
  isEdit.value = true
  Object.assign(addressForm, {
    id: address.id,
    consignee: address.consignee,
    sex: address.sex,
    phone: address.phone,
    provinceCode: address.provinceCode,
    provinceName: address.provinceName,
    cityCode: address.cityCode,
    cityName: address.cityName,
    districtCode: address.districtCode,
    districtName: address.districtName,
    detail: address.detail,
    label: address.label || '家',
    isDefault: address.isDefault
  })
  dialogVisible.value = true
}

// 重置表单
const resetForm = () => {
  Object.assign(addressForm, {
    id: null,
    consignee: '',
    sex: '1',
    phone: '',
    provinceCode: '',
    provinceName: '',
    cityCode: '',
    cityName: '',
    districtCode: '',
    districtName: '',
    detail: '',
    label: '家',
    isDefault: 0
  })
}

// 提交地址
const submitAddress = async () => {
  if (!formRef.value) return

  await formRef.value.validate(async (valid) => {
    if (valid) {
      // 自动生成行政区划代码（直接使用地址名称）
      // 注意：这不是标准的行政区划代码，仅用于满足后端验证要求
      if (!addressForm.provinceCode && addressForm.provinceName) {
        addressForm.provinceCode = addressForm.provinceName
      }
      if (!addressForm.cityCode && addressForm.cityName) {
        addressForm.cityCode = addressForm.cityName
      }
      if (!addressForm.districtCode && addressForm.districtName) {
        addressForm.districtCode = addressForm.districtName
      }

      submitting.value = true
      try {
        // 获取坐标：用完整地址进行地理编码
        const fullAddress = `${addressForm.provinceName}${addressForm.cityName}${addressForm.districtName}${addressForm.detail}`
        try {
          const coords = await geocodeAddress(fullAddress, addressForm.cityName)
          addressForm.latitude = coords.latitude
          addressForm.longitude = coords.longitude
        } catch (geoError) {
          console.warn('地理编码失败，地址将无坐标信息', geoError)
          // 地理编码失败不影响地址保存
        }

        const res = isEdit.value
          ? await updateAddress(addressForm)
          : await addAddress(addressForm)

        if (res.code === 1) {
          ElMessage.success(isEdit.value ? '修改成功' : '添加成功')
          dialogVisible.value = false
          await loadAddressList()
        } else {
          ElMessage.error(res.msg || '操作失败')
        }
      } catch (error) {
        ElMessage.error('操作失败')
      } finally {
        submitting.value = false
      }
    }
  })
}

// 设为默认地址
const setDefault = async (address) => {
  try {
    const res = await setDefaultAddress(address.id)
    if (res.code === 1) {
      ElMessage.success('设置成功')
      await loadAddressList()
    } else {
      ElMessage.error(res.msg || '设置失败')
    }
  } catch (error) {
    ElMessage.error('设置失败')
  }
}

// 删除地址
const deleteAddress = async (address) => {
  try {
    await ElMessageBox.confirm('确定删除该地址吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })

    const res = await deleteAddressApi(address.id)
    if (res.code === 1) {
      ElMessage.success('删除成功')
      await loadAddressList()
    } else {
      ElMessage.error(res.msg || '删除失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

// 显示地图定位弹窗
const showLocationPicker = () => {
  locationPickerVisible.value = true
}

// 处理位置选择
const handleLocationConfirm = (location) => {
  console.log('选择的位置：', location)

  // 填充详细地址
  addressForm.detail = location.address || ''

  // 填充省市区信息
  if (location.province && location.city && location.district) {
    addressForm.provinceName = location.province
    addressForm.cityName = location.city
    addressForm.districtName = location.district
    ElMessage.success('位置信息已完整填充')
  } else {
    ElMessage.warning('详细地址已填充，请手动输入省市区信息')
  }
}
</script>

<style scoped>
.address-container {
  min-height: 100vh;
  background: #f5f5f5;
  padding: 20px;
}

.address-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.address-header h2 {
  margin: 0;
}

.address-list {
  background: white;
  border-radius: 8px;
}

.address-item {
  padding: 15px;
  border-bottom: 1px solid #eee;
}

.address-item:last-child {
  border-bottom: none;
}

.address-content {
  margin-bottom: 10px;
}

.address-top {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 5px;
}

.address-top .name {
  font-weight: bold;
  font-size: 16px;
}

.address-top .phone {
  color: #666;
}

.address-detail {
  color: #666;
  font-size: 14px;
}

.address-actions {
  display: flex;
  gap: 10px;
}
</style>