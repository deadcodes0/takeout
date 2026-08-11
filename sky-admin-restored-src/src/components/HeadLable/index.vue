<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"HeadLable"},[(_vm.goback)?_c('span',{staticClass:"goBack",on:{"click":function($event){return _vm.goBack()}}},[_c('img',{attrs:{"src":require("@/assets/icons/btn_back@2x.png"),"alt":""}}),_vm._v(" 返回")]):_vm._e(),(!_vm.butList)?_c('span',[_vm._v(_vm._s(_vm.title))]):_vm._e(),(_vm.butList)?_c('div',[_vm._t("default")],2):_vm._e()])}
const __staticRenderFns__ = []



















import { Component, Prop, Vue } from 'vue-property-decorator'

@Component({ 'name': 'Hamburger', render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop({ 'default': false }) private goback!: boolean
  @Prop({ 'default': false }) private butList!: boolean
  @Prop({ 'default': '集团管理' }) private title!: string

  private toggleClick() {
    this.$emit('toggleClick')
  }

  private goBack() {
    this.$router.go(-1)
  }
}
</script>
