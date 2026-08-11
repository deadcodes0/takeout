<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"addBrand-container"},[_c('div',{staticClass:"container"},[_c('el-form',{ref:"ruleForm",staticClass:"demo-ruleForm",attrs:{"model":_vm.ruleForm,"rules":_vm.rules,"inline":true,"label-width":"180px"}},[_c('div',[_c('el-form-item',{attrs:{"label":"套餐名称:","prop":"name"}},[_c('el-input',{attrs:{"placeholder":"请填写套餐名称","maxlength":"14"},model:{value:(_vm.ruleForm.name),callback:function ($$v) {_vm.$set(_vm.ruleForm, "name", $$v)},expression:"ruleForm.name"}})],1),_c('el-form-item',{attrs:{"label":"套餐分类:","prop":"idType"}},[_c('el-select',{attrs:{"placeholder":"请选择套餐分类"},on:{"change":function($event){return _vm.$forceUpdate()}},model:{value:(_vm.ruleForm.idType),callback:function ($$v) {_vm.$set(_vm.ruleForm, "idType", $$v)},expression:"ruleForm.idType"}},_vm._l((_vm.setMealList),function(item,index){return _c('el-option',{key:index,attrs:{"label":item.name,"value":item.id}})}),1)],1)],1),_c('div',[_c('el-form-item',{attrs:{"label":"套餐价格:","prop":"price"}},[_c('el-input',{attrs:{"placeholder":"请设置套餐价格"},model:{value:(_vm.ruleForm.price),callback:function ($$v) {_vm.$set(_vm.ruleForm, "price", $$v)},expression:"ruleForm.price"}})],1)],1),_c('div',[_c('el-form-item',{attrs:{"label":"套餐菜品:","required":""}},[_c('el-form-item',[_c('div',{staticClass:"addDish"},[(_vm.dishTable.length == 0)?_c('span',{staticClass:"addBut",on:{"click":function($event){return _vm.openAddDish('new')}}},[_vm._v("\n                + 添加菜品")]):_vm._e(),(_vm.dishTable.length != 0)?_c('div',{staticClass:"content"},[_c('div',{staticClass:"addBut",staticStyle:{"margin-bottom":"20px"},on:{"click":function($event){return _vm.openAddDish('change')}}},[_vm._v("\n                  + 添加菜品\n                ")]),_c('div',{staticClass:"table"},[_c('el-table',{staticStyle:{"width":"100%"},attrs:{"data":_vm.dishTable}},[_c('el-table-column',{attrs:{"prop":"name","label":"名称","width":"180","align":"center"}}),_c('el-table-column',{attrs:{"prop":"price","label":"原价","width":"180","align":"center"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_vm._v("\n                        "+_vm._s((Number(scope.row.price).toFixed(2) * 100) / 100)+"\n                      ")]}}],null,false,1338860262)}),_c('el-table-column',{attrs:{"prop":"address","label":"份数","align":"center"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('el-input-number',{attrs:{"size":"small","min":1,"max":99,"label":"描述文字"},model:{value:(scope.row.copies),callback:function ($$v) {_vm.$set(scope.row, "copies", $$v)},expression:"scope.row.copies"}})]}}],null,false,1483850948)}),_c('el-table-column',{attrs:{"prop":"address","label":"操作","width":"180px;","align":"center"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('el-button',{staticClass:"delBut non",attrs:{"type":"text","size":"small"},on:{"click":function($event){return _vm.delDishHandle(scope.$index)}}},[_vm._v("\n                          删除\n                        ")])]}}],null,false,1018689913)})],1)],1)]):_vm._e()])])],1)],1),_c('div',[_c('el-form-item',{attrs:{"label":"套餐图片:","required":"","prop":"image"}},[_c('image-upload',{attrs:{"prop-image-url":_vm.imageUrl},on:{"imageChange":_vm.imageChange}},[_vm._v("\n            图片大小不超过2M"),_c('br'),_vm._v("仅能上传 PNG JPEG JPG类型图片"),_c('br'),_vm._v("建议上传200*200或300*300尺寸的图片\n          ")])],1)],1),_c('div',{staticClass:"address"},[_c('el-form-item',{attrs:{"label":"套餐描述:"}},[_c('el-input',{attrs:{"type":"textarea","rows":3,"maxlength":"200","placeholder":"套餐描述，最长200字"},model:{value:(_vm.ruleForm.description),callback:function ($$v) {_vm.$set(_vm.ruleForm, "description", $$v)},expression:"ruleForm.description"}})],1)],1),_c('div',{staticClass:"subBox address"},[_c('el-form-item',[_c('el-button',{on:{"click":function () { return _vm.$router.back(); }}},[_vm._v("\n            取消\n          ")]),_c('el-button',{class:{ continue: _vm.actionType === 'add' },attrs:{"type":"primary"},on:{"click":function($event){return _vm.submitForm('ruleForm', false)}}},[_vm._v("\n            保存\n          ")]),(_vm.actionType == 'add')?_c('el-button',{attrs:{"type":"primary"},on:{"click":function($event){return _vm.submitForm('ruleForm', true)}}},[_vm._v("\n            保存并继续添加\n          ")]):_vm._e()],1)],1)])],1),(_vm.dialogVisible)?_c('el-dialog',{staticClass:"addDishList",attrs:{"title":"添加菜品","visible":_vm.dialogVisible,"width":"60%","before-close":_vm.handleClose},on:{"update:visible":function($event){_vm.dialogVisible=$event}}},[(_vm.dialogVisible)?_c('AddDish',{ref:"adddish",attrs:{"check-list":_vm.checkList},on:{"checkList":_vm.getCheckList}}):_vm._e(),_c('span',{staticClass:"dialog-footer",attrs:{"slot":"footer"},slot:"footer"},[_c('el-button',{on:{"click":_vm.handleClose}},[_vm._v("取 消")]),_c('el-button',{attrs:{"type":"primary"},on:{"click":_vm.addTableList}},[_vm._v("添 加")])],1)],1):_vm._e()],1)}
const __staticRenderFns__ = []



















































































































































































