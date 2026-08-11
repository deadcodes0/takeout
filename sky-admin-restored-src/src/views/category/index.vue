<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"dashboard-container"},[_c('div',{staticClass:"container"},[_c('div',{staticClass:"tableBar",staticStyle:{"display":"inline-block","width":"100%"}},[_c('label',{staticStyle:{"margin-right":"10px"}},[_vm._v("分类名称：")]),_c('el-input',{staticStyle:{"width":"15%"},attrs:{"placeholder":"请填写分类名称","clearable":""},on:{"clear":_vm.init},nativeOn:{"keyup":function($event){if(!$event.type.indexOf('key')&&_vm._k($event.keyCode,"enter",13,$event.key,"Enter")){ return null; }return _vm.init($event)}},model:{value:(_vm.name),callback:function ($$v) {_vm.name=$$v},expression:"name"}}),_c('label',{staticStyle:{"margin-right":"5px","margin-left":"20px"}},[_vm._v("分类类型：")]),_c('el-select',{staticStyle:{"width":"15%"},attrs:{"placeholder":"请选择","clearable":""},on:{"clear":_vm.init},model:{value:(_vm.categoryType),callback:function ($$v) {_vm.categoryType=$$v},expression:"categoryType"}},_vm._l((_vm.options),function(item){return _c('el-option',{key:item.value,attrs:{"label":item.label,"value":item.value}})}),1),_c('div',{staticStyle:{"float":"right"}},[_c('el-button',{staticClass:"continue",attrs:{"type":"primary"},on:{"click":function($event){return _vm.addClass('class')}}},[_vm._v("\n          + 新增菜品分类\n        ")]),_c('el-button',{staticStyle:{"margin-left":"20px"},attrs:{"type":"primary"},on:{"click":function($event){return _vm.addClass('meal')}}},[_vm._v("\n          + 新增套餐分类\n        ")])],1),_c('el-button',{staticClass:"normal-btn continue",on:{"click":function($event){return _vm.init(true)}}},[_vm._v("\n        查询\n      ")])],1),(_vm.tableData.length)?_c('el-table',{staticClass:"tableBox",attrs:{"data":_vm.tableData,"stripe":""}},[_c('el-table-column',{attrs:{"prop":"name","label":"分类名称"}}),_c('el-table-column',{attrs:{"prop":"type","label":"分类类型"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('span',[_vm._v(_vm._s(scope.row.type == '1' ? '菜品分类' : '套餐分类'))])]}}],null,false,2535166896)}),_c('el-table-column',{attrs:{"prop":"sort","label":"排序"}}),_c('el-table-column',{attrs:{"label":"状态"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('div',{staticClass:"tableColumn-status",class:{ 'stop-use': String(scope.row.status) === '0' }},[_vm._v("\n            "+_vm._s(String(scope.row.status) === '0' ? '禁用' : '启用')+"\n          ")])]}}],null,false,1902337151)}),_c('el-table-column',{attrs:{"prop":"updateTime","label":"操作时间"}}),_c('el-table-column',{attrs:{"label":"操作","width":"200","align":"center"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('el-button',{staticClass:"blueBug",attrs:{"type":"text","size":"small"},on:{"click":function($event){return _vm.editHandle(scope.row)}}},[_vm._v("\n            修改\n          ")]),_c('el-button',{staticClass:"delBut",attrs:{"type":"text","size":"small"},on:{"click":function($event){return _vm.deleteHandle(scope.row.id)}}},[_vm._v("\n            删除\n          ")]),_c('el-button',{staticClass:"non",class:{
                       blueBug: scope.row.status == '0',
                       delBut: scope.row.status != '0'
                     },attrs:{"type":"text","size":"small"},on:{"click":function($event){return _vm.statusHandle(scope.row)}}},[_vm._v("\n            "+_vm._s(scope.row.status == '1' ? '禁用' : '启用')+"\n          ")])]}}],null,false,975198590)})],1):_c('Empty',{attrs:{"is-search":_vm.isSearch}}),(_vm.counts > 10)?_c('el-pagination',{staticClass:"pageList",attrs:{"page-sizes":[10, 20, 30, 40],"page-size":_vm.pageSize,"layout":"total, sizes, prev, pager, next, jumper","total":_vm.counts},on:{"size-change":_vm.handleSizeChange,"current-change":_vm.handleCurrentChange}}):_vm._e()],1),_c('el-dialog',{attrs:{"title":_vm.classData.title,"visible":_vm.classData.dialogVisible,"width":"30%","before-close":_vm.handleClose},on:{"update:visible":function($event){return _vm.$set(_vm.classData, "dialogVisible", $event)}}},[_c('el-form',{ref:"classData",staticClass:"demo-form-inline",attrs:{"model":_vm.classData,"rules":_vm.rules,"label-width":"100px"}},[_c('el-form-item',{attrs:{"label":"分类名称：","prop":"name"}},[_c('el-input',{attrs:{"placeholder":"请输入分类名称","maxlength":"20"},model:{value:(_vm.classData.name),callback:function ($$v) {_vm.$set(_vm.classData, "name", $$v)},expression:"classData.name"}})],1),_c('el-form-item',{attrs:{"label":"排序：","prop":"sort"}},[_c('el-input',{attrs:{"placeholder":"请输入排序"},model:{value:(_vm.classData.sort),callback:function ($$v) {_vm.$set(_vm.classData, "sort", $$v)},expression:"classData.sort"}})],1)],1),_c('span',{staticClass:"dialog-footer",attrs:{"slot":"footer"},slot:"footer"},[_c('el-button',{attrs:{"size":"medium"},on:{"click":function($event){;(_vm.classData.dialogVisible = false), _vm.$refs.classData.resetFields()}}},[_vm._v("取 消")]),_c('el-button',{class:{ continue: _vm.actionType === 'add' },attrs:{"type":"primary","size":"medium"},on:{"click":function($event){return _vm.submitForm()}}},[_vm._v("确 定")]),(_vm.action != 'edit')?_c('el-button',{attrs:{"type":"primary","size":"medium"},on:{"click":function($event){return _vm.submitForm('go')}}},[_vm._v("\n        保存并继续添加\n      ")]):_vm._e()],1)],1)],1)}
