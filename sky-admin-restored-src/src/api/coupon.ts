import request from '@/utils/request'
/**
 *
 * 优惠券管理
 *
 **/

// 分页查询优惠券列表
export const getCouponPage = (params: any) => {
  return request({
    url: '/coupon/page',
    method: 'get',
    params,
  })
}

// 创建优惠券
export const addCoupon = (params: any) => {
  return request({
    url: '/coupon',
    method: 'post',
    data: { ...params }
  })
}
