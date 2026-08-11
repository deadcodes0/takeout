<template>
  <div class="order-container">
    <!-- 页面头部 -->
    <div class="page-header">
      <el-button @click="goBack" :icon="ArrowLeft" circle></el-button>
      <h2>确认订单</h2>
    </div>

    <!-- 收货地址 -->
    <div class="address-section">
      <div class="address-header">
        <h3>收货地址</h3>
        <el-button type="primary" size="small" @click="goToAddress">
          选择地址
        </el-button>
      </div>
      <div v-if="selectedAddress" class="address-info">
        <p class="address-name">
          <span class="name">{{ selectedAddress.consignee }}</span>
          <span class="phone">{{ selectedAddress.phone }}</span>
          <el-tag v-if="selectedAddress.sex === '1'" size="small">先生</el-tag>
          <el-tag v-else size="small">女士</el-tag>
        </p>
        <p class="address-detail">
          {{ selectedAddress.provinceName }}{{ selectedAddress.cityName }}{{ selectedAddress.districtName }}{{ selectedAddress.detail }}
        </p>
      </div>
      <div v-else class="no-address">
        <p>请选择收货地址</p>
      </div>
    </div>

    <!-- 订单商品 -->
    <div class="order-items-section">
      <h3>订单商品</h3>
      <div class="order-items">
        <div v-for="item in cartList" :key="item.id" class="order-item">
          <img :src="item.image" :alt="item.name" class="item-image" />
          <div class="item-info">
            <h4>{{ item.name }}</h4>
            <p v-if="item.dishFlavor" class="item-flavor">{{ item.dishFlavor }}</p>
            <p class="item-price">¥{{ item.amount }}</p>
          </div>
          <div class="item-quantity">x{{ item.number }}</div>
        </div>
      </div>
    </div>

    <!-- 订单备注 -->
    <div class="remark-section">
      <h3>订单备注</h3>
      <el-input
        v-model="remark"
        type="textarea"
        :rows="3"
        placeholder="请输入订单备注（可选）"
      />
    </div>

    <!-- 预计送达时间 -->
    <div class="delivery-time-section">
      <h3>预计送达时间</h3>
      <div class="delivery-options">
        <el-radio-group v-model="deliveryStatus">
          <el-radio :value="1">立即送出</el-radio>
          <el-radio :value="0">选择具体时间</el-radio>
        </el-radio-group>
        <el-time-select
          v-if="deliveryStatus === 0"
          v-model="deliveryTime"
          :start="minDeliveryTime"
          step="00:30"
          end="22:00"
          placeholder="选择送达时间"
          style="margin-top: 10px; width: 100%"
        />
        <!-- 显示预计送达时间点 -->
        <div class="delivery-time-display" v-if="estimatedDeliveryTimeDisplay">
          <el-icon><Clock /></el-icon>
          <span>预计送达时间：{{ estimatedDeliveryTimeDisplay }}</span>
        </div>
      </div>
    </div>

    <!-- 优惠券 -->
    <div class="coupon-section">
      <div class="coupon-header">
        <h3>优惠券</h3>
        <el-button type="primary" size="small" @click="openCouponDialog">
          {{ selectedCouponIds.length > 0 ? `已选${selectedCouponIds.length}张` : '选择优惠券' }}
        </el-button>
      </div>
      <div v-if="selectedCoupons.length > 0" class="selected-coupons">
        <div v-for="c in selectedCoupons" :key="c.id" class="selected-coupon-item">
          <span class="coupon-name">{{ c.name }}</span>
          <span class="coupon-discount">-¥{{ calcCouponDiscount(c).toFixed(2) }}</span>
        </div>
        <el-button text size="small" @click="clearCoupons">清除</el-button>
      </div>
      <div v-else-if="couponList.length === 0" class="no-coupon">
        <span>暂无可用优惠券</span>
      </div>
      <div v-else class="no-coupon">
        <span>有 {{ couponList.length }} 张可用优惠券，点击选择</span>
      </div>
    </div>

    <!-- 订单金额 -->
    <div class="amount-section">
      <div class="amount-row">
        <span>商品金额</span>
        <span class="amount-value">¥{{ goodsAmount.toFixed(2) }}</span>
      </div>
      <div class="amount-row">
        <span>打包费</span>
        <span class="amount-value">¥{{ packAmount.toFixed(2) }}</span>
      </div>
      <div class="amount-row">
        <span>配送费</span>
        <span class="amount-value">¥6.00</span>
      </div>
      <div class="amount-row" v-if="couponDiscount > 0">
        <span>优惠券</span>
        <span class="amount-value" style="color: #67c23a;">-¥{{ couponDiscount.toFixed(2) }}</span>
      </div>
      <div class="amount-row total">
        <span>合计</span>
        <span class="amount-value">¥{{ totalAmount.toFixed(2) }}</span>
      </div>
    </div>

    <!-- 提交按钮 -->
    <div class="submit-section">
      <el-button
        type="warning"
        size="large"
        :disabled="!selectedAddress || cartList.length === 0"
        :loading="submitting"
        @click="submitOrder"
      >
        提交订单
      </el-button>
    </div>

    <!-- 地址选择弹窗 -->
    <el-dialog v-model="addressDialogVisible" title="选择收货地址" width="500px">
      <div v-if="addressList.length > 0">
        <div
          v-for="address in addressList"
          :key="address.id"
          class="address-option"
          :class="{ selected: selectedAddress?.id === address.id }"
          @click="selectAddress(address)"
        >
          <div class="address-option-header">
            <span class="name">{{ address.consignee }}</span>
            <span class="phone">{{ address.phone }}</span>
            <el-tag v-if="address.isDefault === 1" type="success" size="small">默认</el-tag>
          </div>
          <p class="address-option-detail">
            {{ address.provinceName }}{{ address.cityName }}{{ address.districtName }}{{ address.detail }}
          </p>
        </div>
      </div>
      <el-empty v-else description="暂无收货地址" />
      <template #footer>
        <el-button @click="goToAddressManage">新增地址</el-button>
        <el-button type="primary" @click="addressDialogVisible = false">确定</el-button>
      </template>
    </el-dialog>

    <!-- 优惠券选择弹窗 -->
    <el-dialog v-model="couponDialogVisible" title="选择优惠券" width="500px">
      <div v-if="couponList.length > 0" class="coupon-select-list">
        <div
          v-for="c in couponList"
          :key="c.id"
          class="coupon-select-item"
          :class="{
            selected: tempSelectedIds.includes(c.id),
            disabled: goodsAmount < (c.minAmount || 0)
          }"
          @click="goodsAmount >= (c.minAmount || 0) && toggleCoupon(c)"
        >
          <div class="coupon-select-left">
            <span class="value" v-if="c.discountType === 'PERCENT'">
              {{ (c.discountValue * 10).toFixed(1) }}折
            </span>
            <span class="value" v-else>¥{{ c.discountValue }}</span>
          </div>
          <div class="coupon-select-right">
            <div class="name">{{ c.name }}</div>
            <div class="condition">满{{ c.minAmount || 0 }}可用
              <el-tag v-if="c.isStackable === 1" size="small" type="warning">可叠加</el-tag>
            </div>
            <div class="discount">可优惠 ¥{{ calcCouponDiscount(c).toFixed(2) }}</div>
            <div class="time">{{ c.validStartTime }} ~ {{ c.validEndTime }}</div>
          </div>
          <div class="coupon-select-check">
            <el-icon v-if="tempSelectedIds.includes(c.id)" color="#ff6b6b"><Select /></el-icon>
          </div>
        </div>
      </div>
      <el-empty v-else description="暂无可用优惠券" />
      <template #footer>
        <el-button @click="couponDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="confirmCoupons">
          确定（{{ tempSelectedIds.length }}张）
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft, Clock, Select } from '@element-plus/icons-vue'
import { getShoppingCartList } from '@/api/shoppingCart'
import { getAddressList } from '@/api/address'
import { submitOrder as submitOrderApi } from '@/api/order'
import { getMyCoupons } from '@/api/coupon'

