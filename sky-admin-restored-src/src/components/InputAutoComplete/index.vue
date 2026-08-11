<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"input-auto-complete"},[_c('el-input',{staticStyle:{"width":"250px"},attrs:{"placeholder":_vm.placeholder,"clearable":""},on:{"clear":_vm.init},nativeOn:{"keyup":function($event){if(!$event.type.indexOf('key')&&_vm._k($event.keyCode,"enter",13,$event.key,"Enter")){ return null; }return _vm.init($event)}},model:{value:(_vm.input),callback:function ($$v) {_vm.input=$$v},expression:"input"}},[_c('i',{staticClass:"el-input__icon el-icon-search",staticStyle:{"cursor":"pointer"},attrs:{"slot":"prefix"},on:{"click":_vm.init},slot:"prefix"})])],1)}
const __staticRenderFns__ = []























import { Vue, Component, Prop } from 'vue-property-decorator'
@Component({ name: 'InputAutoComplete', render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  private input: any = ''
  @Prop({ default: [] }) data: Array<any>
  @Prop({ default: '' }) placeholder: string
  @Prop({ default: 'name' }) ObKey: string

  init() {
    this.$emit('init', this.input)
  }
}
</script>
