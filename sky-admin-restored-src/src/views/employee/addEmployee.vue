<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"addBrand-container"},[_c('HeadLable',{attrs:{"title":_vm.title,"goback":true}}),_c('div',{staticClass:"container"},[_c('el-form',{ref:"ruleForm",staticClass:"demo-ruleForm",attrs:{"model":_vm.ruleForm,"rules":_vm.rules,"inline":false,"label-width":"180px"}},[_c('el-form-item',{attrs:{"label":"账号:","prop":"username"}},[_c('el-input',{attrs:{"placeholder":"请输入账号","maxlength":"20"},model:{value:(_vm.ruleForm.username),callback:function ($$v) {_vm.$set(_vm.ruleForm, "username", $$v)},expression:"ruleForm.username"}})],1),_c('el-form-item',{attrs:{"label":"员工姓名:","prop":"name"}},[_c('el-input',{attrs:{"placeholder":"请输入员工姓名","maxlength":"12"},model:{value:(_vm.ruleForm.name),callback:function ($$v) {_vm.$set(_vm.ruleForm, "name", $$v)},expression:"ruleForm.name"}})],1),_c('el-form-item',{attrs:{"label":"手机号:","prop":"phone"}},[_c('el-input',{attrs:{"placeholder":"请输入手机号","maxlength":"11"},model:{value:(_vm.ruleForm.phone),callback:function ($$v) {_vm.$set(_vm.ruleForm, "phone", $$v)},expression:"ruleForm.phone"}})],1),_c('el-form-item',{attrs:{"label":"性别:","prop":"sex"}},[_c('el-radio-group',{model:{value:(_vm.ruleForm.sex),callback:function ($$v) {_vm.$set(_vm.ruleForm, "sex", $$v)},expression:"ruleForm.sex"}},[_c('el-radio',{attrs:{"label":"男"}}),_c('el-radio',{attrs:{"label":"女"}})],1)],1),_c('el-form-item',{staticClass:"idNumber",attrs:{"label":"身份证号:","prop":"idNumber"}},[_c('el-input',{attrs:{"placeholder":"请输入身份证号","maxlength":"20"},model:{value:(_vm.ruleForm.idNumber),callback:function ($$v) {_vm.$set(_vm.ruleForm, "idNumber", $$v)},expression:"ruleForm.idNumber"}})],1),_c('div',{staticClass:"subBox address"},[_c('el-button',{on:{"click":function () { return _vm.$router.push('/employee'); }}},[_vm._v("\n          取消\n        ")]),_c('el-button',{class:{ continue: _vm.actionType === 'add' },attrs:{"type":"primary"},on:{"click":function($event){return _vm.submitForm('ruleForm', false)}}},[_vm._v("\n          保存\n        ")]),(_vm.actionType == 'add')?_c('el-button',{attrs:{"type":"primary"},on:{"click":function($event){return _vm.submitForm('ruleForm', true)}}},[_vm._v("\n          保存并继续添加\n        ")]):_vm._e()],1)],1)],1)],1)}
const __staticRenderFns__ = []
































































































import { Component, Vue } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import { queryEmployeeById, addEmployee, editEmployee } from '@/api/employee'

