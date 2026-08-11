<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"addDish"},[_c('div',{staticClass:"leftCont"},[_c('div',{staticClass:"tabBut"},_vm._l((_vm.dishType),function(item,index){return _c('span',{key:index,class:{ act: index == _vm.keyInd },on:{"click":function($event){return _vm.checkTypeHandle(index, item.id)}}},[_vm._v(_vm._s(item.name))])}),0),_c('div',{staticClass:"tabList"},[_c('div',{staticClass:"table",class:{ borderNone: !_vm.dishList.length }},[(_vm.dishList.length == 0)?_c('div',{staticStyle:{"padding-left":"10px"}},[_c('Empty')],1):_vm._e(),(_vm.dishList.length > 0)?_c('el-checkbox-group',{on:{"change":_vm.checkedListHandle},model:{value:(_vm.checkedList),callback:function ($$v) {_vm.checkedList=$$v},expression:"checkedList"}},_vm._l((_vm.dishList),function(item,index){return _c('div',{key:item.name + item.id,staticClass:"items"},[_c('el-checkbox',{key:index,attrs:{"label":item.name}},[_c('div',{staticClass:"item"},[_c('span',{staticStyle:{"flex":"3","text-align":"left"}},[_vm._v(_vm._s(item.dishName))]),_c('span',[_vm._v(_vm._s(item.status == 0 ? '停售' : '在售'))]),_c('span',[_vm._v(_vm._s((Number(item.price) ).toFixed(2)*100/100))])])])],1)}),0):_vm._e()],1)])]),_c('div',{staticClass:"ritCont"},[_c('div',{staticClass:"tit"},[_vm._v("\n      已选菜品("+_vm._s(_vm.checkedListAll.length)+")\n    ")]),_c('div',{staticClass:"items"},_vm._l((_vm.checkedListAll),function(item,ind){return _c('div',{key:ind,staticClass:"item"},[_c('span',[_vm._v(_vm._s(item.dishName || item.name))]),_c('span',{staticClass:"price"},[_vm._v("￥ "+_vm._s((Number(item.price) ).toFixed(2)*100/100)+" ")]),_c('span',{staticClass:"del",on:{"click":function($event){return _vm.delCheck(item.name)}}},[_c('img',{attrs:{"src":require("./../../../assets/icons/btn_clean@2x.png"),"alt":""}})])])}),0)])])}
const __staticRenderFns__ = []





























































import { Component, Prop, Vue } from 'vue-property-decorator'
// import {getDishTypeList, getDishListType} from '@/api/dish';
import { getCategoryList, queryDishList } from '@/api/dish'
import Empty from '@/components/Empty/index.vue'

@Component({ name: 'selectInput',
  components: {
    Empty
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop({ default: '' }) private value!: number
  @Prop({ default: [] }) private checkList!: any[]
  private dishType: [] = []
  private dishList: [] = []
  private allDishList: any[] = []
  private dishListCache: any[] = []
  private keyInd = 0
  private searchValue: string = ''
  public checkedList: any[] = []
  private checkedListAll: any[] = []
  private ids: any = new Set()
  created() {
    this.init()
  }

  public init() {
    // 菜单列表数据获取
    this.getDishType()
    // 初始化选项
    this.checkedList = this.checkList.map((it: any) => it.name)
    // 已选项的菜品-详细信息
    this.checkedListAll = this.checkList.reverse()
  }
  // 获取套餐分类
  public getDishType() {
    getCategoryList({ type: 1 }).then(res => {
      if (res && res.data && res.data.code === 1) {
        this.dishType = res.data.data
        this.getDishList(res.data.data[0].id)
      } else {
        this.$message.error(res.data.msg)
      }
      // if (res.data.code == 200) {
      //   const { data } = res.data
      //   this.   = data
      //   this.getDishList(data[0].category_id)
      // } else {
      //   this.$message.error(res.data.desc)
      // }
    })
  }

  // 通过套餐ID获取菜品列表分类
  private getDishList(id: number) {
    queryDishList({ categoryId: id }).then(res => {
      if (res && res.data && res.data.code === 1) {
        if (res.data.data.length == 0) {
          this.dishList = []
          return
        }
        let newArr = res.data.data
        newArr.forEach((n: any) => {
          n.dishId = n.id
          n.copies = 1
          // n.dishCopies = 1
          n.dishName = n.name
        })
        this.dishList = newArr
        if (!this.ids.has(id)) {
          this.allDishList = [...this.allDishList, ...newArr]
        }
        this.ids.add(id)
      } else {
        this.$message.error(res.data.msg)
      }
    })
  }
  // 点击分类
  private checkTypeHandle(ind: number, id: any) {
    this.keyInd = ind
    this.getDishList(id)
  }
  // 添加菜品
  private checkedListHandle(value: [string]) {
    // TODO 实现倒序 由于value是组件内封装无法从前面添加 所有取巧处理倒序添加
    // 倒序展示 - 数据处理前反正 为正序
    this.checkedListAll.reverse()
    // value 是一个只包含菜品名的数组 需要从 dishList中筛选出 对应的详情
    // 操作添加菜品
    const list = this.allDishList.filter((item: any) => {
      let data
      value.forEach((it: any) => {
        if (item.name == it) {
          data = item
        }
      })
      return data
    })
    // 编辑的时候需要与已有菜品合并
    // 与当前请求下的选择性 然后去重就是当前的列表
    const dishListCat = [...this.checkedListAll, ...list]
    let arrData: any[] = []
    this.checkedListAll = dishListCat.filter((item: any) => {
      let allArrDate
      if (arrData.length == 0) {
        arrData.push(item.name)
        allArrDate = item
      } else {
        const st = arrData.some(it => item.name == it)
        if (!st) {
          arrData.push(item.name)
          allArrDate = item
        }
      }
      return allArrDate
    })
    // 如果是减菜 走这里
    if (value.length < arrData.length) {
      this.checkedListAll = this.checkedListAll.filter((item: any) => {
        if (value.some(it => it == item.name)) {
          return item
        }
      })
    }
    this.$emit('checkList', this.checkedListAll)
    // 数据处理完反转为倒序
    this.checkedListAll.reverse()
  }

  open(done: any) {
    this.dishListCache = JSON.parse(JSON.stringify(this.checkList))
  }

  close(done: any) {
    this.checkList = this.dishListCache
  }

  // 删除
  private delCheck(name: any) {
    const index = this.checkedList.findIndex(it => it === name)
    const indexAll = this.checkedListAll.findIndex(
      (it: any) => it.name === name
    )

    this.checkedList.splice(index, 1)
    this.checkedListAll.splice(indexAll, 1)
    this.$emit('checkList', this.checkedListAll)
  }
}
</script>
