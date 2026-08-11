<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"selectInput"},[_c('el-input',{staticStyle:{"width":"100%"},attrs:{"type":"text","placeholder":"请选择口味","clearable":"","readonly":""},on:{"focus":function($event){return _vm.selectFlavor(true)},"blur":function($event){return _vm.outSelect(false)}},model:{value:(_vm.value),callback:function ($$v) {_vm.value=$$v},expression:"value"}}),(_vm.mak && _vm.dishFlavorsData.length)?_c('div',{staticClass:"flavorSelect"},[_vm._l((_vm.dishFlavorsData),function(it,ind){return _c('span',{key:ind,staticClass:"items",on:{"click":function($event){return _vm.checkOption(it, ind)}}},[_vm._v(_vm._s(it.name))])}),(_vm.dishFlavorsData == [])?_c('span',{staticClass:"none"},[_vm._v("无数据")]):_vm._e()],2):_vm._e()],1)}
const __staticRenderFns__ = []



























import { Component, Prop, Vue } from 'vue-property-decorator'

@Component({ name: 'selectInput', render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop({ default: [] }) private selectFlavorsData!: []
  @Prop({ default: [] }) private dishFlavorsData!: []
  @Prop({ default: '' }) private value!: number
  @Prop({ default: 0 }) private index!: number
  private keyValue = NaN

  private mak: boolean = false

  private selectFlavor(st: boolean) {
    this.mak = st
  }

  private outSelect(st: boolean) {
    const _this = this
    setTimeout(function () {
      _this.mak = st
    }, 200)
  }

  private inputHandle(val: any) {
    this.selectFlavor(false)
  }

  checkOption(val: any, ind: any) {
    this.$emit('select', val.name, this.index, ind)
    this.keyValue = val.name
  }
}
</script>
