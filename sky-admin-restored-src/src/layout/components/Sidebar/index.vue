<template>
  <div>
    <div class="logo">
      <div v-if="!isCollapse" class="sidebar-logo">
        <img style="width: 140px; height: 32px" src="@/assets/logo.svg" />
      </div>
      <div v-else class="sidebar-logo-mini">
        <img style="width: 32px; height: 32px" src="@/assets/mini-logo.svg" />
      </div>
    </div>
    <el-scrollbar wrap-class="scrollbar-wrapper">
      <el-menu
        :default-openeds="defOpen"
        :default-active="defAct"
        :collapse="isCollapse"
        :background-color="variables.menuBg"
        :text-color="variables.menuText"
        :active-text-color="variables.menuActiveText"
        :unique-opened="false"
        :collapse-transition="false"
        mode="vertical"
      >
        <sidebar-item
          v-for="route in routes"
          :key="route.path"
          :item="route"
          :base-path="route.path"
          :is-collapse="isCollapse"
        />
      </el-menu>
    </el-scrollbar>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import { AppModule } from '@/store/modules/app'
import { UserModule } from '@/store/modules/user'
import SidebarItem from './SidebarItem.vue'
import variables from '@/styles/_variables.scss'
import Cookies from 'js-cookie'

@Component({ name: 'SideBar', components: { SidebarItem } })
export default class extends Vue {
  private restKey: number = 0

  get name() {
    return (UserModule.userInfo as any).name
      ? (UserModule.userInfo as any).name
      : JSON.parse(Cookies.get('user_info') as any).name
  }

  get defOpen() {
    let path = ['/']
    this.routes.forEach((n: any, i: number) => {
      if (n.meta.roles && n.meta.roles[0] === this.roles[0]) {
        path.splice(0, 1, n.path)
      }
    })
    return path
  }

  get defAct() {
    return this.$route.path
  }

  get sidebar() {
    return AppModule.sidebar
  }

  get roles() {
    return UserModule.roles
  }

  get routes() {
    let routes = JSON.parse(
      JSON.stringify([...(this.$router as any).options.routes])
    )
    let menuList = []
    let menu = routes.find((item: any) => item.path === '/')
    if (menu) {
      menuList = menu.children
    }
    return menuList
  }

  get variables() {
    return variables
  }

  get isCollapse() {
    return !this.sidebar.opened
  }

  private async logout() {
    this.$store.dispatch('LogOut').then(() => {
      this.$router.replace({ path: '/login' })
    })
  }
}
</script>

<style lang="scss" scoped>
.logo {
  text-align: center;
  background-color: #f9f9f9;
  padding: 16px 0;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-bottom: 1px solid #e8e8e8;

  img {
    display: inline-block;
    transition: all 0.3s ease;
  }
}

