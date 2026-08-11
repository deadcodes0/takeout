import request from '@/utils/request'

// 根据分类id查询菜品
export function getDishList(categoryId) {
  return request({
    url: '/user/dish/list',
    method: 'get',
    params: { categoryId }
  })
}