const __staticRenderFns__ = []
























































































































































import { Component, Vue } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import {
  getCategoryPage,
  deleCategory,
  editCategory,
  addCategory,
  enableOrDisableEmployee
} from '@/api/category'
import Empty from '@/components/Empty/index.vue'

@Component({ name: 'Category',
  components: {
    HeadLable,
    Empty
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  private options: any = [
    {
      value: 1,
      label: '菜品分类'
    },
    {
      value: 2,
      label: '套餐分类'
    }
  ]
  private actionType: string = ''
  private id = ''
  private status = ''
  private categoryType: number = null
  private name: string = ''
  private action: string = ''
  private counts: number = 0
  private page: number = 1
  private pageSize: number = 10
  private tableData = []
  private type = ''
  private isSearch: boolean = false
  private classData: any = {
    title: '添加菜品分类',
    dialogVisible: false,
    categoryId: '',
    name: '',
    sort: ''
  }

  get rules() {
    return {
      name: [
        {
          required: true,
          trigger: 'blur',
          validator: (rule: any, value: string, callback: Function) => {
            // const reg = /[\u4e00-\u9fa5]/
            var reg = new RegExp('^[A-Za-z\u4e00-\u9fa5]+$')
            if (!value) {
              callback(new Error(this.classData.title + '不能为空'))
            } else if (value.length < 2) {
              callback(new Error('分类名称输入不符，请输入2-20个字符'))
            } else if (!reg.test(value)) {
              callback(new Error('分类名称包含特殊字符'))
            } else {
              callback()
            }
          }
        }
      ],
      sort: [
        {
          required: true,
          trigger: 'blur',
          validator: (rule: any, value: string, callback: Function) => {
            if (value || String(value) === '0') {
              const reg = /^\d+$/
              if (!reg.test(value)) {
                callback(new Error('排序只能输入数字类型'))
              } else if (Number(value) > 99) {
                callback(new Error('排序只能输入0-99数字'))
              } else {
                callback()
              }
            } else {
              callback(new Error('排序不能为空'))
            }
          }
        }
      ]
    }
  }

  created() {
    this.init()
  }

  // 初始化信息
  private async init(isSearch?) {
    this.isSearch = isSearch
    await getCategoryPage({
      page: this.page,
      pageSize: this.pageSize,
      name: this.name ? this.name : undefined,
      type: this.categoryType ? this.categoryType : undefined
    })
      .then(res => {
        if (String(res.data.code) === '1') {
          this.tableData =
            res && res.data && res.data.data && res.data.data.records
          this.counts = Number(res.data.data.total)
        } else {
          this.$message.error(res.data.desc)
        }
      })
      .catch(err => {
        console.log(err, 'err')
        this.$message.error('请求出错了：' + err.message)
      })
  }

  // 添加
  private addClass(st: any) {
    if (st == 'class') {
      this.classData.title = '新增菜品分类'
      this.type = '1'
    } else {
      this.classData.title = '新增套餐分类'
      this.type = '2'
    }
    this.action = 'add'
    this.classData.name = ''
    this.classData.sort = ''
    this.classData.dialogVisible = true
    this.actionType = 'add'
  }

  // 修改
  private editHandle(dat: any) {
    this.classData.title = '修改分类'
    this.action = 'edit'
    this.classData.name = dat.name
    this.classData.sort = dat.sort
    this.classData.id = dat.id
    this.classData.dialogVisible = true
    this.actionType = 'edit'
  }

  // 关闭弹窗
  private handleClose(st: string) {
    console.log(this.$refs.classData, 'this.$refs.classData')
    this.classData.dialogVisible = false
    //对该表单项进行重置，将其值重置为初始值并移除校验结果
    this.$refs.classData.resetFields()
  }

  //状态修改
  private statusHandle(row: any) {
    this.id = row.id
    this.status = row.status
    this.$confirm('确认调整该分类的状态?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
      customClass: 'customClass'
    }).then(() => {
      enableOrDisableEmployee({ id: this.id, status: !this.status ? 1 : 0 })
        .then(res => {
          if (String(res.status) === '200') {
            this.$message.success('分类状态更改成功！')
            this.init()
          }
        })
        .catch(err => {
          this.$message.error('请求出错了：' + err.message)
        })
    })
  }

  //删除
  private deleteHandle(id: any) {
    this.$confirm('此操作将永久删除该分类，是否继续？', '确定删除', {
      confirmButtonText: '删除',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      deleCategory(id)
        .then(res => {
          if (res.data.code === 1) {
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

  $refs!: {
    classData: any
  }

  //数据提交
  submitForm(st: any) {
    if (this.action === 'add') {
      this.$refs.classData.validate((value: boolean) => {
        if (value) {
          addCategory({
            name: this.classData.name,
            type: this.type,
            sort: this.classData.sort
          })
            .then(res => {
              if (res.data.code === 1) {
                this.$message.success('分类添加成功！')
                this.$refs.classData.resetFields()
                if (!st) {
                  this.classData.dialogVisible = false
                }
                this.init()
              } else {
                this.$message.error(res.data.desc || res.data.msg)
              }
            })
            .catch(err => {
              this.$message.error('请求出错了：' + err.message)
            })
        }
      })
    } else {
      this.$refs.classData.validate((value: boolean) => {
        if (value) {
          editCategory({
            id: this.classData.id,
            name: this.classData.name,
            sort: this.classData.sort
          })
            .then(res => {
              if (res.data.code === 1) {
                this.$message.success('分类修改成功！')
                this.classData.dialogVisible = false
                this.$refs.classData.resetFields()
                this.init()
              } else {
                this.$message.error(res.data.desc || res.data.msg)
              }
            })
            .catch(err => {
              this.$message.error('请求出错了：' + err.message)
            })
        }
      })
    }
  }

  //分页
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
