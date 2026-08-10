<template>
  <div class="qr-login-container">
    <el-card class="qr-login-card">
      <template #header>
        <div class="card-header">
          <h2>微信扫码登录</h2>
          <p>请使用微信扫描下方二维码</p>
        </div>
      </template>

      <div class="qr-content">
        <!-- 二维码区域 -->
        <div class="qr-box" v-if="qrUrl && !isExpired">
          <canvas ref="qrCanvas" class="qr-canvas"></canvas>
          <div class="qr-status" v-if="status === 'WAITING'">
            <el-icon class="status-icon"><Clock /></el-icon>
            <span>等待扫码...</span>
          </div>
          <div class="qr-status success" v-if="status === 'SUCCESS'">
            <el-icon class="status-icon"><Check /></el-icon>
            <span>登录成功！</span>
          </div>
        </div>

        <!-- 二维码过期 -->
        <div class="qr-expired" v-if="isExpired">
          <el-icon class="expired-icon"><WarningFilled /></el-icon>
          <p>二维码已过期</p>
          <el-button type="primary" @click="refreshQrCode" :loading="loading">
            刷新二维码
          </el-button>
        </div>

        <!-- 加载中 -->
        <div class="qr-loading" v-if="loading && !qrUrl">
          <el-icon class="loading-icon is-loading"><Loading /></el-icon>
          <p>正在生成二维码...</p>
        </div>
      </div>

      <div class="qr-footer">
        <el-link type="primary" @click="goBack">
          返回账号登录
        </el-link>
      </div>
    </el-card>

    <!-- 新用户填写信息弹窗 -->
    <UserInfoDialog
      v-model:visible="showUserInfoDialog"
      :user-id="userId"
      @success="handleUserInfoSuccess"
    />
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Clock, Check, WarningFilled, Loading } from '@element-plus/icons-vue'
import { generateQrCode, checkLoginStatus } from '@/api/qrLogin'
import { useUserStore } from '@/stores/userStore'
import UserInfoDialog from './UserInfoDialog.vue'

const router = useRouter()
const userStore = useUserStore()

// 状态变量
const qrUrl = ref('')
const sessionId = ref('')
const status = ref('WAITING')
const isExpired = ref(false)
const loading = ref(false)
const qrCanvas = ref(null)

// 新用户弹窗相关
const showUserInfoDialog = ref(false)
const userId = ref(null)

// 轮询定时器
let pollTimer = null
// 过期定时器
let expireTimer = null

// 二维码有效期（秒）
const QR_TIMEOUT = 120
// 轮询间隔（毫秒）
const POLL_INTERVAL = 1500

/**
 * 生成二维码
 */
