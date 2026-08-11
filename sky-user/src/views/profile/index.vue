<template>
  <div class="profile-container">
    <!-- 页面头部 -->
    <div class="page-header">
      <el-button @click="goBack" :icon="ArrowLeft" circle></el-button>
      <h2>个人中心</h2>
    </div>

    <!-- 用户信息 -->
    <div class="user-section">
      <div class="user-avatar">
        <el-avatar :size="80" :src="userStore.avatar || '/avatar.png'">
          {{ userStore.name || '用户' }}
        </el-avatar>
      </div>
      <div class="user-info">
        <h3>{{ userStore.name || '用户' }}</h3>
        <p>手机号：{{ userStore.formattedPhone }}</p>
        <p>性别：{{ userStore.formattedSex }}</p>
      </div>
    </div>

    <!-- 功能菜单 -->
    <div class="menu-section">
      <el-menu @select="handleMenuSelect">
        <el-menu-item index="editProfile">
          <el-icon><User /></el-icon>
          <span>修改个人信息</span>
        </el-menu-item>
        <el-menu-item index="/orders">
          <el-icon><Document /></el-icon>
          <span>历史订单</span>
        </el-menu-item>
        <el-menu-item index="/favorites">
          <el-icon><Star /></el-icon>
          <span>收藏菜品</span>
        </el-menu-item>
        <el-menu-item index="/coupons">
          <el-icon><Ticket /></el-icon>
          <span>我的优惠券</span>
        </el-menu-item>
        <el-menu-item index="/address">
          <el-icon><Location /></el-icon>
          <span>收货地址</span>
        </el-menu-item>
        <el-menu-item index="logout">
          <el-icon><SwitchButton /></el-icon>
          <span>退出登录</span>
        </el-menu-item>
      </el-menu>
    </div>

    <!-- 历史订单弹窗 -->
    <el-dialog v-model="ordersDialogVisible" title="历史订单" width="600px">
      <div v-if="orderList.length > 0">
        <div
          v-for="order in orderList"
          :key="order.id"
          class="order-item"
        >
          <div class="order-header">
            <span class="order-number">订单号：{{ order.number }}</span>
            <el-tag :type="getStatusType(order.status)" size="small">
              {{ getStatusText(order.status) }}
            </el-tag>
          </div>
          <div class="order-time">
            下单时间：{{ order.orderTime }}
          </div>
          <div class="order-amount">
            订单金额：¥{{ order.amount }}
          </div>
          <div class="order-actions">
            <el-button
              type="info"
              size="small"
              @click="handleViewDetail(order.id)"
            >
              查看详情
            </el-button>
            <el-button
              v-if="order.status === 1"
              type="primary"
              size="small"
              @click="goToPay(order)"
            >
              立即支付
            </el-button>
            <el-button
              v-if="order.status === 1 || order.status === 2 || order.status === 3"
              type="danger"
              size="small"
              @click="handleCancelOrder(order.id)"
            >
              取消订单
            </el-button>
            <el-button
              v-if="order.status === 5"
              type="primary"
              size="small"
              @click="handleRepetitionOrder(order.id)"
            >
              再来一单
            </el-button>
            <el-button
              v-if="order.status === 2 || order.status === 3"
              type="warning"
              size="small"
              @click="handleReminderOrder(order.id)"
            >
              催单
            </el-button>
            <el-button
              v-if="order.status === 3 || order.status === 4 || order.status === 5"
              type="info"
              size="small"
              @click="showDeliveryRoute(order)"
            >
              配送路线
            </el-button>
          </div>

          <!-- 评价区域（仅已完成订单） -->
          <div v-if="order.status === 5" class="review-section">
            <!-- 未评价：显示评价表单 -->
            <div v-if="!order.reviewed" class="review-form">
              <div class="review-title">
                <el-icon style="color: #f7b731;"><Star /></el-icon>
                <span style="font-weight: 600;">评价此订单</span>
              </div>

              <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 12px;">
                <span style="font-size: 14px; color: #4e5a6b; font-weight: 500; min-width: 60px;">评分</span>
                <el-rate
                  v-model="order.tempScore"
                  :texts="['很差', '较差', '一般', '满意', '非常满意']"
                  show-text
                  :colors="['#f56c6c', '#e6a23c', '#67c23a', '#409eff', '#409eff']"
                />
                <span v-if="order.tempScore === 0" style="font-size:13px;color:#c0c4cc;">
                  请点击星星评分
                </span>
              </div>

              <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 12px;">
                <span style="font-size: 14px; color: #4e5a6b; font-weight: 500; min-width: 60px;">留言</span>
                <el-input
                  type="textarea"
                  v-model="order.tempComment"
                  placeholder="说说你的用餐体验吧～（选填）"
                  :rows="2"
                  maxlength="200"
                  show-word-limit
                />
              </div>

              <div style="display: flex; align-items: center; gap: 12px;">
                <el-button
                  type="primary"
                  @click="handleSubmitReview(order)"
                  :loading="order.submitting"
                >
                  提交评价
                </el-button>
                <span style="font-size: 12px; color: #c0c4cc;">评分必选，留言随意</span>
              </div>
            </div>

            <!-- 已评价：展示评价结果 -->
            <div v-else class="review-display">
              <span class="review-badge">
                <el-icon><Star /></el-icon> 已评价
              </span>

              <div class="review-score">
                <el-rate
                  v-model="order.reviewScore"
                  disabled
                  show-score
                  :colors="['#409eff', '#409eff', '#409eff']"
                />
                <span class="score-text">
                  {{ getScoreText(order.reviewScore) }}
                </span>
              </div>

              <div class="review-comment">
                <span v-if="order.reviewComment && order.reviewComment.trim()">
                  {{ order.reviewComment }}
                </span>
                <span v-else style="color: #c0c4cc; font-style: italic;">—— 没有留下留言 ——</span>
              </div>

              <div class="review-time">
                评价于 {{ order.reviewTime }}
              </div>
            </div>
          </div>

          <!-- 已取消订单的提示 -->
          <div v-if="order.status === 6" class="cancelled-hint">
            <el-icon style="font-size: 16px;"><InfoFilled /></el-icon>
            订单已取消，不可评价
          </div>
        </div>
      </div>
      <el-empty v-else description="暂无历史订单" />
      <!-- 分页 -->
      <div class="pagination-container" v-if="pagination.total > 0">
        <el-pagination
          v-model:current-page="pagination.page"
          v-model:page-size="pagination.pageSize"
          :page-sizes="[5, 10, 20, 50]"
          :total="pagination.total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-dialog>

    <!-- 配送路线弹窗 -->
    <el-dialog v-model="deliveryRouteDialogVisible" title="配送路线" width="500px">
      <div v-if="deliveryAddress">
        <p style="margin-bottom: 10px; color: #606266;">
          配送至：{{ deliveryAddress }}
        </p>
      </div>
      <OrderMap
        v-if="deliveryLocation.longitude"
        :order-id="currentOrderId"
        :longitude="deliveryLocation.longitude"
        :latitude="deliveryLocation.latitude"
        :dialog-visible="deliveryRouteDialogVisible"
        map-id="profile-delivery-map"
      />
      <div v-else class="no-route-data">
        <el-empty description="暂无配送路线信息" />
      </div>
    </el-dialog>

    <!-- 订单详情弹窗 -->
    <el-dialog v-model="orderDetailDialogVisible" title="订单信息" width="600px" class="order-dialog">
      <div v-if="orderDetail" class="order-detail-container">
        <!-- 订单基本信息 -->
        <div class="order-top">
          <div>
            <div style="display: inline-block;">
              <label style="font-size: 16px;">订单号：</label>
              <div class="order-num">{{ orderDetail.number }}</div>
            </div>
            <div class="order-status" :class="{ status3: orderDetail.status === 3 || orderDetail.status === 4 }" style="display: inline-block;">
              {{ getStatusText(orderDetail.status) }}
            </div>
          </div>
          <p>
            <label>下单时间：</label>{{ orderDetail.orderTime }}
          </p>
        </div>

        <!-- 收货信息 -->
        <div class="order-middle">
          <div class="user-info">
            <div class="user-info-box">
              <div class="user-name">
                <label>用户名：</label>
                <span>{{ orderDetail.consignee || '-' }}</span>
              </div>
              <div class="user-phone">
                <label>手机号：</label>
                <span>{{ orderDetail.phone || '-' }}</span>
              </div>
              <div class="user-getTime" v-if="orderDetail.status === 5">
                <label>送达时间：</label>
                <span>{{ orderDetail.deliveryTime || '-' }}</span>
              </div>
              <div class="user-getTime" v-if="[2, 3, 4].includes(orderDetail.status)">
                <label>预计送达时间：</label>
                <span>{{ orderDetail.estimatedDeliveryTime || '-' }}</span>
              </div>
              <div class="user-address">
                <label>地址：</label>
                <span>{{ orderDetail.address || '-' }}</span>
              </div>
            </div>
            <div class="user-remark" :class="{ orderCancel: orderDetail.status === 6 }">
              <div>{{ orderDetail.status === 6 ? '取消原因' : '备注' }}</div>
              <span>{{ orderDetail.status === 6 ? (orderDetail.cancelReason || orderDetail.rejectionReason || '-') : (orderDetail.remark || '-') }}</span>
            </div>
          </div>

          <!-- 菜品信息 -->
          <div class="dish-info">
            <div class="dish-label">菜品</div>
            <div class="dish-list">
              <div v-for="item in orderDetail.orderDetailList" :key="item.id" class="dish-item">
                <div class="dish-item-box">
                  <span class="dish-name">{{ item.name }}{{ item.dishFlavor ? '(' + item.dishFlavor + ')' : '' }}</span>
                  <span class="dish-num">x{{ item.number }}</span>
                </div>
                <span class="dish-price">￥{{ item.amount ? item.amount.toFixed(2) : '' }}</span>
              </div>
            </div>
            <div class="dish-all-amount">
              <label>菜品小计</label>
              <span>￥{{ calculateGoodsAmount(orderDetail).toFixed(2) }}</span>
            </div>
          </div>
        </div>

        <!-- 优惠券信息 -->
        <div v-if="orderDetail.couponAmount && orderDetail.couponAmount > 0" class="order-bottom">
          <div class="amount-info">
            <div class="amount-label">优惠券</div>
            <div class="amount-list">
              <div v-for="c in getCouponDetails(orderDetail)" :key="c.id" class="coupon-detail-item">
                <span class="amount-name">{{ c.name }}：</span>
                <span class="amount-price" style="color: #67c23a;">-￥{{ Number(c.discount).toFixed(2) }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- 费用信息 -->
        <div class="order-bottom">
          <div class="amount-info">
            <div class="amount-label">费用</div>
            <div class="amount-list">
              <div class="dish-amount">
                <span class="amount-name">菜品小计：</span>
                <span class="amount-price">￥{{ calculateGoodsAmount(orderDetail).toFixed(2) }}</span>
              </div>
              <div class="send-amount">
                <span class="amount-name">派送费：</span>
                <span class="amount-price">￥6</span>
              </div>
              <div class="package-amount">
                <span class="amount-name">打包费：</span>
                <span class="amount-price">￥{{ orderDetail.packAmount ? (orderDetail.packAmount.toFixed(2) * 100) / 100 : '' }}</span>
              </div>
              <div class="coupon-amount" v-if="orderDetail.couponAmount && orderDetail.couponAmount > 0">
                <span class="amount-name">优惠券：</span>
                <span class="amount-price" style="color: #67c23a;">-￥{{ orderDetail.couponAmount.toFixed(2) }}</span>
              </div>
              <div class="all-amount">
                <span class="amount-name">合计：</span>
                <span class="amount-price">￥{{ orderDetail.amount ? (orderDetail.amount.toFixed(2) * 100) / 100 : '' }}</span>
              </div>
              <div class="pay-type">
                <span class="pay-name">支付渠道：</span>
                <span class="pay-value">{{ orderDetail.payMethod === 1 ? '微信支付' : '支付宝支付' }}</span>
              </div>
              <div class="pay-time">
                <span class="pay-name">支付时间：</span>
                <span class="pay-value">{{ orderDetail.checkoutTime || '' }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- 评价信息 -->
        <div v-if="orderDetail.status === 5" class="review-section-wrapper">
          <div v-if="orderDetail.reviewed" class="review-section">
            <div class="section-title" style="margin-bottom: 12px;">
              <el-icon style="color: #f7b731;"><Star /></el-icon>
              用户评价
            </div>
            <div class="review-content">
              <div class="review-header">
                <div class="title">
                  <el-icon><Star /></el-icon>
                  评价详情
                </div>
                <span class="review-time">评价于 {{ orderDetail.reviewTime }}</span>
              </div>
              <div class="review-score">
                <el-rate v-model="orderDetail.reviewScore" disabled show-score :colors="['#409eff', '#409eff', '#409eff']" />
                <span class="score-text">{{ getScoreText(orderDetail.reviewScore) }}</span>
              </div>
              <div class="review-comment">
                <span v-if="orderDetail.reviewComment && orderDetail.reviewComment.trim()">
                  {{ orderDetail.reviewComment }}
                </span>
                <span v-else class="empty-text">—— 用户未留下留言 ——</span>
              </div>
            </div>
          </div>
          <div v-else class="no-review">
            <el-icon><InfoFilled /></el-icon>
            该订单暂无评价
          </div>
        </div>
      </div>
      <template #footer>
        <el-button @click="orderDetailDialogVisible = false">关闭</el-button>
      </template>
    </el-dialog>

    <!-- 修改个人信息弹窗 -->
    <el-dialog v-model="editProfileDialogVisible" title="修改个人信息" width="400px">
      <el-form :model="editForm" label-width="80px">
        <el-form-item label="姓名">
          <el-input v-model="editForm.name" placeholder="请输入姓名" />
        </el-form-item>
        <el-form-item label="手机号">
          <el-input 
            v-model="editForm.phone" 
            :placeholder="editFormattedPhone || '请输入手机号'"
          />
        </el-form-item>
        <el-form-item label="性别">
          <el-radio-group v-model="editForm.sex">
            <el-radio :label="0">男</el-radio>
            <el-radio :label="1">女</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="editForm.password" type="password" placeholder="不修改请留空" show-password />
        </el-form-item>
        <el-form-item label="头像">
          <el-upload
            class="avatar-uploader"
            :show-file-list="false"
            :before-upload="beforeAvatarUpload"
            :http-request="handleAvatarUpload"
          >
            <el-avatar v-if="editForm.avatar" :src="editForm.avatar" :size="80" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="editProfileDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveProfile">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Document, Location, SwitchButton, ArrowLeft, User, Plus, Star, InfoFilled, Ticket } from '@element-plus/icons-vue'
import { getHistoryOrders, repetitionOrder, reminderOrder, cancelOrder, getOrderDetail } from '@/api/order'
import { updateUserInfo, uploadAvatar } from '@/api/user'
import { getAddressById } from '@/api/address'
import { submitReview } from '@/api/review'
import { useUserStore } from '@/stores/userStore'
import OrderMap from '@/components/OrderMap.vue'

const router = useRouter()
const userStore = useUserStore()

// 返回主页
const goBack = () => {
  router.push('/dashboard')
}

// 修改个人信息弹窗
const editProfileDialogVisible = ref(false)
const editForm = reactive({
  name: '',
  phone: '',
  avatar: '',
  sex: null,
  password: ''
})

// 格式化手机号用于编辑弹窗显示
const editFormattedPhone = computed(() => {
  if (editForm.phone && editForm.phone.length >= 7) {
    return editForm.phone.substring(0, 3) + '****' + editForm.phone.substring(editForm.phone.length - 4)
  }
  if (userStore.phone && userStore.phone.length >= 7) {
    return userStore.phone.substring(0, 3) + '****' + userStore.phone.substring(userStore.phone.length - 4)
  }
  return userStore.phone || ''
})

// 订单列表
const orderList = ref([])
const ordersDialogVisible = ref(false)

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 5,
  total: 0
})

