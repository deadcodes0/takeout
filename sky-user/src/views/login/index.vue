<template>
  <div class="login-container">
    <el-card class="login-card">
      <template #header>
        <div class="card-header">
          <h2>Sky Admin</h2>
          <p>外卖管理系统</p>
        </div>
      </template>

      <el-form :model="loginForm" :rules="rules" ref="loginFormRef" label-width="80px">
        <!-- 用户名：只在注册模式显示 -->
        <el-form-item label="用户名" prop="name" v-if="!isLoginMode">
          <el-input v-model="loginForm.name" placeholder="请输入用户名" />
        </el-form-item>

        <el-form-item label="手机号" prop="phone">
          <el-input v-model="loginForm.phone" placeholder="请输入手机号" />
        </el-form-item>

        <el-form-item label="密码" prop="password">
          <el-input
            v-model="loginForm.password"
            type="password"
            placeholder="请输入密码"
            show-password
          />
        </el-form-item>

        <el-form-item>
          <el-button 
            type="primary" 
            @click="handleSubmit" 
            :loading="loading" 
            style="width: 100%"
          >
            {{ isLoginMode ? '登录' : '注册' }}
          </el-button>
        </el-form-item>

        <el-form-item style="text-align: center">
          <el-link type="primary" @click="toggleMode">
            {{ isLoginMode ? '没有账号？点击注册' : '已有账号？点击登录' }}
          </el-link>
        </el-form-item>

        <!-- 二维码登录入口 -->
        <el-divider>
          <span style="color: #909399; font-size: 12px;">其他登录方式</span>
        </el-divider>
        <el-form-item style="text-align: center">
          <el-button type="default" @click="goToQrLogin" style="width: 100%">
            <el-icon style="margin-right: 5px;"><Iphone /></el-icon>
            微信扫码登录
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Iphone } from '@element-plus/icons-vue'
import { login, register } from '@/api/user'
import { useUserStore } from '@/stores/userStore'

const router = useRouter()
const userStore = useUserStore()
const loginFormRef = ref(null)
const loading = ref(false)
const isLoginMode = ref(true)  // true: 登录模式, false: 注册模式

const loginForm = reactive({
  name: '',
  phone: '',
  password: ''
})

const rules = {
  name: [
    { required: true, message: '请输入用户名', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
  ]
}

// 切换登录/注册模式
const toggleMode = () => {
  isLoginMode.value = !isLoginMode.value
  // 清空表单
  loginFormRef.value?.resetFields()
}

// 处理提交（登录或注册）
const handleSubmit = async () => {
  if (!loginFormRef.value) return

  await loginFormRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true
      try {
        let res
        if (isLoginMode.value) {
          // 登录：只传手机号和密码
          res = await login({
            phone: loginForm.phone,
            password: loginForm.password
          })
        } else {
          // 注册：传用户名、手机号和密码
          res = await register(loginForm)
        }

        if (res.code === 1) {
          console.log('登录/注册返回数据:', res.data)
          // 使用 userStore 保存完整用户信息（包括 sex、avatar）
          userStore.setUserInfo(res.data)
          ElMessage.success(isLoginMode.value ? '登录成功' : '注册成功')
          router.push('/dashboard')
        } else {
          // 登录失败：统一提示"手机号或密码错误"
          // 注册失败：显示具体错误信息
          if (isLoginMode.value) {
            ElMessage.error('手机号或密码错误')
          } else {
            ElMessage.error(res.msg || '注册失败')
          }
        }
      } catch (error) {
        // 登录失败：统一提示"手机号或密码错误"
        // 注册失败：提示具体错误
        if (isLoginMode.value) {
          ElMessage.error('手机号或密码错误')
        } else {
          ElMessage.error('注册失败，请稍后重试')
        }
      } finally {
        loading.value = false
      }
    }
  })
}

// 跳转到二维码登录页面
const goToQrLogin = () => {
  router.push('/qr-login')
}
</script>

<style scoped>
.login-container {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.login-card {
  width: 450px;
}

.card-header {
  text-align: center;
}

.card-header h2 {
  margin: 0;
  font-size: 28px;
  color: #303133;
}

.card-header p {
  margin: 10px 0 0;
  color: #909399;
}
</style>