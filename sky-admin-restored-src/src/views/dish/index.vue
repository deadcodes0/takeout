<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"dashboard-container"},[_c('div',{staticClass:"container"},[_c('div',{staticClass:"tableBar"},[_c('label',{staticStyle:{"margin-right":"10px"}},[_vm._v("菜品名称：")]),_c('el-input',{staticStyle:{"width":"14%"},attrs:{"placeholder":"请填写菜品名称","clearable":""},on:{"clear":_vm.init},nativeOn:{"keyup":function($event){if(!$event.type.indexOf('key')&&_vm._k($event.keyCode,"enter",13,$event.key,"Enter")){ return null; }return _vm.initFun($event)}},model:{value:(_vm.input),callback:function ($$v) {_vm.input=$$v},expression:"input"}}),_c('label',{staticStyle:{"margin-right":"10px","margin-left":"20px"}},[_vm._v("菜品分类：")]),_c('el-select',{staticStyle:{"width":"14%"},attrs:{"placeholder":"请选择","clearable":""},on:{"clear":_vm.init},model:{value:(_vm.categoryId),callback:function ($$v) {_vm.categoryId=$$v},expression:"categoryId"}},_vm._l((_vm.dishCategoryList),function(item){return _c('el-option',{key:item.value,attrs:{"label":item.label,"value":item.value}})}),1),_c('label',{staticStyle:{"margin-right":"10px","margin-left":"20px"}},[_vm._v("售卖状态：")]),_c('el-select',{staticStyle:{"width":"14%"},attrs:{"placeholder":"请选择","clearable":""},on:{"clear":_vm.init},model:{value:(_vm.dishStatus),callback:function ($$v) {_vm.dishStatus=$$v},expression:"dishStatus"}},_vm._l((_vm.saleStatus),function(item){return _c('el-option',{key:item.value,attrs:{"label":item.label,"value":item.value}})}),1),_c('el-button',{staticClass:"normal-btn continue",on:{"click":function($event){return _vm.init(true)}}},[_vm._v("\n        查询\n      ")]),_c('div',{staticClass:"tableLab"},[_c('div',{staticClass:"batch-delete-btn",class:{ disabled: _vm.checkList.length === 0 },on:{"click":function($event){if(_vm.checkList.length > 0){return _vm.deleteHandle('批量', null)}}}},[_c('i',{staticClass:"el-icon-delete"}),_vm._v("批量删除"),_c('span',{staticClass:"count"},[_vm._v(_vm._s(_vm.checkList.length))])]),_c('el-button',{staticStyle:{"margin-left":"15px"},attrs:{"type":"primary"},on:{"click":function($event){return _vm.addDishtype('add')}}},[_vm._v("\n          + 新建菜品\n        ")])],1)],1),(_vm.tableData.length)?_c('el-table',{staticClass:"tableBox",attrs:{"data":_vm.tableData,"stripe":""},on:{"selection-change":_vm.handleSelectionChange}},[_c('el-table-column',{attrs:{"type":"selection","width":"25"}}),_c('el-table-column',{attrs:{"prop":"name","label":"菜品名称"}}),_c('el-table-column',{attrs:{"prop":"image","label":"图片"},scopedSlots:_vm._u([{key:"default",fn:function(ref){
var row = ref.row;
return [_c('el-image',{staticStyle:{"width":"80px","height":"40px","border":"none","cursor":"pointer"},attrs:{"src":row.image}},[_c('div',{staticClass:"image-slot",attrs:{"slot":"error"},slot:"error"},[_c('img',{staticStyle:{"width":"auto","height":"40px","border":"none"},attrs:{"src":require("./../../assets/noImg.png")}})])])]}}],null,false,3986313203)}),_c('el-table-column',{attrs:{"prop":"categoryName","label":"菜品分类"}}),_c('el-table-column',{attrs:{"label":"售价"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('span',{staticStyle:{"margin-right":"10px"}},[_vm._v("￥"+_vm._s((scope.row.price ).toFixed(2)*100/100))])]}}],null,false,2377909288)}),_c('el-table-column',{attrs:{"label":"售卖状态"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('div',{staticClass:"tableColumn-status",class:{ 'stop-use': String(scope.row.status) === '0' }},[_vm._v("\n            "+_vm._s(String(scope.row.status) === '0' ? '停售' : '启售')+"\n          ")])]}}],null,false,3246160962)}),_c('el-table-column',{attrs:{"prop":"updateTime","label":"最后操作时间"}}),_c('el-table-column',{attrs:{"label":"操作","width":"250","align":"center"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('el-button',{staticClass:"blueBug",attrs:{"type":"text","size":"small"},on:{"click":function($event){return _vm.addDishtype(scope.row.id)}}},[_vm._v("\n            修改\n          ")]),_c('el-button',{staticClass:"delBut",attrs:{"type":"text","size":"small"},on:{"click":function($event){return _vm.deleteHandle('单删', scope.row.id)}}},[_vm._v("\n            删除\n          ")]),_c('el-button',{staticClass:"non",class:{
                       blueBug: scope.row.status == '0',
                       delBut: scope.row.status != '0'
                     },attrs:{"type":"text","size":"small"},on:{"click":function($event){return _vm.statusHandle(scope.row)}}},[_vm._v("\n            "+_vm._s(scope.row.status == '0' ? '启售' : '停售')+"\n          ")])]}}],null,false,3893969185)})],1):_c('Empty',{attrs:{"is-search":_vm.isSearch}}),(_vm.counts > 10)?_c('el-pagination',{staticClass:"pageList",attrs:{"page-sizes":[10, 20, 30, 40],"page-size":_vm.pageSize,"layout":"total, sizes, prev, pager, next, jumper","total":_vm.counts},on:{"size-change":_vm.handleSizeChange,"current-change":_vm.handleCurrentChange}}):_vm._e()],1)])}
