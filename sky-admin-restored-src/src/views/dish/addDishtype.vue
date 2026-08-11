<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{key:_vm.vueRest,staticClass:"addBrand-container"},[_c('div',{key:_vm.restKey,staticClass:"container"},[_c('el-form',{ref:"ruleForm",staticClass:"demo-ruleForm",attrs:{"model":_vm.ruleForm,"rules":_vm.rules,"inline":true,"label-width":"180px"}},[_c('div',[_c('el-form-item',{attrs:{"label":"菜品名称:","prop":"name"}},[_c('el-input',{attrs:{"placeholder":"请填写菜品名称","maxlength":"20"},model:{value:(_vm.ruleForm.name),callback:function ($$v) {_vm.$set(_vm.ruleForm, "name", $$v)},expression:"ruleForm.name"}})],1),_c('el-form-item',{attrs:{"label":"菜品分类:","prop":"categoryId"}},[_c('el-select',{attrs:{"placeholder":"请选择菜品分类"},model:{value:(_vm.ruleForm.categoryId),callback:function ($$v) {_vm.$set(_vm.ruleForm, "categoryId", $$v)},expression:"ruleForm.categoryId"}},_vm._l((_vm.dishList),function(item,index){return _c('el-option',{key:index,attrs:{"label":item.name,"value":item.id}})}),1)],1)],1),_c('div',[_c('el-form-item',{attrs:{"label":"菜品价格:","prop":"price"}},[_c('el-input',{attrs:{"placeholder":"请设置菜品价格"},model:{value:(_vm.ruleForm.price),callback:function ($$v) {_vm.$set(_vm.ruleForm, "price", $$v)},expression:"ruleForm.price"}})],1)],1),_c('el-form-item',{attrs:{"label":"口味做法配置:"}},[_c('el-form-item',[_c('div',{staticClass:"flavorBox"},[(_vm.dishFlavors.length == 0)?_c('span',{staticClass:"addBut",on:{"click":_vm.addFlavore}},[_vm._v("\n              + 添加口味")]):_vm._e(),(_vm.dishFlavors.length != 0)?_c('div',{staticClass:"flavor"},[_c('div',{staticClass:"title"},[_c('span',[_vm._v("口味名（3个字内）")])]),_c('div',{staticClass:"cont"},_vm._l((_vm.dishFlavors),function(item,index){return _c('div',{key:index,staticClass:"items"},[_c('div',{staticClass:"itTit"},[_c('SelectInput',{attrs:{"dish-flavors-data":_vm.leftDishFlavors,"index":index,"value":item.name},on:{"select":_vm.selectHandle}})],1),_c('div',{staticClass:"labItems",staticStyle:{"display":"flex"}},[_vm._l((item.value),function(it,ind){return _c('span',{key:ind},[_vm._v(_vm._s(it)+"\n                      "),_c('i',{on:{"click":function($event){return _vm.delFlavorLabel(index, ind)}}},[_vm._v("X")])])}),_c('div',{staticClass:"inputBox",style:(_vm.inputStyle)})],2),_c('span',{staticClass:"delFlavor delBut non",on:{"click":function($event){return _vm.delFlavor(item.name)}}},[_vm._v("删除")])])}),0),(
                     !!this.leftDishFlavors.length &&
                       this.dishFlavors.length < this.dishFlavorsData.length
                   )?_c('div',{staticClass:"addBut",on:{"click":_vm.addFlavore}},[_vm._v("\n                添加口味\n              ")]):_vm._e()]):_vm._e()])])],1),_c('div',[_c('el-form-item',{attrs:{"label":"菜品图片:","prop":"image"}},[_c('image-upload',{attrs:{"prop-image-url":_vm.imageUrl},on:{"imageChange":_vm.imageChange}},[_vm._v("\n            图片大小不超过2M"),_c('br'),_vm._v("仅能上传 PNG JPEG JPG类型图片"),_c('br'),_vm._v("建议上传200*200或300*300尺寸的图片\n          ")])],1)],1),_c('div',{staticClass:"address"},[_c('el-form-item',{attrs:{"label":"菜品描述:","prop":"region"}},[_c('el-input',{attrs:{"type":"textarea","rows":3,"maxlength":"200","placeholder":"菜品描述，最长200字"},model:{value:(_vm.ruleForm.description),callback:function ($$v) {_vm.$set(_vm.ruleForm, "description", $$v)},expression:"ruleForm.description"}})],1)],1),_c('div',{staticClass:"subBox address"},[_c('el-button',{on:{"click":function () { return _vm.$router.back(); }}},[_vm._v("\n          取消\n        ")]),_c('el-button',{class:{ continue: _vm.actionType === 'add' },attrs:{"type":"primary"},on:{"click":function($event){return _vm.submitForm('ruleForm')}}},[_vm._v("\n          保存\n        ")]),(_vm.actionType == 'add')?_c('el-button',{attrs:{"type":"primary"},on:{"click":function($event){return _vm.submitForm('ruleForm', 'goAnd')}}},[_vm._v("\n          保存并继续添加\n        ")]):_vm._e()],1)],1)],1)])}
