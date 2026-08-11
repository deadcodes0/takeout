<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return (_vm.isExternal(_vm.to))?_c('a',{attrs:{"href":_vm.to,"target":"_blank","rel":"noopener"}},[_vm._t("default")],2):_c('router-link',{attrs:{"to":_vm.to}},[_vm._t("default")],2)}
const __staticRenderFns__ = []











import { Component, Prop, Vue } from 'vue-property-decorator'
import { isExternal } from '@/utils/validate'

@Component({ 'name': 'SidebarItemLink', render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop({ 'required': true }) private to!: string

  private isExternal = isExternal
}
</script>
