import request from '@/utils/request'

// 用户登录
export function login(data) {
  return request({
    url: '/user/user/login',
    method: 'post',
    data
  })
}

// 用户注册
export function register(data) {
  return request({
    url: '/user/user/register',
    method: 'post',
    data
  })
}

// 获取用户信息
export function getUserInfo(id) {
  return request({
    url: `/user/user/${id}`,
    method: 'get'
  })
}

// 更新用户信息
export function updateUserInfo(data) {
  return request({
    url: '/user/user',
    method: 'put',
    data
  })
}

// 上传头像
export function uploadAvatar(file) {
  const formData = new FormData()
  formData.append('file', file)
  return request({
    url: '/user/common/upload',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}