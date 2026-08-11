import request from '@/utils/request'

/**
 * 生成二维码登录链接
 * @returns {Promise} 包含qrUrl和sessionId
 */
export function generateQrCode() {
  return request({
    url: '/user/qr-login/generate',
    method: 'get'
  })
}

/**
 * 检查二维码登录状态
 * @param {string} sessionId 会话标识
 * @returns {Promise} 包含status、userId、token、openid
 */
export function checkLoginStatus(sessionId) {
  return request({
    url: '/user/qr-login/check',
    method: 'get',
    params: { sessionId }
  })
}
