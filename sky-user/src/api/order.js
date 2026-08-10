import request from '@/utils/request'

// 提交订单
export function submitOrder(data) {
  return request({
    url: '/user/order/submit',
    method: 'post',
    data
  })
}

// 支付订单
export function payOrder(data) {
  return request({
    url: '/user/order/payment',
    method: 'put',
    data
  })
}

// 取消订单
export function cancelOrder(id) {
  return request({
    url: `/user/order/cancel/${id}`,
    method: 'put'
  })
}

// 历史订单查询
export function getHistoryOrders(params) {
  return request({
    url: '/user/order/historyOrders',
    method: 'get',
    params
  })
}

// 再来一单
export function repetitionOrder(id) {
  return request({
    url: `/user/order/repetition/${id}`,
    method: 'post'
  })
}

// 催单
export function reminderOrder(id) {
  return request({
    url: `/user/order/reminder/${id}`,
    method: 'get'
  })
}

// 配送完成（模拟用）
export function completeDeliveryOrder(id) {
  return request({
    url: `/user/order/completeDelivery/${id}`,
    method: 'put'
  })
}

// 查询订单详情
export function getOrderDetail(id) {
  return request({
    url: `/user/order/orderDetail/${id}`,
    method: 'get'
  })
}