const router = useRouter()

// 返回上一页
const goBack = () => {
  router.back()
}

// 购物车列表
const cartList = ref([])

// 地址列表
const addressList = ref([])
const selectedAddress = ref(null)
const addressDialogVisible = ref(false)

// 订单备注
const remark = ref('')
const deliveryStatus = ref(1) // 1立即送出，0选择具体时间
const deliveryTime = ref('') // 具体送达时间

// 提交状态
const submitting = ref(false)

// 优惠券相关
const couponList = ref([])        // 用户未使用的优惠券
const selectedCouponIds = ref([])  // 选中的优惠券id数组
const couponDialogVisible = ref(false)
const tempSelectedIds = ref([])    // 弹窗中临时选中的id

// 计算商品金额
const goodsAmount = computed(() => {
  return cartList.value.reduce((total, item) => total + item.amount * item.number, 0)
})

// 计算打包费（每个商品1元打包费）
const packAmount = computed(() => {
  return cartList.value.reduce((sum, item) => sum + item.number, 0)
})

// 计算总金额
const totalAmount = computed(() => {
  const beforeCoupon = goodsAmount.value + packAmount.value + 6  // 商品金额 + 打包费 + 配送费
  const final = beforeCoupon - couponDiscount.value
  return final > 0 ? final : 0
})

