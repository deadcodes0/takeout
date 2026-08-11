<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{class:[{'is-active': _vm.isActive}],on:{"click":_vm.toggleClick}},[_c('svg-icon',{attrs:{"name":"hamburger","width":"20","height":"20"}})],1)}
const __staticRenderFns__ = []








import { Component, Prop, Vue } from 'vue-property-decorator'

@Component({ 'name': 'Hamburger', render: __render__, staticRenderFns: __staticRenderFns__ })

export default class extends Vue {
  @Prop({ 'default': false }) private isActive!: boolean

  private toggleClick() {
    this.$emit('toggleClick');
  }
}
</script>
