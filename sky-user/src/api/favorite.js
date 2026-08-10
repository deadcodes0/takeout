import request from '@/utils/request'

// 添加收藏
export function addFavorite(data) {
  return request({
    url: '/user/favorite/add',
    method: 'post',
    data
  })
}

// 取消收藏
export function removeFavorite(data) {
  return request({
    url: '/user/favorite/remove',
    method: 'post',
    data
  })
}

// 查看收藏列表
export function getFavoriteList() {
  return request({
    url: '/user/favorite/list',
    method: 'get'
  })
}

// 根据id删除收藏
export function removeFavoriteById(id) {
  return request({
    url: `/user/favorite/${id}`,
    method: 'delete'
  })
}

// 检查是否已收藏
export function checkFavorite(dishId, setmealId) {
  return request({
    url: '/user/favorite/check',
    method: 'get',
    params: {
      dishId,
      setmealId
    }
  })
}