const generateQr = async () => {
  loading.value = true
  isExpired.value = false
  status.value = 'WAITING'

  try {
    const res = await generateQrCode()
    if (res.code === 1) {
      qrUrl.value = res.data.qrUrl
      sessionId.value = res.data.sessionId

      // 等待 canvas 渲染完成后绘制二维码
      await nextTick()
      drawQrCode(res.data.qrUrl)

      // 开始轮询检查登录状态
      startPolling()

      // 设置过期定时器
      startExpireTimer()
    } else {
      ElMessage.error(res.msg || '生成二维码失败')
    }
  } catch (error) {
    ElMessage.error('生成二维码失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

/**
 * 使用 Canvas 绘制二维码
 * 使用第三方 API 生成二维码图片
 */
const drawQrCode = (url) => {
  if (!qrCanvas.value) return

  const canvas = qrCanvas.value
  const ctx = canvas.getContext('2d')
  const size = 200

  canvas.width = size
  canvas.height = size

  // 使用 QRCode API 生成二维码图片
  const qrImageUrl = `https://api.qrserver.com/v1/create-qr-code/?size=${size}x${size}&data=${encodeURIComponent(url)}`

  const img = new Image()
  img.crossOrigin = 'anonymous'
  img.onload = () => {
    ctx.drawImage(img, 0, 0, size, size)
  }
  img.onerror = () => {
    ctx.fillStyle = '#f5f5f5'
    ctx.fillRect(0, 0, size, size)
    ctx.fillStyle = '#666'
    ctx.font = '14px Arial'
    ctx.textAlign = 'center'
    ctx.fillText('二维码加载失败', size / 2, size / 2)
    ctx.fillText('请点击刷新', size / 2, size / 2 + 20)
  }
  img.src = qrImageUrl
}

/**
 * 开始轮询检查登录状态
 */
const startPolling = () => {
  if (pollTimer) {
    clearInterval(pollTimer)
  }

  pollTimer = setInterval(async () => {
    if (isExpired.value) {
      stopPolling()
      return
    }

    try {
      const res = await checkLoginStatus(sessionId.value)
      if (res.code === 1) {
        const data = res.data
        status.value = data.status

        if (data.status === 'SUCCESS') {
          // 登录成功
          stopPolling()
          stopExpireTimer()

          // 保存 token 和 userId 到 store
          userStore.updateUserInfo({
            token: data.token,
            id: data.userId
          })
          if (data.openid) {
            localStorage.setItem('openid', data.openid)
          }

          ElMessage.success('登录成功')

          // 判断是否为新用户
          if (data.isNewUser) {
            // 新用户，弹出填写信息弹窗
            userId.value = data.userId
            showUserInfoDialog.value = true
          } else {
            // 老用户，从后端获取完整用户信息并缓存
            await userStore.fetchUserInfo()
            // 直接跳转到首页
            setTimeout(() => {
              router.push('/dashboard')
            }, 1000)
          }
        } else if (data.status === 'EXPIRED') {
          // 二维码过期
          isExpired.value = true
          stopPolling()
        }
      }
    } catch (error) {
      console.error('检查登录状态失败:', error)
    }
  }, POLL_INTERVAL)
}

/**
 * 停止轮询
 */
const stopPolling = () => {
  if (pollTimer) {
    clearInterval(pollTimer)
    pollTimer = null
  }
}

/**
 * 开始过期定时器
 */
const startExpireTimer = () => {
  if (expireTimer) {
    clearTimeout(expireTimer)
  }

  expireTimer = setTimeout(() => {
    if (status.value !== 'SUCCESS') {
      isExpired.value = true
      stopPolling()
    }
  }, QR_TIMEOUT * 1000)
}

/**
 * 停止过期定时器
 */
const stopExpireTimer = () => {
  if (expireTimer) {
    clearTimeout(expireTimer)
    expireTimer = null
  }
}

/**
 * 刷新二维码
 */
const refreshQrCode = () => {
  stopPolling()
  stopExpireTimer()
  generateQr()
}

/**
 * 返回账号登录
 */
const goBack = () => {
  stopPolling()
  stopExpireTimer()
  router.push('/login')
}

/**
 * 用户信息填写成功后的处理
 */
const handleUserInfoSuccess = () => {
  showUserInfoDialog.value = false
  ElMessage.success('信息填写成功')
  router.push('/dashboard')
}

// 页面加载时生成二维码
onMounted(() => {
  generateQr()
})

// 页面卸载时清理定时器
onUnmounted(() => {
  stopPolling()
  stopExpireTimer()
})
</script>

<style scoped>
.qr-login-container {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.qr-login-card {
  width: 350px;
}

.card-header {
  text-align: center;
}

.card-header h2 {
  margin: 0;
  font-size: 24px;
  color: #303133;
}

.card-header p {
  margin: 10px 0 0;
  color: #909399;
  font-size: 14px;
}

.qr-content {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
}

.qr-box {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.qr-canvas {
  border: 1px solid #e4e7ed;
  border-radius: 4px;
}

.qr-status {
  margin-top: 15px;
  display: flex;
  align-items: center;
  color: #909399;
  font-size: 14px;
}

.qr-status.success {
  color: #67c23a;
}

.status-icon {
  margin-right: 5px;
  font-size: 16px;
}

.qr-expired {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 30px;
}

.expired-icon {
  font-size: 48px;
  color: #f56c6c;
  margin-bottom: 15px;
}

.qr-expired p {
  color: #909399;
  margin-bottom: 20px;
}

.qr-loading {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 30px;
}

.loading-icon {
  font-size: 48px;
  color: #409eff;
  margin-bottom: 15px;
}

.qr-loading p {
  color: #909399;
}

.qr-footer {
  text-align: center;
  padding: 10px 0;
  border-top: 1px solid #e4e7ed;
}
</style>