// 计算优惠券优惠金额（基于商品总额，与后端 calculateDiscount 逻辑一致）
const couponDiscount = computed(() => {
  if (selectedCouponIds.value.length === 0) return 0
  let total = 0
  for (const id of selectedCouponIds.value) {
    const c = couponList.value.find(item => item.id === id)
    if (!c) continue
    let discount = 0
    if (c.discountType === 'PERCENT') {
      discount = goodsAmount.value * (1 - c.discountValue)
      if (c.maxDiscountAmount != null && discount > c.maxDiscountAmount) {
        discount = c.maxDiscountAmount
      }
    } else {
      discount = c.discountValue || 0
    }
    total += discount
  }
  // 优惠不能超过商品总额
  return total > goodsAmount.value ? goodsAmount.value : total
})

// 选中的优惠券详情列表（用于展示）
const selectedCoupons = computed(() => {
  return selectedCouponIds.value.map(id => couponList.value.find(c => c.id === id)).filter(Boolean)
})

// 计算单张券的优惠金额（弹窗中展示用）
const calcCouponDiscount = (c) => {
  if (!c) return 0
  if (c.discountType === 'PERCENT') {
    let d = goodsAmount.value * (1 - c.discountValue)
    if (c.maxDiscountAmount != null && d > c.maxDiscountAmount) d = c.maxDiscountAmount
    return d
  }
  return c.discountValue || 0
}

// 打开优惠券选择弹窗
const openCouponDialog = () => {
  tempSelectedIds.value = [...selectedCouponIds.value]
  couponDialogVisible.value = true
}

// 切换优惠券选择
const toggleCoupon = (coupon) => {
  const idx = tempSelectedIds.value.indexOf(coupon.id)
  if (idx > -1) {
    // 取消选中
    tempSelectedIds.value.splice(idx, 1)
  } else {
    // 选中前检查叠加规则
    if (tempSelectedIds.value.length > 0) {
      // 已有选中的券，检查是否都可叠加
      const allStackable = tempSelectedIds.value.every(id => {
        const c = couponList.value.find(item => item.id === id)
        return c && c.isStackable === 1
      })
      if (!allStackable || coupon.isStackable !== 1) {
        ElMessage.warning('当前已选含不可叠加优惠券，无法继续添加')
        return
      }
    }
    tempSelectedIds.value.push(coupon.id)
  }
}

// 确认优惠券选择
const confirmCoupons = () => {
  selectedCouponIds.value = [...tempSelectedIds.value]
  couponDialogVisible.value = false
}

