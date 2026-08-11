<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"title-index"},[_c('div',{staticClass:"month"},[_c('ul',{staticClass:"tabs"},_vm._l((_vm.tabsParam),function(item,index){return _c('li',{key:index,staticClass:"li-tab",class:{ active: index === _vm.nowIndex },on:{"click":function($event){return _vm.toggleTabs(index)}}},[_vm._v("\n        "+_vm._s(item)+"\n        "),_c('span')])}),0)]),_c('div',{staticClass:"get-time"},[_c('p',[_vm._v("\n      已选时间："+_vm._s(_vm.tateData[0])+" 至\n      "+_vm._s(_vm.tateData[_vm.tateData.length - 1])+"\n    ")])]),_c('el-button',{staticClass:"right-el-button",attrs:{"icon":"iconfont icon-download"},on:{"click":_vm.handleExport}},[_vm._v("数据导出")])],1)}
const __staticRenderFns__ = []

































import { Component, Vue, Prop, Watch } from 'vue-property-decorator'
import { exportInfor } from '@/api/index'
@Component({ name: 'TitleIndex', render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop() private flag!: any
  @Prop() private tateData!: any
  @Prop() private turnoverData!: any

  nowIndex = 2 - 1
  value = []
  tabsParam = ['昨日', '近7日', '近30日', '本周', '本月']
  @Watch('flag')
  getNowIndex(val) {
    this.nowIndex = val
  }
  // tab切换
  toggleTabs(index: number) {
    this.nowIndex = index
    this.value = []
    this.$emit('sendTitleInd', index + 1)
  }
  //  数据导出
  /** 导出按钮操作 */
  handleExport() {
    this.$confirm('是否确认导出最近30天运营数据?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    })
      .then(async function () {
        const { data } = await exportInfor()
        let url = window.URL.createObjectURL(data)
        var a = document.createElement('a')
        document.body.appendChild(a)
        a.href = url
        a.download = '运营数据统计报表.xlsx'
        a.click()
        window.URL.revokeObjectURL(url)
      })
      .then((response) => {})
  }
}
</script>
