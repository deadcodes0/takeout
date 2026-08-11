import request from '@/utils/request'

// 新增地址
export function addAddress(data) {
  return request({
    url: '/user/addressBook',
    method: 'post',
    data
  })
}

// 根据id修改地址
export function updateAddress(data) {
  return request({
    url: '/user/addressBook',
    method: 'put',
    data
  })
}

// 根据id删除地址
export function deleteAddress(id) {
  return request({
    url: '/user/addressBook',
    method: 'delete',
    params: { id }
  })
}

// 查询当前登录用户的所有地址信息
export function getAddressList() {
  return request({
    url: '/user/addressBook/list',
    method: 'get'
  })
}

// 查询默认地址
export function getDefaultAddress() {
  return request({
    url: '/user/addressBook/default',
    method: 'get'
  })
}

// 设置默认地址
export function setDefaultAddress(id) {
  return request({
    url: '/user/addressBook/default',
    method: 'put',
    data: { id }
  })
}

// 根据id查询地址
export function getAddressById(id) {
  return request({
    url: `/user/addressBook/${id}`,
    method: 'get'
  })
}