// 注册所有 SVG 图标组件
import Vue from 'vue'
import SvgIcon from 'vue-svgicon'

// 导入所有图标
import './dashboard'
import './employee'
import './hamburger'
import './inform'
import './main'
import './pay'
import './shop'
import './vip'

Vue.use(SvgIcon, {
  tagName: 'svg-icon'
})