<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"empty-box"},[_c('div',{staticClass:"img-box"},[_c('span',{staticClass:"empty-icon"},[_c('i',{staticClass:"el-icon-document"})]),_c('div',{staticClass:"empty-title"},[_vm._v(_vm._s(!_vm.isSearch ? '这里空空如也~' : 'Sorry，木有找到您搜索的内容哦~'))]),(!_vm.isSearch)?_c('div',{staticClass:"empty-desc"},[_vm._v("暂无订单数据，您可以尝试调整筛选条件或等待新订单")]):_vm._e()])])}
const __staticRenderFns__ = []
















import { Vue, Component, Prop } from 'vue-property-decorator'
@Component({ name: 'Empty', render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop({ default: false }) isSearch: boolean //用来区分是搜索还是默认无数据
}
</script>
