<template>
  <div class="login-wrapper">
    <!-- 左侧品牌展示 -->
    <div class="login-brand">
      <span class="brand-icon">🚀</span>
      <h1>欢迎回来</h1>
      <p>登录你的账户，开始高效管理你的业务。</p>
      <div class="brand-tags">
        <span class="tag">✨ 安全</span>
        <span class="tag">⚡ 快速</span>
        <span class="tag">📊 智能</span>
      </div>
    </div>

    <!-- 登录卡片 -->
    <div class="login-card">
      <div class="login-title">
        <div class="logo">
          <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path
              d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm1-13h-2v6l5.25 3.15L17 12.23l-4-2.37V7z"
              fill="#2563eb"
            />
          </svg>
          <span>管理后台</span>
        </div>
        <div class="sub">使用你的账号密码登录</div>
      </div>

      <el-form ref="loginForm" :model="loginForm" :rules="loginRules" @submit.native.prevent="handleLogin">
        <el-form-item prop="username">
          <el-input
            v-model="loginForm.username"
            type="text"
            placeholder="请输入账号"
            prefix-icon="el-icon-user"
            clearable
            size="medium"
          ></el-input>
        </el-form-item>

        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            type="password"
            placeholder="请输入密码"
            prefix-icon="el-icon-lock"
            show-password
            size="medium"
            @keyup.enter.native="handleLogin"
          ></el-input>
        </el-form-item>

        <div class="login-extra">
          <el-checkbox v-model="remember">记住密码</el-checkbox>
          <a href="#" @click.prevent="showResetPasswordDialog">忘记密码？</a>
        </div>

        <el-form-item style="margin-top: 28px">
          <el-button
            class="login-btn"
            :loading="loading"
            type="primary"
            @click="handleLogin"
          >
            {{ loading ? '登录中...' : '登 录' }}
          </el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 重置密码弹窗 -->
    <el-dialog
      title="重置密码"
      :visible.sync="resetPasswordDialogVisible"
      width="420px"
      class="reset-password-dialog"
      @close="closeResetPasswordDialog"
    >
      <el-form ref="resetPasswordForm" :model="resetPasswordForm" :rules="resetPasswordRules">
        <el-form-item prop="username" label="用户名">
          <el-input
            v-model="resetPasswordForm.username"
            placeholder="请输入用户名"
            prefix-icon="el-icon-user"
            clearable
          ></el-input>
        </el-form-item>

        <el-form-item prop="newPassword" label="新密码">
          <el-input
            v-model="resetPasswordForm.newPassword"
            type="password"
            placeholder="请输入新密码（至少6位）"
            prefix-icon="el-icon-lock"
            show-password
          ></el-input>
        </el-form-item>

        <el-form-item prop="confirmPassword" label="确认密码">
          <el-input
            v-model="resetPasswordForm.confirmPassword"
            type="password"
            placeholder="请再次输入新密码"
            prefix-icon="el-icon-lock"
            show-password
          ></el-input>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="resetPasswordDialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="resetLoading" @click="handleResetPassword">
          确认重置
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Watch } from 'vue-property-decorator'
import { Route } from 'vue-router'
import { Form as ElForm } from 'element-ui'
import { UserModule } from '@/store/modules/user'
import { resetPassword } from '@/api/employee'

@Component({ name: 'Login' })
export default class extends Vue {
  private validateUsername = (rule: any, value: string, callback: Function) => {
    if (!value) {
      callback(new Error('请输入用户名'))
    } else {
      callback()
    }
  }

  private validatePassword = (rule: any, value: string, callback: Function) => {
    if (value.length < 6) {
      callback(new Error('密码必须在6位以上'))
    } else {
      callback()
    }
  }

  private loginForm = {
    username: 'admin',
    password: '123456',
  } as {
    username: string
    password: string
  }

  private loginRules = {
    username: [{ validator: this.validateUsername, trigger: 'blur' }],
    password: [{ validator: this.validatePassword, trigger: 'blur' }],
  }

  private loading = false
  private remember = false
  private redirect?: string

  // 重置密码相关
  private resetPasswordDialogVisible = false
  private resetLoading = false
  private resetPasswordForm = {
    username: '',
    newPassword: '',
    confirmPassword: '',
  }

  private validateResetUsername = (rule: any, value: string, callback: Function) => {
    if (!value) {
      callback(new Error('请输入用户名'))
    } else {
      callback()
    }
  }

