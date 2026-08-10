<template>
  <div class="success-container">
    <div class="success-content">
      <el-icon :size="80" color="#67c23a"><SuccessFilled /></el-icon>
      <h2>订单提交成功</h2>
      <p>预计送达时间：{{ estimatedTime }}</p>
      <div class="order-info">
        <p>订单号：{{ orderNumber }}</p>
        <p>订单金额：¥{{ orderAmount }}</p>
      </div>
      <div class="countdown-info">
        <p>请在 <span class="countdown">{{ countdownText }}</span> 内完成支付</p>
      </div>
      <div class="actions">
        <el-button @click="goBack">返回</el-button>
        <el-button type="primary" @click="payOrder">立即支付</el-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { SuccessFilled } from '@element-plus/icons-vue'
import { payOrder as payOrderApi, cancelOrder as cancelOrderApi } from '@/api/order'

const router = useRouter()
const route = useRoute()

const estimatedTime = ref('30分钟')
const orderNumber = ref('')
const orderAmount = ref(0)
const orderId = ref('')
const countdown = ref(600) // 10分钟 = 600秒
let timer = null

const countdownText = computed(() => {
  const minutes = Math.floor(countdown.value / 60)
  const seconds = countdown.value % 60
  return `${minutes}分${seconds.toString().padStart(2, '0')}秒`
})

onMounted(async () => {
  // 从路由参数获取订单信息
  if (route.query.id) {
    orderId.value = route.query.id
    orderNumber.value = route.query.number || ''
    orderAmount.value = parseFloat(route.query.amount) || 0
  } else {
    // 从 localStorage 获取订单信息
    const orderInfo = localStorage.getItem('lastOrder')
    if (orderInfo) {
      const data = JSON.parse(orderInfo)
      orderNumber.value = data.number || ''
      orderAmount.value = data.amount || 0
      orderId.value = data.id || ''
    }
  }

  // 确保订单ID存在
  if (!orderId.value) {
    ElMessage.error('订单信息异常')
    router.push('/dashboard')
    return
  }

  // 计算剩余倒计时时间（基于开始时间）
  const startTimeKey = `order_countdown_start_${orderId.value}`
  const startTime = localStorage.getItem(startTimeKey)
  
  if (startTime) {
    // 使用已有的倒计时开始时间
    const elapsed = Math.floor((Date.now() - parseInt(startTime)) / 1000)
    countdown.value = Math.max(0, 600 - elapsed)
  } else {
    // 如果没有倒计时记录，设置新的（从10分钟开始）
    localStorage.setItem(startTimeKey, Date.now().toString())
    countdown.value = 600
  }

  // 检查是否已超时
  if (countdown.value <= 0) {
    localStorage.removeItem(startTimeKey)
    // 调用取消订单API
    try {
      await cancelOrderApi(orderId.value)
    } catch (error) {
      console.error('取消订单失败', error)
    }
    ElMessage.warning('支付超时，订单已取消')
    router.push('/dashboard')
    return
  }

  // 启动倒计时显示更新
  timer = setInterval(async () => {
    const start = parseInt(localStorage.getItem(startTimeKey))
    const elapsed = Math.floor((Date.now() - start) / 1000)
    countdown.value = Math.max(0, 600 - elapsed)

    if (countdown.value <= 0) {
      clearInterval(timer)
      localStorage.removeItem(startTimeKey)
      localStorage.removeItem('open_orders_dialog') // 清除弹窗标记
      await cancelOrderApi(orderId.value)
      ElMessage.warning('支付超时，订单已取消')
      router.replace('/dashboard') // 替换当前页
    }
  }, 1000)
})

onUnmounted(() => {
  if (timer) {
    clearInterval(timer)
  }
})

const goBack = () => {
  // 根据来源判断返回行为
  const from = route.query.from
  if (from === 'history') {
    // 从历史订单来的，返回个人中心并打开历史订单弹窗，保持分页状态
    localStorage.setItem('open_orders_dialog', 'true')
    router.push('/profile')
  } else {
    // 从新下单来的，返回主页
    router.push('/dashboard')
  }
}

const payOrder = async () => {
  try {
    const res = await payOrderApi({
      orderNumber: orderNumber.value,
      payMethod: 1
    })
    if (res.code === 1) {
      clearInterval(timer)
      // 清除倒计时记录
      localStorage.removeItem(`order_countdown_start_${orderId.value}`)
      ElMessage.success('支付成功')

      // 判断来源
      const from = route.query.from
      if (from === 'history') {
        // 从历史订单来的，返回个人中心并打开历史订单弹窗
        localStorage.setItem('open_orders_dialog', 'true')
        // 保留分页状态（如果有）
        // 可携带当前分页信息，但 profile 会读取 localStorage 中的 orders_pagination
        // 跳转前可设置分页信息（可选）
        router.replace('/profile')
      } else {
        // 从新下单来的，返回首页
        router.replace('/dashboard')
      }
    } else {
      ElMessage.error(res.msg || '支付失败')
    }
  } catch (error) {
    ElMessage.error('支付失败')
  }
}
</script>

<style scoped>
.success-container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.success-content {
  text-align: center;
  background: white;
  padding: 40px;
  border-radius: 16px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.success-content h2 {
  margin: 20px 0 10px;
  color: #333;
}

.success-content p {
  color: #666;
  margin: 10px 0;
}

.order-info {
  margin: 20px 0;
  padding: 15px;
  background: #f5f5f5;
  border-radius: 8px;
}

.countdown-info {
  margin: 20px 0;
  padding: 15px;
  background: #fff3e0;
  border-radius: 8px;
}

.countdown {
  color: #ff6b00;
  font-weight: bold;
  font-size: 18px;
}

.actions {
  margin-top: 30px;
  display: flex;
  gap: 20px;
  justify-content: center;
}
</style>