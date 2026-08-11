// 高德地图配置
// 请将以下配置替换为你的高德地图API Key和安全密钥

export const AMAP_CONFIG = {
  // 高德地图API Key
  // 申请地址：https://console.amap.com/dev/key/app
  KEY: 'fde99129839e734d92a610567656cb95',
  
  // 高德地图安全密钥（JSAPI v2.0强制要求）
  // 申请地址：https://console.amap.com/dev/key/app
  SECURITY_CODE: '53121f464a3ffeb5522019260361392a'
}

// 使用说明：
// 1. 访问 https://console.amap.com/ 注册并登录高德开放平台
// 2. 进入「应用管理」→「我的应用」
// 3. 点击「创建新应用」，填写应用名称
// 4. 添加Key，选择「Web端(JS API)」服务平台
// 5. 获取Key和安全密钥，替换上面的配置
// 
// 注意：
// - 开发环境可以直接使用安全密钥
// - 生产环境建议使用代理服务器方式，参考：https://lbs.amap.com/api/javascript-api-v2/guide/abc/jscode