.sidebar-logo-mini {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>

<style lang="scss">
// 侧边栏样式：选中框蓝色，无圆点，无下划线，图标在文字左边
.sidebar-container {
  background: #f9f9f9 !important;
  border-right: 1px solid #e8e8e8;
  box-shadow: none;

  .el-menu {
    border: none;
    height: 100%;
    width: 100% !important;
    background: #f9f9f9 !important;
  }

  // 移除所有圆点 / 列表样式
  ul, li, .el-menu-item, .el-submenu {
    list-style: none !important;
  }

  .el-menu-item, .el-submenu__title {
    list-style: none !important;

    &::before, &::after {
      content: none !important;
    }
  }

  // 所有菜单项 - 按照 task.md 设计
  .el-menu .el-menu-item {
    color: #595959 !important;
    height: 48px;
    line-height: 48px;
    padding-left: 20px !important;
    padding-right: 16px !important;
    margin: 2px 12px 2px 0;
    border-radius: 0 20px 20px 0;
    background: transparent !important;
    font-weight: 400;
    font-size: 14px;
    width: calc(100% - 12px) !important;
    box-sizing: border-box !important;

    // Element UI 图标在文字左边
    i.el-icon, i[class^="el-icon-"] {
      color: inherit;
      font-size: 18px;
      margin-right: 12px;
      width: 20px;
      text-align: center;
      vertical-align: middle;
    }

    span {
      color: inherit;
      font-size: 14px;
      vertical-align: middle;
      text-decoration: none !important;
    }

    // 移除下划线
    text-decoration: none !important;
  }

  // hover：浅蓝背景
  .el-menu .el-menu-item:hover {
    color: #2b6ef0 !important;
    background: #e8edf9 !important;
    border-radius: 0 20px 20px 0 !important;
    margin: 2px 12px 2px 0 !important;
    width: calc(100% - 12px) !important;

    i.el-icon, i[class^="el-icon-"], span {
      color: #2b6ef0;
      text-decoration: none !important;
    }
  }

  // 选中状态：蓝色背景框 - 增强优先级
  .el-menu .router-link-exact-active .el-menu-item,
  .el-menu .router-link-active .el-menu-item,
  .el-menu-item.is-active,
  a.router-link-exact-active .el-menu-item,
  a.router-link-active .el-menu-item {
    background: #e8edf9 !important;
    color: #2b6ef0 !important;
    font-weight: 500;
    border-radius: 0 20px 20px 0 !important;
    margin: 2px 12px 2px 0 !important;
    padding-right: 16px !important;
    width: calc(100% - 12px) !important;

    i.el-icon, i[class^="el-icon-"] {
      color: #2b6ef0 !important;
    }

    span {
      color: #2b6ef0 !important;
      font-weight: 500;
      text-decoration: none !important;
    }

    &::before, &::after {
      content: none !important;
      display: none;
    }
  }

  // 子菜单激活
  .el-submenu.is-active > .el-submenu__title {
    color: #2b6ef0 !important;

    i.el-icon, i[class^="el-icon-"] {
      color: #2b6ef0 !important;
    }

    span {
      color: #2b6ef0 !important;
      text-decoration: none !important;
    }
  }

  // 子菜单样式
  .el-submenu .el-menu-item,
  .el-submenu > .el-submenu__title {
    min-width: 0 !important;
    width: calc(100% - 12px) !important;
    background-color: #f9f9f9 !important;
    color: #595959 !important;
    padding-right: 16px !important;
    margin: 2px 12px 2px 0;

    i.el-icon, i[class^="el-icon-"] {
      color: #595959;
    }

    span {
      text-decoration: none !important;
    }
  }

  .el-submenu > .el-submenu__title:hover {
    background-color: #f0f0f0 !important;
    color: #333 !important;

    i.el-icon, i[class^="el-icon-"] { color: #333; }
  }

  .el-menu-item {
    position: relative;
    font-size: 14px !important;
    padding-left: 20px !important;
    padding-right: 16px !important;
    margin: 2px 12px 2px 0 !important;
    width: calc(100% - 12px) !important;
    text-decoration: none !important;

    i.el-icon, i[class^="el-icon-"] {
      color: inherit;
      font-size: 18px;
      margin-right: 12px;
      width: 20px;
      text-align: center;
    }
  }

  // 移除所有下划线
  a, a:hover, a:focus, a:active,
  .el-menu-item a, .router-link-active,
  .sidebar-item-link, .sidebar-item-link:hover {
    text-decoration: none !important;
  }

  .el-icon-arrow-down:before {
    color: #595959;
  }

  .el-submenu__title {
    font-size: 14px !important;
    position: relative;
    z-index: 9;
    color: #595959 !important;

    &:hover {
      background-color: #f0f0f0 !important;
      color: #333 !important;
    }

    i {
      font-size: 18px;
      margin-right: 10px;
    }
  }

  // ===== 按照 task.md 方案修复滚动条裁剪问题 =====
  // 覆盖 el-scrollbar 的负边距
  .el-scrollbar__wrap {
    margin-right: 0 !important;
    margin-bottom: 0 !important;
    overflow-x: hidden !important;
    overflow-y: auto !important;
  }

  // 隐藏滚动条（Chrome/Safari/Edge）
  .el-scrollbar__wrap::-webkit-scrollbar {
    width: 0;
    height: 0;
  }

  // Firefox 隐藏滚动条
  .el-scrollbar__wrap {
    scrollbar-width: none;
  }

  .scrollbar-wrapper {
    overflow-x: hidden !important;
    overflow-y: auto !important;
  }

  .el-scrollbar__bar.is-horizontal {
    display: none !important;
  }

  .el-scrollbar__bar.is-vertical {
    display: none !important;
  }

  // 确保 menu-wrapper 不被裁剪
  .menu-wrapper {
    overflow: visible !important;
  }

  .el-scrollbar__view {
    overflow: visible !important;
    height: 100%;
    padding-bottom: 20px !important;
  }

  .svg-fill {
    margin-right: 7px;
  }

  // 折叠模式
  .el-menu--collapse .el-menu .el-menu-item {
    padding-left: 0 !important;
  }
}

// 折叠弹出菜单
.el-menu--vertical .el-menu--popup {
  background: #f9f9f9;
  border: 1px solid #e8e8e8;
  border-radius: 6px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);

  .el-menu-item {
    color: #595959;
    background: transparent !important;
    text-decoration: none !important;

    &:hover {
      background: #f0f0f0 !important;
      color: #333;
    }

    &.is-active {
      background: #e8f0fe !important;
      color: #2b6ef0;

      i { color: #2b6ef0 !important; }
      span { color: #2b6ef0; }
    }

    i {
      color: #595959;
      font-size: 18px;
      margin-right: 10px;
    }
  }
}
</style>