// 配送路线弹窗
const currentOrderId = ref(null)
const deliveryRouteDialogVisible = ref(false)
const deliveryAddress = ref('')
const deliveryLocation = reactive({
  longitude: null,
  latitude: null
})

// 订单详情弹窗
const orderDetailDialogVisible = ref(false)
const orderDetail = ref(null)

// 初始化
onMounted(async () => {
  // 从后端获取最新的用户完整信息（包含性别、头像等）
  if (userStore.isLoggedIn) {
    await userStore.fetchUserInfo()
  }

  // 检查是否需要打开历史订单弹窗
  const openOrdersDialog = localStorage.getItem('open_orders_dialog')
  if (openOrdersDialog === 'true') {
    localStorage.removeItem('open_orders_dialog')
    // 恢复分页状态
    const savedPagination = localStorage.getItem('orders_pagination')
    if (savedPagination) {
      const paginationData = JSON.parse(savedPagination)
      pagination.page = paginationData.page || 1
      pagination.pageSize = paginationData.pageSize || 5
      localStorage.removeItem('orders_pagination')
    }
    await loadOrders()
    ordersDialogVisible.value = true
  }
})

// 菜单选择
const handleMenuSelect = async (index) => {
  if (index === 'logout') {
    try {
      await ElMessageBox.confirm('确定退出登录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      })

      localStorage.removeItem('openid')
      userStore.clearUserInfo()
      ElMessage.success('已退出登录')
      router.push('/login')
    } catch (error) {
      // 取消退出
    }
  } else if (index === 'editProfile') {
    // 打开修改个人信息弹窗
    editForm.name = userStore.name
    editForm.phone = '' // 手机号不回显，用户输入新值或保持原值
    editForm.avatar = userStore.avatar
    editForm.sex = userStore.sex ? parseInt(userStore.sex) : null
    editForm.password = '' // 密码不回显
    editProfileDialogVisible.value = true
  } else if (index === '/orders') {
    await loadOrders()
    ordersDialogVisible.value = true
  } else {
    router.push(index)
  }
}

// 加载历史订单
const loadOrders = async () => {
  try {
    const res = await getHistoryOrders({
      page: pagination.page,
      pageSize: pagination.pageSize
    })
    if (res.code === 1) {
      orderList.value = res.data?.records || []
      pagination.total = res.data?.total || 0
    }
  } catch (error) {
    console.error('加载订单失败', error)
  }
}

// 分页大小改变
const handleSizeChange = (size) => {
  pagination.pageSize = size
  pagination.page = 1
  loadOrders()
}

// 当前页改变
const handleCurrentChange = (page) => {
  pagination.page = page
  loadOrders()
}

// 获取订单状态类型
const getStatusType = (status) => {
  const types = {
    1: 'warning',  // 待付款
    2: 'primary',  // 待接单
    3: 'info',     // 待配送
    4: 'warning',  // 派送中
    5: 'success',  // 已完成
    6: 'danger'    // 已取消/已退款
  }
  return types[status] || 'info'
}

// 获取订单状态文本
const getStatusText = (status) => {
  const texts = {
    1: '待付款',
    2: '待接单',
    3: '待配送',
    4: '派送中',
    5: '已完成',
    6: '已取消'
  }
  return texts[status] || '未知'
}

// 查看订单详情
const handleViewDetail = async (orderId) => {
  try {
    const res = await getOrderDetail(orderId)
    if (res.code === 1) {
      orderDetail.value = res.data
      orderDetailDialogVisible.value = true
    } else {
      ElMessage.error(res.msg || '获取订单详情失败')
    }
  } catch (error) {
    ElMessage.error('获取订单详情失败，请稍后重试')
  }
}

// 提交评价
const handleSubmitReview = async (order) => {
  // 校验评分
  if (!order.tempScore || order.tempScore === 0) {
    ElMessage.warning('请先选择评分（点击星星）')
    return
  }

  order.submitting = true
  try {
    const res = await submitReview({
      orderId: order.id,
      score: order.tempScore,
      comment: order.tempComment || ''
    })

    if (res.code === 1) {
      ElMessage.success('评价成功！感谢您的反馈')
      // 更新订单状态（避免重新加载整个列表）
      order.reviewed = true
      order.reviewScore = order.tempScore
      order.reviewComment = order.tempComment || ''
      order.reviewTime = new Date().toLocaleString()
    } else {
      ElMessage.error(res.msg || '评价失败')
    }
  } catch (error) {
    ElMessage.error('评价失败，请稍后重试')
  } finally {
    order.submitting = false
  }
}

// 获取评分文本
const getScoreText = (score) => {
  const texts = {
    1: '很差',
    2: '较差',
    3: '一般',
    4: '满意',
    5: '非常满意'
  }
  return texts[score] || ''
}

// 计算菜品小计
const calculateGoodsAmount = (order) => {
  if (!order || !order.orderDetailList) return 0
  return order.orderDetailList.reduce((total, item) => {
    return total + (item.amount * item.number)
  }, 0)
}

// 解析优惠券快照
const getCouponDetails = (order) => {
  if (!order || !order.couponSnapshots) return []
  try {
    return JSON.parse(order.couponSnapshots)
  } catch {
    return []
  }
}

// 再来一单
const handleRepetitionOrder = async (orderId) => {
  try {
    const res = await repetitionOrder(orderId)
    if (res.code === 1) {
      ElMessage.success('已添加到购物车')
      router.push('/dashboard')
    } else {
      ElMessage.error(res.msg || '操作失败')
    }
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

// 催单
const handleReminderOrder = async (orderId) => {
  try {
    const res = await reminderOrder(orderId)
    if (res.code === 1) {
      ElMessage.success('已催单')
    } else {
      ElMessage.error(res.msg || '催单失败')
    }
  } catch (error) {
    ElMessage.error('催单失败')
  }
}

// 取消订单
const handleCancelOrder = async (orderId) => {
  try {
    await ElMessageBox.confirm('确定取消该订单吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })

    const res = await cancelOrder(orderId)
    if (res.code === 1) {
      ElMessage.success('订单已取消')
      // 刷新订单列表
      await loadOrders()
    } else {
      ElMessage.error(res.msg || '取消失败')
    }
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('取消订单失败')
    }
  }
}

// 去支付
const goToPay = (order) => {
  // 保存当前分页状态
  localStorage.setItem('orders_pagination', JSON.stringify({
    page: pagination.page,
    pageSize: pagination.pageSize
  }))
  ordersDialogVisible.value = false
  router.push({
    path: '/order-success',
    query: {
      id: order.id,
      number: order.number,
      amount: order.amount,
      from: 'history'
    }
  })
}

// 查看配送路线
const showDeliveryRoute = async (order) => {
  const isSameOrder = currentOrderId.value === order.id
  if (!isSameOrder) {
    // 切换订单 → 清空旧坐标
    deliveryLocation.longitude = null
    deliveryLocation.latitude = null
  }
  // 同个订单：不清坐标，OrderMap 保持存活

  currentOrderId.value = order.id
  deliveryAddress.value = order.address || ''
  deliveryRouteDialogVisible.value = true

  // 坐标已存在（同个订单重新打开）直接返回
  if (isSameOrder && deliveryLocation.longitude) return

  // 根据 addressBookId 获取地址坐标
  if (order.addressBookId) {
    try {
      const res = await getAddressById(order.addressBookId)
      if (res.code === 1 && res.data) {
        const addr = res.data
        deliveryLocation.longitude = addr.longitude ? Number(addr.longitude) : null
        deliveryLocation.latitude = addr.latitude ? Number(addr.latitude) : null
        deliveryAddress.value = `${addr.provinceName || ''}${addr.cityName || ''}${addr.districtName || ''}${addr.detail || ''}`
      }
    } catch (error) {
      console.warn('获取地址坐标失败', error)
    }
  }
}

// 保存个人信息
const saveProfile = async () => {
  try {
    const userId = userStore.id
    // 如果用户没有输入新的手机号，则使用原值
    const finalPhone = editForm.phone || userStore.phone

    const updateData = {
      id: userId,
      name: editForm.name,
      phone: finalPhone,
      sex: editForm.sex,
      avatar: editForm.avatar
    }
    // 只有填写了密码才发送
    if (editForm.password) {
      updateData.password = editForm.password
    }
    const res = await updateUserInfo(updateData)
    if (res.code === 1) {
      // 使用 userStore 更新信息
      userStore.updateUserInfo({
        name: editForm.name,
        phone: finalPhone,
        avatar: editForm.avatar,
        sex: editForm.sex !== null ? String(editForm.sex) : ''
      })
      editProfileDialogVisible.value = false
      ElMessage.success('个人信息已更新')
    } else {
      ElMessage.error(res.msg || '更新失败')
    }
  } catch (error) {
    ElMessage.error('更新失败，请稍后重试')
  }
}

// 上传头像前的校验
const beforeAvatarUpload = (file) => {
  const isJPG = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/gif'
  const isLt2M = file.size / 1024 / 1024 < 2

  if (!isJPG) {
    ElMessage.error('上传头像图片只能是 JPG/PNG/GIF 格式!')
    return false
  }
  if (!isLt2M) {
    ElMessage.error('上传头像图片大小不能超过 2MB!')
    return false
  }
  return true
}

// 处理头像上传
const handleAvatarUpload = async (options) => {
  try {
    const res = await uploadAvatar(options.file)
    if (res.code === 1) {
      editForm.avatar = res.data
      ElMessage.success('头像上传成功')
    } else {
      ElMessage.error(res.msg || '上传失败')
    }
  } catch (error) {
    ElMessage.error('上传失败')
  }
}
</script>

<style scoped>
.profile-container {
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

.user-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 30px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 20px;
}

.user-info h3 {
  margin: 0 0 10px 0;
  font-size: 20px;
}

.user-info p {
  margin: 0;
  font-size: 14px;
}

.menu-section {
  background: white;
  border-radius: 8px;
}

.el-menu {
  border-right: none;
}

.el-menu-item {
  height: 50px;
  line-height: 50px;
}

.order-item {
  padding: 15px;
  border-bottom: 1px solid #eee;
}

.order-item:last-child {
  border-bottom: none;
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.order-number {
  font-weight: bold;
}

.order-time,
.order-amount {
  color: #666;
  font-size: 14px;
  margin: 5px 0;
}

.order-actions {
  margin-top: 10px;
  display: flex;
  gap: 10px;
}

.review-section {
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px dashed #e8e8e8;
}

.review-form {
  background: #f8f9fa;
  padding: 15px;
  border-radius: 8px;
}

.review-title {
  display: flex;
  align-items: center;
  gap: 6px;
  margin-bottom: 12px;
  font-size: 14px;
}

.review-display {
  background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
  padding: 15px;
  border-radius: 8px;
}

.review-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  background: #67c23a;
  color: white;
  padding: 4px 12px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
}

.review-score {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 10px;
}

.score-text {
  font-size: 14px;
  color: #4e5a6b;
  font-weight: 500;
}

.review-comment {
  margin-top: 10px;
  font-size: 14px;
  color: #4e5a6b;
  line-height: 1.6;
}

.review-time {
  margin-top: 10px;
  font-size: 12px;
  color: #909399;
}

.cancelled-hint {
  margin-top: 15px;
  padding: 10px 15px;
  background: #fef0f0;
  color: #f56c6c;
  border-radius: 4px;
  font-size: 13px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.pagination-container {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

.avatar-uploader {
  display: inline-block;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 80px;
  height: 80px;
  line-height: 80px;
  text-align: center;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
}

.avatar-uploader-icon:hover {
  border-color: #409eff;
}

/* 订单详情弹窗样式 - 按照商家端风格 */
.order-dialog .el-dialog {
  border-radius: 16px;
}

.order-dialog .el-dialog__header {
  padding: 20px 24px 16px;
  border-bottom: 1px solid #f1f5f9;
}

.order-dialog .el-dialog__title {
  font-size: 18px;
  font-weight: 600;
  color: #1e293b;
}

.order-dialog .el-dialog__body {
  padding: 24px;
}

.order-dialog .el-dialog__footer {
  padding: 16px 24px 20px;
  border-top: 1px solid #f1f5f9;
}

.order-top {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding-bottom: 16px;
  border-bottom: 1px solid #f1f5f9;
}

.order-num {
  font-size: 16px;
  font-weight: 600;
  color: #1e293b;
}

.order-status {
  padding: 6px 16px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 500;
  background: #fef3c7;
  color: #d97706;
}

.order-status.status3 {
  background: #dbeafe;
  color: #2563eb;
}

.order-middle {
  padding: 20px 0;
}

.user-info-box {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
}

.user-info-box > div {
  display: flex;
  align-items: center;
  gap: 8px;
}

.user-info-box label {
  color: #64748b;
  font-size: 14px;
}

.user-info-box span {
  color: #1e293b;
  font-weight: 500;
}

.user-remark {
  margin-top: 16px;
  padding: 12px 16px;
  background: #f8fafc;
  border-radius: 8px;
}

.user-remark div {
  font-size: 13px;
  color: #64748b;
  margin-bottom: 6px;
}

.user-remark span {
  color: #1e293b;
}

.user-remark.orderCancel {
  background: #fef2f2;
}

.user-remark.orderCancel div {
  color: #ef4444;
}

/* 菜品信息 */
.dish-info {
  margin-top: 20px;
}

.dish-label {
  font-size: 14px;
  font-weight: 600;
  color: #475569;
  margin-bottom: 12px;
}

.dish-list {
  background: #f8fafc;
  border-radius: 12px;
  padding: 16px;
}

.dish-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid #e2e8f0;
}

.dish-item:last-child {
  border-bottom: none;
}

.dish-item-box {
  display: flex;
  align-items: center;
  gap: 16px;
}

.dish-name {
  color: #1e293b;
  font-weight: 500;
}

.dish-num {
  color: #64748b;
  font-size: 13px;
}

.dish-price {
  color: #1e293b;
  font-weight: 600;
}

.dish-all-amount {
  display: flex;
  justify-content: space-between;
  padding-top: 12px;
  margin-top: 8px;
  border-top: 1px solid #cbd5e1;
}

.dish-all-amount label {
  color: #64748b;
}

.dish-all-amount span {
  color: #1e293b;
  font-weight: 600;
}

/* 费用信息 */
.order-bottom {
  margin-top: 20px;
}

.amount-label {
  font-size: 14px;
  font-weight: 600;
  color: #475569;
  margin-bottom: 12px;
}

.amount-list {
  background: #f8fafc;
  border-radius: 12px;
  padding: 16px;
}

.amount-list > div {
  display: flex;
  justify-content: space-between;
  padding: 6px 0;
}

.amount-name {
  color: #64748b;
  font-size: 14px;
}

.amount-price {
  color: #1e293b;
  font-weight: 500;
}

.all-amount .amount-name {
  font-weight: 600;
}

.all-amount .amount-price {
  font-weight: 600;
  color: #3b82f6;
}

/* 评价信息 */
.review-section-wrapper {
  margin-top: 20px;
}

.review-section {
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;
}

.review-section .section-title {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 16px;
  font-weight: 600;
  color: #262626;
}

.review-content {
  margin-top: 12px;
}

.review-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.review-header .title {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 14px;
  font-weight: 500;
  color: #4e5a6b;
}

.review-time {
  font-size: 12px;
  color: #909399;
}

.review-score {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 10px;
}

.score-text {
  font-size: 14px;
  color: #4e5a6b;
  font-weight: 500;
}

.review-comment {
  font-size: 14px;
  color: #4e5a6b;
  line-height: 1.6;
  padding: 10px;
  background: white;
  border-radius: 4px;
}

.empty-text {
  color: #c0c4cc;
  font-style: italic;
}

.no-review {
  padding: 15px;
  background: #fef0f0;
  color: #f56c6c;
  border-radius: 4px;
  font-size: 14px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.no-route-data {
  padding: 20px 0;
  text-align: center;
}
</style>