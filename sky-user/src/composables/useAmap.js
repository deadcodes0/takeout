import { shallowRef } from 'vue'
import AMapLoader from '@amap/amap-jsapi-loader'
import { AMAP_CONFIG } from '@/config/amap.config'

/**
 * 高德地图 JSAPI 加载器 composable
 * 
 * 封装 AMapLoader，提供：
 * - 单例加载（复用已加载的 AMap 实例）
 * - 按需加载插件
 * - 安全密钥配置
 * 
 * @param {string[]} plugins - 需要预加载的插件列表
 * @returns {{ AMap: import('vue').ShallowRef, load: Function, isLoaded: import('vue').ComputedRef }}
 */
export function useAmap(plugins = []) {
  const AMap = shallowRef(null)
  let loadPromise = null

  /**
   * 加载高德地图 JSAPI
   * @param {string[]} extraPlugins - 额外需要加载的插件
   * @returns {Promise} AMap 构造函数
   */
  const load = async (extraPlugins = []) => {
    if (AMap.value) return AMap.value

    if (!loadPromise) {
      // 合并插件列表
      const allPlugins = [...new Set([...plugins, ...extraPlugins])]

      // 安全密钥配置（开发环境直接配置，生产环境请用代理）
      window._AMapSecurityConfig = {
        securityJsCode: AMAP_CONFIG.SECURITY_CODE
      }

      loadPromise = AMapLoader.load({
        key: AMAP_CONFIG.KEY,
        version: '2.0',
        plugins: allPlugins
      }).then((AMapInstance) => {
        // SKILL.md 强制要求：设置 appname 埋点
        AMapInstance.getConfig().appname = 'amap-jsapi-skill'
        AMap.value = AMapInstance
        return AMapInstance
      }).catch((error) => {
        loadPromise = null
        console.error('高德地图加载失败', error)
        throw error
      })
    }

    return loadPromise
  }

  return {
    AMap,
    load
  }
}