// 清除已选优惠券
const clearCoupons = () => {
  selectedCouponIds.value = []
}

// 计算最小送达时间（当前时间+60分钟）
const minDeliveryTime = computed(() => {
  const now = new Date()
  now.setMinutes(now.getMinutes() + 60)
  const hours = now.getHours().toString().padStart(2, '0')
  const minutes = now.getMinutes().toString().padStart(2, '0')
  return `${hours}:${minutes}`
})

// 计算预计送达时间显示
const estimatedDeliveryTimeDisplay = computed(() => {
  if (deliveryStatus.value === 1) {
    // 立即送出：当前时间+60分钟
    const now = new Date()
    now.setMinutes(now.getMinutes() + 60)
    return now.toLocaleString('zh-CN', {
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    })
  } else if (deliveryTime.value) {
    // 选择具体时间：今天的日期 + 用户选择的时间
    const today = new Date()
    const [hours, minutes] = deliveryTime.value.split(':')
    const deliveryDate = new Date(today.getFullYear(), today.getMonth(), today.getDate(), parseInt(hours), parseInt(minutes))
    return deliveryDate.toLocaleString('zh-CN', {
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    })
  }
  return ''
})

// 初始化
onMounted(async () => {
  await loadCart()
  await loadAddress()
  await loadCoupons()
})

// 加载购物车
const loadCart = async () => {
  try {
    const res = await getShoppingCartList()
    if (res.code === 1) {
      cartList.value = res.data || []
    }
  } catch (error) {
    console.error('加载购物车失败', error)
  }
}

// 加载地址
const loadAddress = async () => {
  try {
    // 获取所有地址
    const res = await getAddressList()
    if (res.code === 1) {
      addressList.value = res.data || []
      // 从地址列表中找到默认地址
      const defaultAddr = addressList.value.find(addr => addr.isDefault === 1)
      if (defaultAddr) {
        selectedAddress.value = defaultAddr
      } else if (addressList.value.length > 0) {
        // 如果没有默认地址，选择第一个地址
        selectedAddress.value = addressList.value[0]
      }
    }
  } catch (error) {
    console.error('加载地址失败', error)
  }
}

// 选择地址
const selectAddress = (address) => {
  selectedAddress.value = address
}

// 加载可用优惠券（未使用状态）
const loadCoupons = async () => {
  try {
    const res = await getMyCoupons({ status: 0, page: 1, pageSize: 100 })
    if (res.code === 1) {
      couponList.value = res.data.records || []
    }
  } catch (error) {
    console.error('加载优惠券失败', error)
  }
}

// 打开地址选择弹窗
const goToAddress = () => {
  addressDialogVisible.value = true
}

// 前往地址管理
const goToAddressManage = () => {
  router.push('/address')
}

