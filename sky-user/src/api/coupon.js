import request from '@/utils/request'

// 领取优惠券
export function receiveCoupon(id) {
  return request({
    url: '/user/coupon/receive',
    method: 'post',
    params: { id }
  })
}

// 可领取的优惠券列表
export function getAvailableCoupons() {
  return request({
    url: '/user/coupon/available',
    method: 'get'
  })
}

// 我的优惠券列表（status: 0-未使用 1-已使用 2-过期，不传查全部）
export function getMyCoupons(params) {
  return request({
    url: '/user/coupon/list',
    method: 'get',
    params
  })
}
