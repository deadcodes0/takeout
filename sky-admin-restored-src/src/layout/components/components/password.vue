<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('el-dialog',{staticClass:"pwdCon",attrs:{"title":"修改密码","visible":_vm.dialogFormVisible,"width":"568px"},on:{"update:visible":function($event){_vm.dialogFormVisible=$event},"close":function($event){return _vm.handlePwdClose()}}},[_c('el-form',{ref:"form",attrs:{"model":_vm.form,"label-width":"85px","rules":_vm.rules}},[_c('el-form-item',{attrs:{"label":"原始密码：","prop":"oldPassword"}},[_c('el-input',{attrs:{"type":"password","placeholder":"请输入"},model:{value:(_vm.form.oldPassword),callback:function ($$v) {_vm.$set(_vm.form, "oldPassword", $$v)},expression:"form.oldPassword"}})],1),_c('el-form-item',{attrs:{"label":"新密码：","prop":"newPassword"}},[_c('el-input',{attrs:{"type":"password","placeholder":"6 - 20位密码，数字或字母，区分大小写"},model:{value:(_vm.form.newPassword),callback:function ($$v) {_vm.$set(_vm.form, "newPassword", $$v)},expression:"form.newPassword"}})],1),_c('el-form-item',{attrs:{"label":"确认密码：","prop":"affirmPassword"}},[_c('el-input',{attrs:{"type":"password","placeholder":"请输入"},model:{value:(_vm.form.affirmPassword),callback:function ($$v) {_vm.$set(_vm.form, "affirmPassword", $$v)},expression:"form.affirmPassword"}})],1)],1),_c('div',{staticClass:"dialog-footer",attrs:{"slot":"footer"},slot:"footer"},[_c('el-button',{on:{"click":function($event){return _vm.handlePwdClose()}}},[_vm._v("取 消")]),_c('el-button',{attrs:{"type":"primary"},on:{"click":function($event){return _vm.handleSave()}}},[_vm._v("保 存")])],1)],1)}
const __staticRenderFns__ = []







































import { Component, Vue, Prop } from 'vue-property-decorator'
import { Form as ElForm, Input } from 'element-ui'
// 接口
import { editPassword } from '@/api/users'
import {getOrderListBy} from '@/api/order';
@Component({ name: 'Password', render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop() private dialogFormVisible!: any
  private validatePwd = (rule: any, value: any, callback: Function) => {
    const reg = /^[0-9A-Za-z]{6,20}$/
    if (!value) {
      callback(new Error('请输入'))
    } else if (!reg.test(value)) {
      callback(new Error('6 - 20位密码，数字或字母，区分大小写'))
    } else {
      callback()
    }
  }
  private validatePass2 = (rule, value, callback) => {
    if (!value) {
      callback(new Error('请再次输入密码'))
    } else if (value !== this.form.newPassword) {
      callback(new Error('密码不一致，请重新输入密码'))
    } else {
      callback()
    }
  }
  rules = {
    oldPassword: [{ validator: this.validatePwd, trigger: 'blur' }],
    newPassword: [{ validator: this.validatePwd, trigger: 'blur' }],
    affirmPassword: [{ validator: this.validatePass2, trigger: 'blur' }],
  }
  private form = {} as any
  private affirmPassword = ''
  handleSave() {
    ;(this.$refs.form as ElForm).validate(async (valid: boolean) => {
      if (valid) {
        const parnt = {
          oldPassword: this.form.oldPassword,
          newPassword: this.form.newPassword,
        }
        //await editPassword(parnt)

        editPassword(parnt)
          .then((res) => {
            if (res.data.code === 1) {
              this.$message.success('密码修改成功')
            } else {
              this.$message.error(res.data.msg)
            }
          })
          .catch((err) => {
            this.$message.error('请求出错了：' + err.message)
          })
        this.$emit('handleclose')
        ;(this.$refs.form as ElForm).resetFields()
      } else {
        return false
      }
    })
  }
  handlePwdClose() {
    ;(this.$refs.form as ElForm).resetFields()
    this.$emit('handleclose')
  }
}
</script>