  private validateResetPassword = (rule: any, value: string, callback: Function) => {
    if (!value) {
      callback(new Error('请输入新密码'))
    } else if (value.length < 6) {
      callback(new Error('密码必须在6位以上'))
    } else {
      callback()
    }
  }

  private validateConfirmPassword = (rule: any, value: string, callback: Function) => {
    if (!value) {
      callback(new Error('请再次输入新密码'))
    } else if (value !== this.resetPasswordForm.newPassword) {
      callback(new Error('两次输入的密码不一致'))
    } else {
      callback()
    }
  }

  private resetPasswordRules = {
    username: [{ validator: this.validateResetUsername, trigger: 'blur' }],
    newPassword: [{ validator: this.validateResetPassword, trigger: 'blur' }],
    confirmPassword: [{ validator: this.validateConfirmPassword, trigger: 'blur' }],
  }

  mounted() {
    document.body.classList.add('login-page')
  }

  beforeDestroy() {
    document.body.classList.remove('login-page')
  }

  @Watch('$route', { immediate: true })
  private onRouteChange(route: Route) {}

  // 登录
  private handleLogin() {
    (this.$refs.loginForm as ElForm).validate(async (valid: boolean) => {
      if (valid) {
        this.loading = true
        try {
          const res = await UserModule.Login(this.loginForm as any)
          if (String(res.code) === '1') {
            this.$router.push('/dashboard')
          } else {
            this.$message.error(res.msg || '登录失败')
            this.loading = false
          }
        } catch (err) {
          this.$message.error('用户名或密码错误！')
          this.loading = false
        }
      } else {
        return false
      }
    })
  }

  // 显示重置密码弹窗
  private showResetPasswordDialog() {
    this.resetPasswordDialogVisible = true
    this.resetPasswordForm = {
      username: '',
      newPassword: '',
      confirmPassword: '',
    }
  }

  // 关闭重置密码弹窗
  private closeResetPasswordDialog() {
    this.resetPasswordForm = {
      username: '',
      newPassword: '',
      confirmPassword: '',
    }
    if (this.$refs.resetPasswordForm) {
      (this.$refs.resetPasswordForm as ElForm).clearValidate()
    }
  }

  // 重置密码
  private handleResetPassword() {
    (this.$refs.resetPasswordForm as ElForm).validate(async (valid: boolean) => {
      if (valid) {
        this.resetLoading = true
        try {
          const res = await resetPassword({
            username: this.resetPasswordForm.username,
            newPassword: this.resetPasswordForm.newPassword,
          })
          
          if (String(res.data.code) === '1') {
            this.$message.success('密码重置成功，请使用新密码登录')
            this.resetPasswordDialogVisible = false
            // 自动填充用户名
            this.loginForm.username = this.resetPasswordForm.username
            this.loginForm.password = ''
          } else {
            this.$message.error(res.data.msg || '密码重置失败')
          }
        } catch (err: any) {
          this.$message.error(err.message || '密码重置失败，请稍后重试')
        } finally {
          this.resetLoading = false
        }
      } else {
        return false
      }
    })
  }
}
</script>

<style lang="scss" scoped>
/* ===== 登录页面样式 ===== */
.login-wrapper {
  width: 100%;
  max-width: 1200px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 40px;
  flex-wrap: wrap;
  padding: 20px;
}

/* ===== 左侧品牌展示 ===== */
.login-brand {
  flex: 1;
  min-width: 280px;
  color: #1e293b;
  padding: 20px;

  .brand-icon {
    font-size: 72px;
    margin-bottom: 12px;
    display: block;
  }

  h1 {
    font-size: 42px;
    font-weight: 700;
    line-height: 1.2;
    margin-bottom: 16px;
    background: linear-gradient(135deg, #2563eb, #7c3aed);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  p {
    font-size: 18px;
    color: #475569;
    max-width: 400px;
  }

  .brand-tags {
    margin-top: 24px;
    display: flex;
    gap: 12px;
    flex-wrap: wrap;

    .tag {
      background: #eef2ff;
      padding: 4px 16px;
      border-radius: 30px;
      font-size: 14px;
      color: #2563eb;
    }
  }
}

/* ===== 登录卡片 ===== */
.login-card {
  background: #ffffff;
  border-radius: 32px;
  padding: 48px 40px 40px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08), 0 8px 24px rgba(0, 0, 0, 0.04);
  width: 100%;
  max-width: 420px;
  transition: transform 0.25s ease, box-shadow 0.3s ease;
  backdrop-filter: blur(2px);
  border: 1px solid rgba(255, 255, 255, 0.3);

  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 28px 72px rgba(0, 0, 0, 0.1);
  }
}

