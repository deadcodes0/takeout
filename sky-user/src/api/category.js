import request from '@/utils/request'

// 获取分类列表
export function getCategoryList(type) {
  return request({
    url: '/user/category/list',
    method: 'get',
    params: { type }
  })
}