const __staticRenderFns__ = []













































































































































import { Component, Vue } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import {
  getDishPage,
  editDish,
  deleteDish,
  dishStatusByStatus,
  dishCategoryList
} from '@/api/dish'
import InputAutoComplete from '@/components/InputAutoComplete/index.vue'
import Empty from '@/components/Empty/index.vue'
import { baseUrl } from '@/config.json'

@Component({ name: 'DishType',
  components: {
    HeadLable,
    InputAutoComplete,
    Empty
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  private input: any = ''
  private counts: number = 0
  private page: number = 1
  private pageSize: number = 10
  private checkList: string[] = []
  private tableData: [] = []
  private dishState = ''
  private dishCategoryList = []
  private categoryId = ''
  private dishStatus = ''
  private isSearch: boolean = false
  private saleStatus: any = [
    {
      value: 0,
      label: '停售'
    },
    {
      value: 1,
      label: '启售'
    }
  ]

  created() {
    this.init()
    this.getDishCategoryList()
  }

  initProp(val) {
    this.input = val
    this.initFun()
  }

  initFun() {
    this.page = 1
    this.init()
  }

  private async init(isSearch?) {
    this.isSearch = isSearch
    await getDishPage({
      page: this.page,
      pageSize: this.pageSize,
      name: this.input || undefined,
      categoryId: this.categoryId || undefined,
      status: this.dishStatus
    })
      .then(res => {
        if (res.data.code === 1) {
          this.tableData = res.data && res.data.data && res.data.data.records
          this.counts = Number(res.data.data.total)
        }
      })
      .catch(err => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  // 添加
  private addDishtype(st: string) {
    if (st === 'add') {
      this.$router.push({ path: '/dish/add' })
    } else {
      this.$router.push({ path: '/dish/add', query: { id: st } })
    }
  }

  // 删除
  private deleteHandle(type: string, id: any) {
    if (type === '批量' && id === null) {
      if (this.checkList.length === 0) {
        return this.$message.error('请选择删除对象')
      }
    }
    this.$confirm('确认删除该菜品, 是否继续?', '确定删除', {
      confirmButtonText: '删除',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      deleteDish(type === '批量' ? this.checkList.join(',') : id)
        .then(res => {
          if (res && res.data && res.data.code === 1) {
            this.$message.success('删除成功！')
            this.init()
          } else {
            this.$message.error(res.data.msg)
          }
        })
        .catch(err => {
          this.$message.error('请求出错了：' + err.message)
        })
    })
  }
  //获取菜品分类下拉数据
  private getDishCategoryList() {
    dishCategoryList({
      type: 1
    })
      .then(res => {
        if (res && res.data && res.data.code === 1) {
          this.dishCategoryList = (
            res.data &&
            res.data.data &&
            res.data.data
          ).map(item => {
            return { value: item.id, label: item.name }
          })
        }
      })
      .catch(() => {})
  }

  //状态更改
  private statusHandle(row: any) {
    let params: any = {}
    if (typeof row === 'string') {
      if (this.checkList.length === 0) {
        this.$message.error('批量操作，请先勾选操作菜品！')
        return false
      }
      params.id = this.checkList.join(',')
      params.status = row
    } else {
      params.id = row.id
      params.status = row.status ? '0' : '1'
    }
    this.dishState = params
    this.$confirm('确认更改该菜品状态?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      // 起售停售---批量起售停售接口
      dishStatusByStatus(this.dishState)
        .then(res => {
          if (res && res.data && res.data.code === 1) {
            this.$message.success('菜品状态已经更改成功！')
            this.init()
          } else {
            this.$message.error(res.data.msg)
          }
        })
        .catch(err => {
          this.$message.error('请求出错了：' + err.message)
        })
    })
  }

  // 全部操作
  private handleSelectionChange(val: any) {
    let checkArr: any[] = []
    val.forEach((n: any) => {
      checkArr.push(n.id)
    })
    this.checkList = checkArr
  }

  private handleSizeChange(val: any) {
    this.pageSize = val
    this.init()
  }

  private handleCurrentChange(val: any) {
    this.page = val
    this.init()
  }
}
</script>
