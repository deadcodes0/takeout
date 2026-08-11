<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"tab-change"},_vm._l((_vm.changedOrderList),function(item){return _c('div',{key:item.value,staticClass:"tab-item",class:{ active: item.value === _vm.activeIndex },on:{"click":function($event){return _vm.tabChange(item.value)}}},[_vm._v("\n      "+_vm._s(item.label)+"\n    ")],1)}),0)}
const __staticRenderFns__ = []




















import { Vue, Component, Prop, Watch } from 'vue-property-decorator'
import { getOrderDetailPage } from '@/api/order'

@Component({ name: 'TabChange', render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop({ default: '' }) orderStatics: any
  @Prop({ default: '' }) defaultActivity: any
  private activeIndex: number = this.defaultActivity || 0

  @Watch('defaultActivity')
  private onChange(val) {
    this.activeIndex = Number(val)
  }

  get changedOrderList() {
    return [
      {
        label: '全部订单',
        value: 0
      },
      {
        label: '待接单',
        value: 2,
        num: this.orderStatics.toBeConfirmed
      },
      {
        label: '待派送',
        value: 3,
        num: this.orderStatics.confirmed
      },
      {
        label: '派送中',
        value: 4,
        num: this.orderStatics.deliveryInProgress
      },
      {
        label: '已完成',
        value: 5
      },
      {
        label: '已取消',
        value: 6
      }
    ]
  }

  private tabChange(activeIndex) {
    this.activeIndex = activeIndex
    this.$emit('tabChange', activeIndex)
  }
}
</script>
