import request from '@/utils/request'

// 获取营业状态
export function getShopStatus() {
  return request({
    url: '/user/shop/status',
    method: 'get'
  })
}