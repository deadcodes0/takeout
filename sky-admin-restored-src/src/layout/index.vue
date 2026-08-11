<template>
  <div class="app-wrapper" :class="classObj">
    <div
      v-if="classObj.mobile && sidebar.opened"
      class="drawer-bg"
      @click="handleClickOutside"
    />
    <sidebar class="sidebar-container" />
    <div class="main-container">
      <navbar />
      <app-main />
    </div>
  </div>
</template>

<script lang="ts">
import { Component } from 'vue-property-decorator'
import { mixins } from 'vue-class-component'
import { DeviceType, AppModule } from '@/store/modules/app'
import { AppMain, Navbar, Sidebar } from './components'
import ResizeMixin from './mixin/resize'

@Component({
  name: 'Layout',
  components: { AppMain, Navbar, Sidebar },
})
export default class extends mixins(ResizeMixin) {
  get classObj() {
    return {
      hideSidebar: !this.sidebar.opened,
      openSidebar: this.sidebar.opened,
      withoutAnimation: this.sidebar.withoutAnimation,
      mobile: this.device === DeviceType.Mobile,
    }
  }

  get sidebar() {
    return AppModule.sidebar
  }

  private handleClickOutside() {
    AppModule.CloseSideBar(false)
  }
}
</script>

<style lang="scss" scoped>
.app-wrapper {
  position: relative;
  height: 100%;
  width: 100%;
  min-width: 1366px;
  overflow-x: auto;
  overflow-y: hidden;

  &:after {
    content: '';
    display: table;
    clear: both;
  }
}

.main-container {
  height: 100%;
  min-height: 100%;
  transition: margin-left 0.28s;
  margin-left: 190px;
  background: #f0f0f0;
  position: relative;
  width: calc(100% - 190px);
}

.sidebar-container {
  transition: width 0.28s;
  width: 190px !important;
  height: 100%;
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 1001;
  overflow-x: hidden;
  overflow-y: auto;
}

// 折叠状态
.hideSidebar {
  .main-container {
    margin-left: 80px;
    width: calc(100% - 80px);
  }

  .sidebar-container {
    width: 80px !important;
  }
}

// 移动端
.mobile {
  .main-container {
    margin-left: 0;
  }

  .sidebar-container {
    transition: transform 0.28s;
    width: 190px !important;
  }

  &.hideSidebar {
    .sidebar-container {
      pointer-events: none;
      transition-duration: 0.3s;
      transform: translate3d(-190px, 0, 0);
    }
  }
}

.withoutAnimation {
  .main-container,
  .sidebar-container {
    transition: none;
  }
}
</style>

<!-- 全局布局优化：减少留白 -->
<style lang="scss">
// 主内容区域 - 减少内边距
.app-main {
  padding: 12px !important;
  min-height: calc(100vh - 60px);
  background: #f0f2f5;
}

// Element UI 卡片 - 减少内边距
.el-card {
  border-radius: 12px;
  
  .el-card__body {
    padding: 16px !important;
  }
}

// Element UI 主区域 - 减少内边距
.el-main {
  padding: 12px !important;
}

// Element UI 容器
.el-container {
  min-height: 100%;
}

// 表格单元格 - 减少内边距
.el-table .cell,
.el-table th > .cell {
  padding-left: 8px !important;
  padding-right: 8px !important;
}

// 表格行高优化
.el-table td,
.el-table th {
  padding: 8px 0 !important;
}

// 弹窗内边距优化
.el-dialog__body {
  padding: 16px 20px !important;
}

.el-dialog__header {
  padding: 12px 20px !important;
}

.el-dialog__footer {
  padding: 12px 20px !important;
}

// 表单项间距优化
.el-form-item {
  margin-bottom: 16px !important;
}

// 分页组件优化
.el-pagination {
  padding: 8px 0 !important;
}
</style>