/* ===== 表单标题 ===== */
.login-title {
  text-align: center;
  margin-bottom: 36px;

  .logo {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    margin-bottom: 8px;

    svg {
      width: 48px;
      height: 48px;
    }

    span {
      font-size: 28px;
      font-weight: 700;
      color: #0f172a;
      letter-spacing: -0.5px;
    }
  }

  .sub {
    font-size: 15px;
    color: #64748b;
    margin-top: 6px;
  }
}

/* ===== 表单项 ===== */
.login-card .el-form-item {
  margin-bottom: 24px;
}

.login-card .el-input__inner {
  height: 50px;
  border-radius: 14px;
  border: 1.5px solid #e2e8f0;
  padding-left: 46px;
  font-size: 15px;
  transition: border-color 0.25s, box-shadow 0.25s;
  background: #f8fafc;

  &:focus {
    border-color: #2563eb;
    box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.12);
    background: #ffffff;
  }
}

.login-card .el-input__prefix {
  left: 16px;
  font-size: 20px;
  color: #94a3b8;
  transition: color 0.25s;
}

.login-card .el-input.is-focus .el-input__prefix {
  color: #2563eb;
}

.login-card .el-input__icon {
  line-height: 50px;
}

/* ===== 登录按钮 ===== */
.login-btn {
  width: 100%;
  height: 50px;
  border-radius: 14px;
  font-size: 17px;
  font-weight: 600;
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  border: none;
  color: #fff;
  transition: all 0.3s ease;
  box-shadow: 0 8px 24px rgba(37, 99, 235, 0.25);
  letter-spacing: 0.5px;

  &:hover {
    transform: scale(1.02);
    box-shadow: 0 12px 32px rgba(37, 99, 235, 0.35);
    background: linear-gradient(135deg, #1d4ed8, #4338ca);
  }

  &:active {
    transform: scale(0.98);
  }
}

/* ===== 额外选项 ===== */
.login-extra {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 8px;
  font-size: 14px;
  color: #64748b;

  a {
    color: #2563eb;
    text-decoration: none;
    font-weight: 500;

    &:hover {
      text-decoration: underline;
    }
  }
}

.login-card .el-checkbox .el-checkbox__label {
  font-size: 14px;
  color: #475569;
}

/* ===== 响应式 ===== */
@media (max-width: 768px) {
  .login-wrapper {
    flex-direction: column;
    gap: 24px;
  }

  .login-brand {
    text-align: center;

    h1 {
      font-size: 32px;
    }

    p {
      margin: 0 auto;
    }

    .brand-tags {
      justify-content: center;
    }
  }

  .login-card {
    padding: 32px 24px;
  }
}

@media (max-width: 480px) {
  .login-card {
    padding: 24px 16px;
  }

  .login-title .logo span {
    font-size: 22px;
  }

  .login-card .el-input__inner {
    height: 44px;
  }

  .login-btn {
    height: 44px;
    font-size: 15px;
  }
}

/* ===== 重置密码弹窗样式 ===== */
.reset-password-dialog {
  .el-dialog__header {
    background: linear-gradient(135deg, #2563eb, #4f46e5);
    color: #fff;
    padding: 20px;
    border-radius: 8px 8px 0 0;
  }

  .el-dialog__title {
    color: #fff;
    font-weight: 600;
  }

  .el-dialog__headerbtn .el-dialog__close {
    color: #fff;
  }

  .el-dialog__body {
    padding: 30px 40px;
  }

  .el-form-item {
    margin-bottom: 20px;
  }

  .el-form-item__label {
    font-weight: 500;
    color: #475569;
  }

  .el-input__inner {
    height: 44px;
    border-radius: 12px;
    border: 1.5px solid #e2e8f0;
    font-size: 14px;
    transition: border-color 0.25s, box-shadow 0.25s;

    &:focus {
      border-color: #2563eb;
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }
  }

  .dialog-footer {
    text-align: center;
    padding-top: 10px;

    .el-button {
      width: 120px;
      height: 40px;
      border-radius: 10px;
      font-size: 14px;
      font-weight: 500;
    }

    .el-button--primary {
      background: linear-gradient(135deg, #2563eb, #4f46e5);
      border: none;
    }
  }
}
</style>