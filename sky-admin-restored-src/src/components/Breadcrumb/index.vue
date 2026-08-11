<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('el-breadcrumb',{staticClass:"app-breadcrumb",attrs:{"separator":"/"}},[_c('transition-group',{attrs:{"name":"breadcrumb"}},_vm._l((_vm.breadcrumbs),function(item,index){return _c('el-breadcrumb-item',{key:item.path},[(item.redirect === 'noredirect' || index === _vm.breadcrumbs.length-1)?_c('span',{staticClass:"no-redirect"},[_vm._v(_vm._s(item.meta.title))]):_c('a',{on:{"click":function($event){$event.preventDefault();return _vm.handleLink(item)}}},[_vm._v(_vm._s(item.meta.title))])])}),1)],1)}
const __staticRenderFns__ = []

























import pathToRegexp from 'path-to-regexp'
import { Component, Vue, Watch } from 'vue-property-decorator'
import { RouteRecord, Route } from 'vue-router'

@Component({ 'name': 'Breadcrumb', render: __render__, staticRenderFns: __staticRenderFns__ })

export default class extends Vue {
  private breadcrumbs: RouteRecord[] = []
  @Watch('$route')
  private onRouteChange(route: Route) {
    // if you go to the redirect page, do not update the breadcrumbs
    if (route.path.startsWith('/redirect/')) {
      return
    }

    this.getBreadcrumb()
  }

  created () {
    this.getBreadcrumb()
  }

  private getBreadcrumb () {
    let matched = this.$route.matched.filter(
      item => item.meta && item.meta.title
    )
    const first = matched[0]
    // if (!this.isDashboard(first)) {
    //   matched = [
    //     { path: '/', meta: { title: '集团管理' } } as RouteRecord
    //   ].concat(matched)
    // }
    this.breadcrumbs = matched.filter(item => {
      return item.meta && item.meta.title && item.meta.breadcrumb !== false
    })
  }

  private isDashboard (route: RouteRecord) {
    const name = route && route.meta && route.meta.title
    return name === '集团管理'
  }

  private pathCompile (path: string) {
    // To solve this problem https://github.com/PanJiaChen/vue-element-admin/issues/561
    const { params } = this.$route
    const toPath = pathToRegexp.compile(path)
    return toPath(params)
  }

  private handleLink (item: any) {
    const { redirect, path } = item
    if (redirect) {
      this.$router.push(redirect)
      return
    }
    this.$router.push(this.pathCompile(path))
  }
}
</script>
