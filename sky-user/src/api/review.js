import request from '@/utils/request'

// 提交评价
export function submitReview(data) {
  return request({
    url: '/user/review/submit',
    method: 'post',
    data
  })
}