import { createRouter, createWebHistory } from 'vue-router'
import { useUserStore } from '@/stores/userStore'

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/login/index.vue'),
    meta: { title: '登录' }
  },
  {
    path: '/qr-login',
    name: 'QrLogin',
    component: () => import('@/views/qrLogin/index.vue'),
    meta: { title: '二维码登录' }
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import('@/views/dashboard/index.vue'),
    meta: { title: '首页' }
  },
  {
    path: '/order',
    name: 'Order',
    component: () => import('@/views/order/index.vue'),
    meta: { title: '下单' }
  },
  {
    path: '/order-success',
    name: 'OrderSuccess',
    component: () => import('@/views/order/success.vue'),
    meta: { title: '订单成功' }
  },
  {
    path: '/address',
    name: 'Address',
    component: () => import('@/views/address/index.vue'),
    meta: { title: '收货地址' }
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import('@/views/profile/index.vue'),
    meta: { title: '个人中心' }
  },
  {
    path: '/favorites',
    name: 'Favorites',
    component: () => import('@/views/favorites/index.vue'),
    meta: { title: '收藏菜品' }
  },
  {
    path: '/coupons',
    name: 'Coupons',
    component: () => import('@/views/coupons/index.vue'),
    meta: { title: '优惠券' }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  document.title = to.meta.title || 'Sky Admin'
  const userStore = useUserStore()
  // 登录页面和二维码登录页面不需要 token
  if (to.path !== '/login' && to.path !== '/qr-login' && !userStore.isLoggedIn) {
    next('/login')
  } else {
    next()
  }
})

export default router