const __staticRenderFns__ = []





























































































































import { Component, Vue, Watch } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import SelectInput from './components/SelectInput.vue'
import ImageUpload from '@/components/ImgUpload/index.vue'
// getFlavorList口味列表暂时不做 getDishTypeList
import {
  queryDishById,
  addDish,
  editDish,
  getCategoryList,
  commonDownload
} from '@/api/dish'
import { baseUrl } from '@/config.json'
import { getToken } from '@/utils/cookies'
@Component({ name: 'addShop',
  components: {
    HeadLable,
    SelectInput,
    ImageUpload
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  private restKey: number = 0
  private textarea: string = ''
  private value: string = ''
  private imageUrl: string = ''
  private actionType: string = ''
  private dishList: string[] = []
  private dishFlavorsData: any[] = [] //原始口味数据
  private dishFlavors: any[] = [] //待上传口味的数据
  private leftDishFlavors: any[] = [] //下拉框剩余可选择的口味数据
  private vueRest = '1'
  private index = 0
  private inputStyle = { flex: 1 }
  private headers = {
    token: getToken()
  }
  private ruleForm = {
    name: '',
    id: '',
    price: '',
    code: '',
    image: '',
    description: '',
    dishFlavors: [],
    status: true,
    categoryId: ''
  }

  get rules() {
    return {
      name: [
        {
          required: true,
          validator: (rule: any, value: string, callback: Function) => {
            if (!value) {
              callback(new Error('请输入菜品名称'))
            } else {
              const reg = /^([A-Za-z0-9\u4e00-\u9fa5]){2,20}$/
              if (!reg.test(value)) {
                callback(new Error('菜品名称输入不符，请输入2-20个字符'))
              } else {
                callback()
              }
            }
          },
          trigger: 'blur'
        }
      ],
      categoryId: [
        { required: true, message: '请选择菜品分类', trigger: 'change' }
      ],
      image: {
        required: true,
        message: '菜品图片不能为空'
      },
      price: [
        {
          required: true,
          // 'message': '请填写菜品价格',
          validator: (rules: any, value: string, callback: Function) => {
            const reg = /^([1-9]\d{0,5}|0)(\.\d{1,2})?$/
            if (!reg.test(value) || Number(value) <= 0) {
              callback(
                new Error(
                  '菜品价格格式有误，请输入大于零且最多保留两位小数的金额'
                )
              )
            } else {
              callback()
            }
          },
          trigger: 'blur'
        }
      ],
      code: [{ required: true, message: '请填写商品码', trigger: 'blur' }]
    }
  }

  created() {
    this.getDishList()
    // 口味临时数据
    this.getFlavorListHand()
    this.actionType = this.$route.query.id ? 'edit' : 'add'
    if (this.$route.query.id) {
      this.init()
    }
  }

  mounted() {}
  @Watch('dishFlavors')
  changeDishFlavors() {
    this.getLeftDishFlavors()
  }

  //过滤已选择的口味下拉框无法再次选择
  getLeftDishFlavors() {
    let arr = []
    this.dishFlavorsData.map(item => {
      if (
        this.dishFlavors.findIndex(item1 => item.name === item1.name) === -1
      ) {
        arr.push(item)
      }
    })
    this.leftDishFlavors = arr
  }

  private selectHandle(val: any, key: any, ind: any) {
    const arrDate = [...this.dishFlavors]
    const index = this.dishFlavorsData.findIndex(item => item.name === val)
    arrDate[key] = JSON.parse(JSON.stringify(this.dishFlavorsData[index]))
    this.dishFlavors = arrDate
  }

  private async init() {
    queryDishById(this.$route.query.id).then(res => {
      if (res && res.data && res.data.code === 1) {
        this.ruleForm = { ...res.data.data }
        this.ruleForm.price = String(res.data.data.price)
        this.ruleForm.status = res.data.data.status == '1'
        this.dishFlavors =
          res.data.data.flavors &&
          res.data.data.flavors.map(obj => ({
            ...obj,
            value: JSON.parse(obj.value)
          }))
        let arr = []
        this.getLeftDishFlavors()
        this.imageUrl = res.data.data.image
      } else {
        this.$message.error(res.data.msg)
      }
    })
  }

  // 按钮 - 添加口味
  private addFlavore() {
    this.dishFlavors.push({ name: '', value: [] }) // JSON.parse(JSON.stringify(this.dishFlavorsData))
  }

  // 按钮 - 删除口味
  private delFlavor(name: string) {
    let ind = this.dishFlavors.findIndex(item => item.name === name)
    this.dishFlavors.splice(ind, 1)
  }

  // 按钮 - 删除口味标签
  private delFlavorLabel(index: number, ind: number) {
    this.dishFlavors[index].value.splice(ind, 1)
  }

  //口味位置记录
  private flavorPosition(index: number) {
    this.index = index
  }

  // 添加口味标签
  private keyDownHandle(val: any) {
    if (event) {
      event.cancelBubble = true
      event.preventDefault()
      event.stopPropagation()
    }

    if (val.target.innerText.trim() != '') {
      this.dishFlavors[this.index].flavorData.push(val.target.innerText)
      val.target.innerText = ''
    }
  }

  // 获取菜品分类
  private getDishList() {
    getCategoryList({ type: 1 }).then(res => {
      if (res.data.code === 1) {
        this.dishList = res && res.data && res.data.data
      } else {
        this.$message.error(res.data.msg)
      }
      // if (res.data.code == 200) {
      //   const {data} = res.data
      //   this.dishList = data
      // } else {
      //   this.$message.error(res.data.desc)
      // }
    })
  }

  // 获取口味列表
  private getFlavorListHand() {
    // flavor flavorData
    this.dishFlavorsData = [
      { name: '甜味', value: ['无糖', '少糖', '半糖', '多糖', '全糖'] },
      { name: '温度', value: ['热饮', '常温', '去冰', '少冰', '多冰'] },
      { name: '忌口', value: ['不要葱', '不要蒜', '不要香菜', '不要辣'] },
      { name: '辣度', value: ['不辣', '微辣', '中辣', '重辣'] }
    ]
  }

  private submitForm(formName: any, st: any) {
    ;(this.$refs[formName] as any).validate((valid: any) => {
      console.log(valid, 'valid')
      if (valid) {
        if (!this.ruleForm.image) return this.$message.error('菜品图片不能为空')
        let params: any = { ...this.ruleForm }
        // params.flavors = this.dishFlavors
        params.status =
          this.actionType === 'add' ? 0 : this.ruleForm.status ? 1 : 0
        // params.price *= 100
        params.categoryId = this.ruleForm.categoryId
        params.flavors = this.dishFlavors.map(obj => ({
          ...obj,
          value: JSON.stringify(obj.value)
        }))
        delete params.dishFlavors
        if (this.actionType == 'add') {
          delete params.id
          addDish(params)
            .then(res => {
              if (res.data.code === 1) {
                this.$message.success('菜品添加成功！')
                if (!st) {
                  this.$router.push({ path: '/dish' })
                } else {
                  this.dishFlavors = []
                  // this.dishFlavorsData = []
                  this.imageUrl = ''
                  this.ruleForm = {
                    name: '',
                    id: '',
                    price: '',
                    code: '',
                    image: '',
                    description: '',
                    dishFlavors: [],
                    status: true,
                    categoryId: ''
                  }
                  this.restKey++
                }
              } else {
                this.$message.error(res.data.desc || res.data.msg)
              }
            })
            .catch(err => {
              this.$message.error('请求出错了：' + err.message)
            })
        } else {
          delete params.createTime
          delete params.updateTime
          editDish(params)
            .then(res => {
              if (res && res.data && res.data.code === 1) {
                this.$router.push({ path: '/dish' })
                this.$message.success('菜品修改成功！')
              } else {
                this.$message.error(res.data.desc || res.data.msg)
              }
              // if (res.data.code == 200) {
              //   this.$router.push({'path': '/dish'})
              //   this.$message.success('菜品修改成功！')
              // } else {
              //   this.$message.error(res.data.desc || res.data.message)
              // }
            })
            .catch(err => {
              this.$message.error('请求出错了：' + err.message)
            })
        }
      } else {
        return false
      }
    })
  }

  imageChange(value: any) {
    this.ruleForm.image = value
  }
}
</script>
