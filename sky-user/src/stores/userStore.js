import { defineStore } from 'pinia'
import { getUserInfo } from '@/api/user'

export const useUserStore = defineStore('user', {
  state: () => ({
    // 从 localStorage 初始化，避免刷新丢失
    id: localStorage.getItem('userId') || '',
    name: localStorage.getItem('userName') || '',
    phone: localStorage.getItem('userPhone') || '',
    sex: localStorage.getItem('userSex') || '',
    avatar: localStorage.getItem('userAvatar') || '',
    token: localStorage.getItem('token') || ''
  }),

  getters: {
    // 是否已登录
    isLoggedIn: (state) => !!state.token,
    // 是否有完整的用户信息
    hasUserInfo: (state) => !!state.name || !!state.phone,
    // 格式化手机号
    formattedPhone: (state) => {
      if (!state.phone) return '未设置'
      if (state.phone.length >= 7) {
        return state.phone.substring(0, 3) + '****' + state.phone.substring(state.phone.length - 4)
      }
      return state.phone
    },
    // 格式化性别
    formattedSex: (state) => {
      if (!state.sex) return '未设置'
      return state.sex === '0' ? '男' : state.sex === '1' ? '女' : '未设置'
    }
  },

  actions: {
    // 设置用户信息（登录/注册时调用）
    setUserInfo(userInfo) {
      this.id = userInfo.id || ''
      this.name = userInfo.name || ''
      this.phone = userInfo.phone || ''
      this.sex = userInfo.sex || ''
      this.avatar = userInfo.avatar || ''
      this.token = userInfo.token || ''
      this._saveToLocalStorage()
    },

    // 更新部分用户信息（修改个人信息时调用）
    updateUserInfo(userInfo) {
      if (userInfo.id != null) this.id = userInfo.id
      if (userInfo.name != null) this.name = userInfo.name
      if (userInfo.phone != null) this.phone = userInfo.phone
      if (userInfo.sex != null) this.sex = userInfo.sex
      if (userInfo.avatar != null) this.avatar = userInfo.avatar
      if (userInfo.token != null) this.token = userInfo.token
      this._saveToLocalStorage()
    },

    // 从后端获取用户信息并缓存（只在本地无缓存时调用）
    async fetchUserInfo() {
      if (!this.id) return
      try {
        const res = await getUserInfo(this.id)
        if (res.code === 1) {
          this.updateUserInfo({
            name: res.data.name,
            phone: res.data.phone,
            sex: res.data.sex,
            avatar: res.data.avatar
          })
        }
      } catch (error) {
        console.error('获取用户信息失败:', error)
      }
    },

    // 清除用户信息（退出登录时调用）
    clearUserInfo() {
      this.id = ''
      this.name = ''
      this.phone = ''
      this.sex = ''
      this.avatar = ''
      this.token = ''
      this._clearLocalStorage()
    },

    // 持久化到 localStorage
    _saveToLocalStorage() {
      localStorage.setItem('userId', this.id)
      localStorage.setItem('userName', this.name)
      localStorage.setItem('userPhone', this.phone)
      localStorage.setItem('userSex', this.sex)
      localStorage.setItem('userAvatar', this.avatar)
      localStorage.setItem('token', this.token)
    },

    // 清除 localStorage
    _clearLocalStorage() {
      localStorage.removeItem('userId')
      localStorage.removeItem('userName')
      localStorage.removeItem('userPhone')
      localStorage.removeItem('userSex')
      localStorage.removeItem('userAvatar')
      localStorage.removeItem('token')
      localStorage.removeItem('openid')
    }
  }
})
