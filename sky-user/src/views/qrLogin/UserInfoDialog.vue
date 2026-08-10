<template>
  <el-dialog
    v-model="dialogVisible"
    title="完善个人信息"
    width="400px"
    :close-on-click-modal="false"
    :close-on-press-escape="false"
    :show-close="false"
  >
    <el-form
      :model="userForm"
      :rules="rules"
      ref="userFormRef"
      label-width="80px"
    >
      <el-form-item label="姓名" prop="name">
        <el-input v-model="userForm.name" placeholder="请输入您的姓名" />
      </el-form-item>

      <el-form-item label="手机号" prop="phone">
        <el-input v-model="userForm.phone" placeholder="请输入手机号" />
      </el-form-item>

      <el-form-item label="密码" prop="password">
        <el-input
          v-model="userForm.password"
          type="password"
          placeholder="请设置密码"
          show-password
        />
      </el-form-item>

      <el-form-item label="性别" prop="sex">
        <el-radio-group v-model="userForm.sex">
          <el-radio value="0">男</el-radio>
          <el-radio value="1">女</el-radio>
        </el-radio-group>
      </el-form-item>
    </el-form>

    <template #footer>
      <el-button type="primary" @click="handleSubmit" :loading="loading" style="width: 100%">
        提交
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive, watch } from 'vue'
import { ElMessage } from 'element-plus'
import { updateUserInfo } from '@/api/user'
import { useUserStore } from '@/stores/userStore'

// Props
const props = defineProps({
  visible: {
    type: Boolean,
    default: false
  },
  userId: {
    type: Number,
    default: null
  }
})

// Emits
const emit = defineEmits(['success', 'update:visible'])

// 状态
const dialogVisible = ref(props.visible)
const userFormRef = ref(null)
const loading = ref(false)
const userStore = useUserStore()

// 表单数据
const userForm = reactive({
  name: '',
  phone: '',
  password: '',
  sex: '0'  // 默认选中男
})

// 表单校验规则
const rules = {
  name: [
    { required: true, message: '请输入姓名', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请设置密码', trigger: 'blur' },
    { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
  ],
  sex: [
    { required: true, message: '请选择性别', trigger: 'change' }
  ]
}

// 监听 props.visible 变化
watch(() => props.visible, (val) => {
  dialogVisible.value = val
})

// 监听 dialogVisible 变化，同步到父组件
watch(dialogVisible, (val) => {
  emit('update:visible', val)
})

/**
 * 提交表单
 */
const handleSubmit = async () => {
  if (!userFormRef.value) return

  await userFormRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true
      try {
        const res = await updateUserInfo({
          id: props.userId,
          name: userForm.name,
          phone: userForm.phone,
          password: userForm.password,
          sex: userForm.sex
        })

        if (res.code === 1) {
          // 使用 userStore 保存用户信息
          userStore.updateUserInfo({
            name: userForm.name,
            phone: userForm.phone,
            sex: userForm.sex
          })

          emit('success')
        } else {
          ElMessage.error(res.msg || '提交失败')
        }
      } catch (error) {
        ElMessage.error('提交失败，请稍后重试')
      } finally {
        loading.value = false
      }
    }
  })
}
</script>

<style scoped>
.el-dialog__footer {
  text-align: center;
}
</style>