import { Component, Vue } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import ImageUpload from '@/components/ImgUpload/index.vue'
import AddDish from './components/AddDish.vue'
import { querySetmealById, addSetmeal, editSetmeal } from '@/api/setMeal'
import { getCategoryList } from '@/api/dish'
import { baseUrl } from '@/config.json'

@Component({ name: 'addShop',
  components: {
    HeadLable,
    AddDish,
    ImageUpload
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  private setMealList: [] = []
  private dishList: [] = []
  private imageUrl: string = ''
  private actionType: string = ''
  private dishTable: [] = []
  private dialogVisible: boolean = false
  private checkList: any[] = []
  private ruleForm = {
    name: '',
    categoryId: '',
    price: '',
    code: '',
    image: '',
    description: '',
    dishList: [],
    status: true,
    idType: ''
  }

  get rules() {
    return {
      name: {
        required: true,
        validator: (rule: any, value: string, callback: Function) => {
          if (!value) {
            callback(new Error('请输入套餐名称'))
          } else {
            const reg = /^([A-Za-z0-9\u4e00-\u9fa5]){2,20}$/
            if (!reg.test(value)) {
              callback(new Error('套餐名称输入不符，请输入2-20个字符'))
            } else {
              callback()
            }
          }
        },
        trigger: 'blur'
      },
      idType: {
        required: true,
        message: '请选择套餐分类',
        trigger: 'change'
      },
      image: {
        required: true,
        message: '菜品图片不能为空'
      },
      price: {
        required: true,
        // 'message': '请输入套餐价格',
        validator: (rules: any, value: string, callback: Function) => {
          const reg = /^([1-9]\d{0,5}|0)(\.\d{1,2})?$/
          if (!reg.test(value) || Number(value) <= 0) {
            callback(
              new Error(
                '套餐价格格式有误，请输入大于零且最多保留两位小数的金额'
              )
            )
          } else {
            callback()
          }
        },
        trigger: 'blur'
      },
      code: { required: true, message: '请输入商品码', trigger: 'blur' }
    }
  }

  created() {
    this.getDishTypeList()
    this.actionType = this.$route.query.id ? 'edit' : 'add'
    if (this.actionType == 'edit') {
      this.init()
    }
  }

  private async init() {
    querySetmealById(this.$route.query.id).then(res => {
      if (res && res.data && res.data.code === 1) {
        this.ruleForm = res.data.data
        this.ruleForm.status = res.data.data.status == '1'
        ;(this.ruleForm as any).price = res.data.data.price
        // this.imageUrl = `http://172.17.2.120:8080/common/download?name=${res.data.data.image}`
        this.imageUrl = res.data.data.image
        this.checkList = res.data.data.setmealDishes
        this.dishTable = res.data.data.setmealDishes.reverse()
        this.ruleForm.idType = res.data.data.categoryId
      } else {
        this.$message.error(res.data.msg)
      }
    })
  }
  // 获取套餐分类
  private getDishTypeList() {
    getCategoryList({ type: 2, page: 1, pageSize: 1000 }).then(res => {
      if (res && res.data && res.data.code === 1) {
        this.setMealList = res.data.data.map((obj: any) => ({
          ...obj,
          idType: obj.id
        }))
      } else {
        this.$message.error(res.data.msg)
      }
    })
  }

  // 通过套餐ID获取菜品列表分类
  // private getDishList (id:number) {
  //   getDishListType({id}).then(res => {
  //     if (res.data.code == 200) {
  //       const { data } = res.data
  //       this.dishList = data
  //     } else {
  //       this.$message.error(res.data.desc)
  //     }
  //   })
  // }

  // 删除套餐菜品
  delDishHandle(index: any) {
    this.dishTable.splice(index, 1)
    this.checkList = this.dishTable
    // this.checkList.splice(index, 1)
  }

  // 获取添加菜品数据 - 确定加菜倒序展示
  private getCheckList(value: any) {
    this.checkList = [...value].reverse()
  }

  // 添加菜品
  openAddDish(st: string) {
    this.dialogVisible = true
  }
  // 取消添加菜品
  handleClose(done: any) {
    // this.$refs.adddish.close()
    this.dialogVisible = false
    this.checkList = JSON.parse(JSON.stringify(this.dishTable))
    // this.dialogVisible = false
  }

  // 保存添加菜品列表
  public addTableList() {
    this.dishTable = JSON.parse(JSON.stringify(this.checkList))
    this.dishTable.forEach((n: any) => {
      n.copies = 1
    })
    this.dialogVisible = false
  }

  public submitForm(formName: any, st: any) {
    ;(this.$refs[formName] as any).validate((valid: any) => {
      if (valid) {
        if (this.dishTable.length === 0) {
          return this.$message.error('套餐下菜品不能为空')
        }
        if (!this.ruleForm.image) return this.$message.error('套餐图片不能为空')
        let prams = { ...this.ruleForm } as any
        prams.setmealDishes = this.dishTable.map((obj: any) => ({
          copies: obj.copies,
          dishId: obj.dishId,
          name: obj.name,
          price: obj.price
        }))
        ;(prams as any).status =
          this.actionType === 'add' ? 0 : this.ruleForm.status ? 1 : 0
        prams.categoryId = this.ruleForm.idType
        // delete prams.dishList
        if (this.actionType == 'add') {
          delete prams.id
          addSetmeal(prams)
            .then(res => {
              if (res && res.data && res.data.code === 1) {
                this.$message.success('套餐添加成功！')
                if (!st) {
                  this.$router.push({ path: '/setmeal' })
                } else {
                  ;(this as any).$refs.ruleForm.resetFields()
                  this.dishList = []
                  this.dishTable = []
                  this.ruleForm = {
                    name: '',
                    categoryId: '',
                    price: '',
                    code: '',
                    image: '',
                    description: '',
                    dishList: [],
                    status: true,
                    id: '',
                    idType: ''
                  } as any
                  this.imageUrl = ''
                }
              } else {
                this.$message.error(res.data.msg)
              }
            })
            .catch(err => {
              this.$message.error('请求出错了：' + err.message)
            })
        } else {
          delete prams.updateTime
          editSetmeal(prams)
            .then(res => {
              if (res.data.code === 1) {
                this.$message.success('套餐修改成功！')
                this.$router.push({ path: '/setmeal' })
              } else {
                // this.$message.error(res.data.desc || res.data.message)
              }
            })
            .catch(err => {
              this.$message.error('请求出错了：' + err.message)
            })
        }
      } else {
        // console.log('error submit!!')
        return false
      }
    })
  }

  imageChange(value: any) {
    this.ruleForm.image = value
  }
}
</script>
