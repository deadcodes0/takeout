import request from '@/utils/request'

// 添加购物车
export function addShoppingCart(data) {
  return request({
    url: '/user/shoppingCart/add',
    method: 'post',
    data
  })
}

// 查看购物车
export function getShoppingCartList() {
  return request({
    url: '/user/shoppingCart/list',
    method: 'get'
  })
}

// 删除购物车中一个商品
export function subShoppingCart(data) {
  return request({
    url: '/user/shoppingCart/sub',
    method: 'post',
    data
  })
}

// 清空购物车
export function cleanShoppingCart() {
  return request({
    url: '/user/shoppingCart/clean',
    method: 'delete'
  })
}