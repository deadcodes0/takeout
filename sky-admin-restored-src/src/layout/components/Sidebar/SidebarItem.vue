<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',[(!_vm.item.meta || !_vm.item.meta.hidden)?_c('div',{class:['menu-wrapper', 'full-mode', { 'first-level': _vm.isFirstLevel }]},[(_vm.theOnlyOneChild && !_vm.theOnlyOneChild.children)?[(_vm.theOnlyOneChild.meta)?_c('sidebar-item-link',{attrs:{"to":_vm.resolvePath(_vm.theOnlyOneChild.path)}},[_c('el-menu-item',{class:{ 'submenu-title-noDropdown': _vm.isFirstLevel },attrs:{"index":_vm.resolvePath(_vm.theOnlyOneChild.path)}},[(_vm.theOnlyOneChild.meta.icon)?_c('i',{staticClass:"el-icon",class:_vm.theOnlyOneChild.meta.icon}):_vm._e(),(_vm.theOnlyOneChild.meta.title)?_c('span',{attrs:{"slot":"title"},slot:"title"},[_vm._v(_vm._s(_vm.theOnlyOneChild.meta.title))]):_vm._e()])],1):_vm._e()]:_c('el-submenu',{attrs:{"index":_vm.resolvePath(_vm.item.path),"popper-append-to-body":""}},[_c('template',{slot:"title"},[(_vm.item.meta && _vm.item.meta.icon)?_c('i',{staticClass:"el-icon",class:_vm.item.meta.icon}):_vm._e(),(_vm.item.meta && _vm.item.meta.title)?_c('span',{attrs:{"slot":"title"},slot:"title"},[_vm._v(_vm._s(_vm.item.meta.title))]):_vm._e()]),(_vm.item.children)?_vm._l((_vm.item.children),function(child){return _c('sidebar-item',{key:child.path,staticClass:"nest-menu",attrs:{"item":child,"is-collapse":_vm.isCollapse,"is-first-level":false,"base-path":_vm.resolvePath(child.path)}})}):_vm._e()],2)],2):_vm._e()])}
const __staticRenderFns__ = []





























































import path from 'path'
import { Component, Prop, Vue } from 'vue-property-decorator'
import { UserModule } from '@/store/modules/user'
import { Route, RouteConfig } from 'vue-router'
import { isExternal } from '@/utils/validate'
import SidebarItemLink from './SidebarItemLink.vue'

@Component({ name: 'SidebarItem',
  components: {
    SidebarItemLink,
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop({ required: true }) private item!: RouteConfig
  @Prop({ default: false }) private isCollapse!: boolean
  @Prop({ default: true }) private isFirstLevel!: boolean
  @Prop({ default: '' }) private basePath!: string

  get showingChildNumber() {
    if (this.item.children) {
      const showingChildren = this.item.children.filter((item) => {
        if (item.meta && item.meta.hidden) {
          return false
        }
        return true
      })
      return showingChildren.length
    }
    return 0
  }

  get roles() {
    return UserModule.roles
  }

  get theOnlyOneChild() {
    if (this.showingChildNumber > 0) {
      return null
    }
    if (this.item.children) {
      for (let child of this.item.children) {
        if (!child.meta || !child.meta.hidden) {
          return child
        }
      }
    }
    // If there is no children, return itself with path removed,
    // because this.basePath already conatins item's path information
    return { ...this.item, path: '' }
  }

  private resolvePath(routePath: string) {
    if (isExternal(routePath)) {
      return routePath
    }
    if (isExternal(this.basePath)) {
      return this.basePath
    }
    return path.resolve(this.basePath, routePath)
  }
}
</script>