// 提交订单
const submitOrder = async () => {
  if (!selectedAddress.value) {
    ElMessage.warning('请选择收货地址')
    return
  }

  if (cartList.value.length === 0) {
    ElMessage.warning('购物车是空的')
    return
  }

  if (deliveryStatus.value === 0 && !deliveryTime.value) {
    ElMessage.warning('请选择送达时间')
    return
  }

  submitting.value = true
  try {
    // 计算商品金额
    const goodsAmount = cartList.value.reduce((sum, item) => {
      return sum + item.number * item.amount
    }, 0)

    // 计算打包费（每个商品1元打包费）
    const packAmount = cartList.value.reduce((sum, item) => {
      return sum + item.number
    }, 0)

    // 计算总金额（商品金额 + 打包费 + 配送费6元 - 优惠券优惠）
    const orderTotalAmount = Math.max(0, goodsAmount + packAmount + 6 - couponDiscount.value)

    // 计算预计送达时间
    let estimatedDeliveryTime
    if (deliveryStatus.value === 1) {
      // 立即送出：当前时间+60分钟（增加足够缓冲）
      estimatedDeliveryTime = new Date(Date.now() + 60 * 60 * 1000)
    } else {
      // 选择具体时间：今天的日期 + 用户选择的时间
      const today = new Date()
      const [hours, minutes] = deliveryTime.value.split(':')
      estimatedDeliveryTime = new Date(today.getFullYear(), today.getMonth(), today.getDate(), parseInt(hours), parseInt(minutes))
      
      // 如果选择的时间已经过去或即将过去（小于30分钟），增加缓冲时间
      if (estimatedDeliveryTime.getTime() <= Date.now() + 30 * 60 * 1000) {
        estimatedDeliveryTime = new Date(Date.now() + 60 * 60 * 1000)
      }
    }

    // 格式化时间为 yyyy-MM-dd HH:mm:ss
    const year = estimatedDeliveryTime.getFullYear()
    const month = String(estimatedDeliveryTime.getMonth() + 1).padStart(2, '0')
    const day = String(estimatedDeliveryTime.getDate()).padStart(2, '0')
    const hour = String(estimatedDeliveryTime.getHours()).padStart(2, '0')
    const minute = String(estimatedDeliveryTime.getMinutes()).padStart(2, '0')
    const second = String(estimatedDeliveryTime.getSeconds()).padStart(2, '0')
    const formattedTime = `${year}-${month}-${day} ${hour}:${minute}:${second}`

    const res = await submitOrderApi({
      addressBookId: selectedAddress.value.id,
      payMethod: 1, // 微信支付
      estimatedDeliveryTime: formattedTime,
      deliveryStatus: deliveryStatus.value, // 配送状态
      tablewareNumber: 0, // 餐具数量
      tablewareStatus: 1, // 按餐量提供
      packAmount: packAmount,
      amount: orderTotalAmount,
      remark: remark.value,
      couponIds: selectedCouponIds.value.length > 0 ? selectedCouponIds.value.join(',') : undefined
    })

    if (res.code === 1) {
      ElMessage.success('订单提交成功')
      // 清除之前的订单信息
      localStorage.removeItem('lastOrder')
      
      // 保存订单信息到 localStorage
      const orderData = res.data || {}
      const orderId = orderData.id || orderData.orderId || orderData.order_id
      const orderNumber = orderData.number || orderData.orderNumber || orderData.order_number
      
      if (!orderId) {
        console.error('订单ID未返回', orderData)
        ElMessage.error('订单创建异常，请稍后重试')
        return
      }
      
      // 设置该订单的倒计时开始时间（新订单总是从10分钟开始）
      localStorage.setItem(`order_countdown_start_${orderId}`, Date.now().toString())
      
      localStorage.setItem('lastOrder', JSON.stringify({
        id: orderId,
        number: orderNumber,
        amount: orderTotalAmount
      }))
      // 跳转到支付页面（不传递 from 参数，表示是新下单）
      router.push({
        path: '/order-success',
        query: {
          id: orderId,
          number: orderNumber,
          amount: orderTotalAmount
        }
      })
    } else {
      ElMessage.error(res.msg || '提交失败')
    }
  } catch (error) {
    console.error('提交订单失败', error)
    if (error.response && error.response.data) {
      ElMessage.error(error.response.data.msg || '提交失败')
    } else if (error.message) {
      ElMessage.error(error.message)
    } else {
      ElMessage.error('提交失败，请检查后端服务是否启动')
    }
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.order-container {
  min-height: 100vh;
  background: #f5f5f5;
  padding: 20px;
}

.page-header {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 20px;
}

.page-header h2 {
  margin: 0;
}

.address-section,
.order-items-section,
.remark-section,
.delivery-time-section,
.amount-section {
  background: white;
  padding: 15px;
  margin-bottom: 10px;
  border-radius: 8px;
}

.address-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.address-header h3,
.order-items-section h3,
.remark-section h3,
.delivery-time-section h3 {
  margin: 0;
  font-size: 16px;
}

.address-info {
  padding: 10px 0;
}

.address-name {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 5px;
}

.address-name .name {
  font-weight: bold;
  font-size: 16px;
}

.address-name .phone {
  color: #666;
}

.address-detail {
  color: #666;
  font-size: 14px;
}

.no-address {
  padding: 20px;
  text-align: center;
  color: #999;
}

.order-items {
  margin-top: 10px;
}

.order-item {
  display: flex;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px solid #eee;
}

.order-item:last-child {
  border-bottom: none;
}

.item-image {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
  margin-right: 10px;
}

.item-info {
  flex: 1;
}

.item-info h4 {
  margin: 0;
  font-size: 14px;
}

.item-flavor {
  color: #999;
  font-size: 12px;
  margin: 5px 0;
}

.item-price {
  color: #ff6b6b;
  font-size: 14px;
}

.item-quantity {
  color: #666;
  font-size: 14px;
}

.amount-section {
  padding: 15px;
}

.amount-row {
  display: flex;
  justify-content: space-between;
  padding: 8px 0;
  color: #666;
}

.amount-row.total {
  border-top: 1px solid #eee;
  margin-top: 10px;
  padding-top: 15px;
  color: #333;
  font-weight: bold;
}

.amount-value {
  color: #ff6b6b;
}

.delivery-options {
  margin-top: 10px;
}

.delivery-time-display {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 15px;
  padding: 10px;
  background: #fff7e6;
  border-radius: 8px;
  color: #ff9800;
  font-size: 14px;
}

.delivery-time-display .el-icon {
  font-size: 18px;
}

.submit-section {
  padding: 20px;
  text-align: center;
}

.submit-section .el-button {
  width: 100%;
}

.address-option {
  padding: 15px;
  border: 1px solid #eee;
  border-radius: 8px;
  margin-bottom: 10px;
  cursor: pointer;
  transition: all 0.3s;
}

.address-option:hover {
  border-color: #409eff;
}

.address-option.selected {
  border-color: #409eff;
  background: #f0f9ff;
}

.address-option-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 5px;
}

.address-option-header .name {
  font-weight: bold;
}

.address-option-detail {
  color: #666;
  font-size: 14px;
}

/* 优惠券样式 */
.coupon-section {
  background: white;
  padding: 15px;
  margin-bottom: 10px;
  border-radius: 8px;
}

.coupon-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.coupon-header h3 {
  margin: 0;
  font-size: 16px;
}

.selected-coupons {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  align-items: center;
}

.selected-coupon-item {
  display: flex;
  align-items: center;
  gap: 6px;
  background: #fff0f0;
  padding: 4px 10px;
  border-radius: 6px;
  font-size: 13px;
}

.selected-coupon-item .coupon-discount {
  color: #ff6b6b;
  font-weight: bold;
}

.no-coupon {
  color: #999;
  font-size: 14px;
  padding: 5px 0;
}

/* 优惠券选择弹窗样式 */
.coupon-select-list {
  max-height: 400px;
  overflow-y: auto;
}

.coupon-select-item {
  display: flex;
  align-items: center;
  padding: 12px;
  border: 2px solid #eee;
  border-radius: 8px;
  margin-bottom: 10px;
  cursor: pointer;
  transition: all 0.2s;
  gap: 12px;
}

.coupon-select-item:hover {
  border-color: #ffb3b3;
}

.coupon-select-item.selected {
  border-color: #ff6b6b;
  background: #fff8f8;
}

.coupon-select-item.disabled {
  opacity: 0.4;
  cursor: not-allowed;
}

.coupon-select-left {
  min-width: 70px;
  text-align: center;
}

.coupon-select-left .value {
  font-size: 20px;
  font-weight: bold;
  color: #ff6b6b;
}

.coupon-select-right {
  flex: 1;
}

.coupon-select-right .name {
  font-weight: bold;
  font-size: 14px;
  margin-bottom: 4px;
}

.coupon-select-right .condition {
  font-size: 12px;
  color: #666;
  margin-bottom: 2px;
}

.coupon-select-right .discount {
  font-size: 13px;
  color: #ff6b6b;
  font-weight: bold;
}

.coupon-select-right .time {
  font-size: 11px;
  color: #999;
}

.coupon-select-check {
  width: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>