@Component({ name: 'addShop',
  components: {
    HeadLable
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  private title = '添加员工'
  private actionType = ''
  private ruleForm = {
    name: '',
    phone: '',
    // 'password': '',
    // 'rePassword': '',
    sex: '男',
    idNumber: '',
    username: ''
  }

  // private validateRepassword (rule:any, value:any, callback:any) {
  //   if (value === '') {
  //     callback(new Error('请再次输入密码'))
  //   } else if (value !== this.ruleForm.password) {
  //     callback(new Error('两次输入密码不一致!'))
  //   } else {
  //     callback()
  //   }
  // }

  private isCellPhone(val: any) {
    if (!/^1(3|4|5|6|7|8)\d{9}$/.test(val)) {
      return false
    } else {
      return true
    }
  }

  private checkphone(rule: any, value: any, callback: any) {
    // let phoneReg = /(^1[3|4|5|6|7|8|9]\d{9}$)|(^09\d{8}$)/;
    if (value == '') {
      callback(new Error('请输入手机号'))
    } else if (!this.isCellPhone(value)) {
      //引入methods中封装的检查手机格式的方法
      callback(new Error('请输入正确的手机号!'))
    } else {
      callback()
    }
  }

  private validID(rule: any, value: any, callback: any) {
    // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
    let reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/
    if (value == '') {
      callback(new Error('请输入身份证号码'))
    } else if (reg.test(value)) {
      callback()
    } else {
      callback(new Error('身份证号码不正确'))
    }
  }

  get rules() {
    return {
      name: [
        {
          required: true,
          // 'message': '请输入员工姓名',
          validator: (rule: any, value: string, callback: Function) => {
            if (!value) {
              callback(new Error('请输入员工姓名'))
            } else {
              // const reg = /^[\u4e00-\u9fa5_a-zA-Z]{1,12}$/
              // if (!reg.test(value)) {
              //   callback(new Error('姓名输入不符，请输入1-12个字符'))
              // } else {
              //   callback()
              // }
              callback()
            }
          },
          trigger: 'blur'
        }
      ],
      username: [
        {
          required: true,
          // message: '请输入账号',
          validator: (rule: any, value: string, callback: Function) => {
            if (!value) {
              callback(new Error('请输入账号'))
            } else {
              const reg = /^([a-z]|[0-9]){3,20}$/
              if (!reg.test(value)) {
                callback(new Error('账号输入不符，请输入3-20个字符'))
              } else {
                callback()
              }
            }
          },
          trigger: 'blur'
        }
      ],
      phone: [{ required: true, validator: this.checkphone, trigger: 'blur' }],
      idNumber: [{ required: true, validator: this.validID, trigger: 'blur' }]
    }
  }

  created() {
    this.actionType = this.$route.query.id ? 'edit' : 'add'
    if (this.$route.query.id) {
      this.title = '修改员工信息'
      this.init()
    }
  }

  private async init() {
    const id = this.$route.query.id
    queryEmployeeById(id).then((res: any) => {
      // String(res.status) === '200'
      if (res.data.code === 1) {
        this.ruleForm = res.data.data
        this.ruleForm.sex = res.data.data.sex === '0' ? '女' : '男'
        // this.ruleForm.password = ''
      } else {
        this.$message.error(res.data.msg)
      }
      // if (res.data.code == 200) {
      //   const { data } = res.data
      //   this.ruleForm = data
      //   this.ruleForm.password = ''
      //   // this.ruleForm.rePassword = '' //JSON.parse(JSON.stringify(data.password));
      // } else {
      //   this.$message.error(res.data.desc)
      // }
    })
  }

  private submitForm(formName: any, st: any) {
    ;(this.$refs[formName] as any).validate((valid: any) => {
      if (valid) {
        if (this.actionType === 'add') {
          const params = {
            ...this.ruleForm,
            sex: this.ruleForm.sex === '女' ? '0' : '1'
          }
          addEmployee(params)
            .then((res: any) => {
              if (res.data.code === 1) {
                this.$message.success('员工添加成功！')
                if (!st) {
                  this.$router.push({ path: '/employee' })
                } else {
                  this.ruleForm = {
                    username: '',
                    name: '',
                    phone: '',
                    // 'password': '',
                    // 'rePassword': '',/
                    sex: '男',
                    idNumber: ''
                  }
                }
              } else {
                this.$message.error(res.data.msg)
              }
            })
            .catch(() => {
              // this.$message.error('请求出错了：' + err.message)
            })
        } else {
          const params = {
            ...this.ruleForm,
            sex: this.ruleForm.sex === '女' ? '0' : '1'
          }
          editEmployee(params)
            .then((res: any) => {
              if (res.data.code === 1) {
                this.$message.success('员工信息修改成功！')
                this.$router.push({ path: '/employee' })
              } else {
                this.$message.error(res.data.msg)
              }
            })
            .catch(() => {
              // this.$message.error('请求出错了：' + err.message)
            })
        }
      } else {
        return false
      }
    })
  }
}
</script>
