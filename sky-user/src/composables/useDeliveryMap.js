import { useAmap } from '@/composables/useAmap'
import { SHOP_LOCATION, DELIVERY_SPEED_KMH } from '@/utils/constants'

/**
 * 配送地图 composable
 * 
 * 提供：
 * 1. geocodeAddress(address) - 地址 → 经纬度
 * 2. calculateDeliveryRoute(mapInstance, addrLng, addrLat) - 路线规划 + 地图渲染
 * 3. startDeliverySimulation(mapInstance, polyline, durationMinutes, callbacks) - 配送模拟动画
 * 
 * @returns {{ geocodeAddress: Function, calculateDeliveryRoute: Function, calculateStraightDistance: Function, startDeliverySimulation: Function }}
 */
export function useDeliveryMap() {
  const { load } = useAmap()

  // 缓存 AMap 构造函数引用，供 startDeliverySimulation 同步使用
  let _AMap = null

  /**
   * 地理编码：将文字地址转换为经纬度坐标
   * @param {string} address - 完整地址文本（如 "北京市朝阳区xxx"）
   * @param {string} [city] - 城市名称，提高编码准确度
   * @returns {Promise<{ longitude: number, latitude: number }>}
   */
  const geocodeAddress = async (address, city = '') => {
    const AMap = await load(['AMap.Geocoder'])

    const geocoder = new AMap.Geocoder({
      city: city || '全国'
    })

    return new Promise((resolve, reject) => {
      geocoder.getLocation(address, (status, result) => {
        if (status === 'complete' && result.geocodes && result.geocodes.length > 0) {
          const { lng, lat } = result.geocodes[0].location
          resolve({
            longitude: lng,
            latitude: lat
          })
        } else {
          reject(new Error('地理编码失败，请检查地址是否正确'))
        }
      })
    })
  }

  /**
   * 计算配送路线并在地图上渲染
   * 
   * @param {AMap.Map} mapInstance - 高德地图实例
   * @param {number} addrLng - 收货地址经度
   * @param {number} addrLat - 收货地址纬度
   * @returns {Promise<{ distance: number, duration: number, polyline: Array }>}
   *   - distance: 距离（公里）
   *   - duration: 预计时间（分钟）
   *   - polyline: 路线轨迹点数组
   */
  const calculateDeliveryRoute = async (mapInstance, addrLng, addrLat) => {
    const AMap = await load(['AMap.Driving'])
    _AMap = AMap  // 缓存供模拟动画使用

    // 店铺坐标
    const origin = [SHOP_LOCATION.longitude, SHOP_LOCATION.latitude]
    const destination = [addrLng, addrLat]

    // 添加店铺标记
    new AMap.Marker({
      map: mapInstance,
      position: origin,
      title: '苍穹外卖',
      content: `
        <div style="
          background: #1890ff;
          color: #fff;
          padding: 4px 10px;
          border-radius: 4px;
          font-size: 12px;
          white-space: nowrap;
          box-shadow: 0 2px 6px rgba(0,0,0,0.3);
        ">
          🏪 店铺
        </div>
      `,
      offset: new AMap.Pixel(-30, -15)
    })

    // 添加收货地址标记
    new AMap.Marker({
      map: mapInstance,
      position: destination,
      title: '收货地址',
      content: `
        <div style="
          background: #ff6b6b;
          color: #fff;
          padding: 4px 10px;
          border-radius: 4px;
          font-size: 12px;
          white-space: nowrap;
          box-shadow: 0 2px 6px rgba(0,0,0,0.3);
        ">
          📍 收货地址
        </div>
      `,
      offset: new AMap.Pixel(-30, -15)
    })

    const driving = new AMap.Driving({
      policy: AMap.DrivingPolicy.LEAST_TIME,
      showTraffic: true
    })

    return new Promise((resolve, reject) => {
      driving.search(origin, destination, (status, result) => {
        if (status === 'complete' && result.routes && result.routes.length > 0) {
          const route = result.routes[0]

          // 提取路径点绘制轨迹
          const path = []
          route.steps.forEach(step => {
            path.push(...step.path)
          })

          // 绘制路线
          const polyline = new AMap.Polyline({
            path,
            strokeColor: '#1890ff',
            strokeWeight: 6,
            strokeOpacity: 0.9,
            lineJoin: 'round',
            lineCap: 'round',
            showDir: true
          })
          mapInstance.add(polyline)

          // 适配视野
          mapInstance.setFitView(null, false, [60, 60, 60, 60])

          resolve({
            distance: (route.distance / 1000).toFixed(1),
            duration: Math.round(route.time / 60),
            polyline: path
          })
        } else {
          // 驾车路线规划失败，回退到直线距离估算
          const straightDistance = calcStraightDistance(
            origin[1], origin[0],
            addrLat, addrLng
          )
          const estimatedDuration = Math.round((straightDistance / DELIVERY_SPEED_KMH) * 60)

          resolve({
            distance: straightDistance.toFixed(1),
            duration: estimatedDuration,
            polyline: [[origin, destination]]
          })
        }
      })
    })
  }

  /**
   * 计算两点之间的直线距离（Haversine 公式）
   * @param {number} lat1
   * @param {number} lng1
   * @param {number} lat2
   * @param {number} lng2
   * @returns {number} 距离（公里）
   */
  const calcStraightDistance = (lat1, lng1, lat2, lng2) => {
    const R = 6371 // 地球半径（公里）
    const dLat = ((lat2 - lat1) * Math.PI) / 180
    const dLng = ((lng2 - lng1) * Math.PI) / 180
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos((lat1 * Math.PI) / 180) *
        Math.cos((lat2 * Math.PI) / 180) *
        Math.sin(dLng / 2) *
        Math.sin(dLng / 2)
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    return R * c
  }

  /**
   * 配送模拟动画：让一个移动标记沿路线前进
   * 每 1 分钟更新一次位置，一次前进多个路径点
   * 
   * @param {AMap.Map} mapInstance - 高德地图实例
   * @param {Array} polyline - 路线坐标点数组 [[lng,lat], ...]
   * @param {number} durationMinutes - 实际配送耗时（分钟）
   * @param {Object} [callbacks] - 可选回调
   * @param {Function} [callbacks.onProgress] - 每帧回调 (progress: 0~1)
   * @param {Function} [callbacks.onComplete] - 动画完成回调
   * @param {number} [startStep=0] - 从第几步开始（支持断点续播）
   * @returns {{ stop: Function }} - 返回 stop() 用于手动停止动画
   */
  const startDeliverySimulation = (mapInstance, polyline, durationMinutes, callbacks = {}, startStep = 0) => {
    const AMap = _AMap
    if (!AMap) return { stop: () => {} }
    const { onProgress, onComplete } = callbacks

    const totalSteps = polyline.length
    if (totalSteps < 2) return { stop: () => {} }

    // 每 1 分钟更新一次
    const INTERVAL_MS = 60000
    // 每次前进多少步（按实际配送时长分摊）
    const stepsPerTick = Math.ceil(totalSteps * INTERVAL_MS / (durationMinutes * 60000))

    // 1. 创建配送员标记
    const deliveryMarker = new AMap.Marker({
      map: mapInstance,
      position: polyline[startStep] || polyline[0],
      offset: new AMap.Pixel(-16, -16),
      content: `
        <div style="
          width: 32px; height: 32px;
          background: linear-gradient(135deg, #1890ff, #096dd9);
          border: 3px solid #fff;
          border-radius: 50%;
          box-shadow: 0 2px 8px rgba(24,144,255,0.6);
          display: flex; align-items: center; justify-content: center;
          font-size: 14px; color: #fff;
        ">🏍</div>
      `,
      zIndex: 120
    })

    // 2. 已走过的路径（绿色弧线）
    const passedPath = []
    for (let i = 0; i <= startStep && i < totalSteps; i++) {
      passedPath.push(polyline[i])
    }
    const passedPolyline = new AMap.Polyline({
      path: passedPath,
      strokeColor: '#52c41a',
      strokeWeight: 8,
      strokeOpacity: 1,
      lineJoin: 'round',
      lineCap: 'round'
    })
    mapInstance.add(passedPolyline)

    // 如果已经走完，直接完成
    if (startStep >= totalSteps - 1) {
      if (onComplete) onComplete()
      return { stop: () => {} }
    }

    // 3. 开始逐级前进
    let stepIndex = startStep
    let animating = true

    const tick = () => {
      if (!animating) return

      // 本次要到达的步数（不超过总步数）
      const nextStep = Math.min(stepIndex + stepsPerTick, totalSteps)

      // 添加中间所有路径点（画出平滑绿线）
      for (let i = stepIndex; i < nextStep; i++) {
        passedPath.push(polyline[i])
      }
      passedPolyline.setPath(passedPath)

      // 标记移到最新位置
      deliveryMarker.setPosition(polyline[nextStep - 1])

      stepIndex = nextStep
      const progress = stepIndex / totalSteps

      if (onProgress) {
        onProgress(Math.min(progress, 1))
      }

      if (stepIndex >= totalSteps) {
        // 到达终点
        if (onComplete) onComplete()
        return
      }

      simTimer = setTimeout(tick, INTERVAL_MS)
    }

    let simTimer = setTimeout(tick, INTERVAL_MS)

    return {
      stop: () => {
        animating = false
        clearTimeout(simTimer)
      }
    }
  }

  return {
    geocodeAddress,
    calculateDeliveryRoute,
    calculateStraightDistance: calcStraightDistance,
    startDeliverySimulation
  }
}