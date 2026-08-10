import request from '@/utils/request'

// 根据分类id查询套餐
export function getSetmealList(categoryId) {
  return request({
    url: '/user/setmeal/list',
    method: 'get',
    params: { categoryId }
  })
}

// 根据套餐id查询包含的菜品
export function getSetmealDishes(id) {
  return request({
    url: `/user/setmeal/dish/${id}`,
    method: 'get'
  })
}