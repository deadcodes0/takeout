<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"dashboard-container"},[_c('div',{staticClass:"container"},[_c('div',{staticClass:"tableBar"},[_c('label',{staticStyle:{"margin-right":"5px"}},[_vm._v("员工姓名：")]),_c('el-input',{staticStyle:{"width":"15%"},attrs:{"placeholder":"请输入员工姓名","clearable":""},on:{"clear":_vm.init},nativeOn:{"keyup":function($event){if(!$event.type.indexOf('key')&&_vm._k($event.keyCode,"enter",13,$event.key,"Enter")){ return null; }return _vm.initFun($event)}},model:{value:(_vm.input),callback:function ($$v) {_vm.input=$$v},expression:"input"}}),_c('el-button',{staticClass:"normal-btn continue",on:{"click":function($event){return _vm.init(true)}}},[_vm._v("查询")]),_c('el-button',{staticStyle:{"float":"right"},attrs:{"type":"primary"},on:{"click":function($event){return _vm.addEmployeeHandle('add')}}},[_vm._v("\n        + 添加员工\n      ")])],1),(_vm.tableData.length)?_c('el-table',{staticClass:"tableBox",attrs:{"data":_vm.tableData,"stripe":""}},[_c('el-table-column',{attrs:{"prop":"name","label":"员工姓名"}}),_c('el-table-column',{attrs:{"prop":"username","label":"账号"}}),_c('el-table-column',{attrs:{"prop":"phone","label":"手机号"}}),_c('el-table-column',{attrs:{"label":"账号状态"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('div',{staticClass:"tableColumn-status",class:{ 'stop-use': String(scope.row.status) === '0' }},[_vm._v("\n            "+_vm._s(String(scope.row.status) === '0' ? '禁用' : '启用')+"\n          ")])]}}],null,false,1902337151)}),_c('el-table-column',{attrs:{"prop":"updateTime","label":"最后操作时间"}}),_c('el-table-column',{attrs:{"label":"操作","width":"160","align":"center"},scopedSlots:_vm._u([{key:"default",fn:function(scope){return [_c('el-button',{staticClass:"blueBug",class:{ 'disabled-text': scope.row.username === 'admin' },attrs:{"type":"text","size":"small","disabled":scope.row.username === 'admin'},on:{"click":function($event){return _vm.addEmployeeHandle(scope.row.id, scope.row.username)}}},[_vm._v("\n            修改\n          ")]),_c('el-button',{staticClass:"non",class:{
              'disabled-text': scope.row.username === 'admin',
              blueBug: scope.row.status == '0',
              delBut: scope.row.status != '0',
            },attrs:{"disabled":scope.row.username === 'admin',"type":"text","size":"small"},on:{"click":function($event){return _vm.statusHandle(scope.row)}}},[_vm._v("\n            "+_vm._s(scope.row.status == '1' ? '禁用' : '启用')+"\n          ")])]}}],null,false,517157983)})],1):_c('Empty',{attrs:{"is-search":_vm.isSearch}}),_c('el-pagination',{staticClass:"pageList",attrs:{"page-sizes":[10, 20, 30, 40],"page-size":_vm.pageSize,"layout":"total, sizes, prev, pager, next, jumper","total":_vm.counts},on:{"size-change":_vm.handleSizeChange,"current-change":_vm.handleCurrentChange}})],1)])}
const __staticRenderFns__ = []

























































































import { Component, Vue } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import { getEmployeeList, enableOrDisableEmployee } from '@/api/employee'
import { UserModule } from '@/store/modules/user'
import InputAutoComplete from '@/components/InputAutoComplete/index.vue'
import Empty from '@/components/Empty/index.vue'

@Component({ name: 'Employee',
  components: {
    HeadLable,
    InputAutoComplete,
    Empty,
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  private input: any = ''
  private counts: number = 0
  private page: number = 1
  private pageSize: number = 10
  private tableData = []
  private id = ''
  private status = ''
  private isSearch: boolean = false

  created() {
    this.init()
  }

  initProp(val) {
    this.input = val
    this.initFun()
  }

  initFun() {
    this.page = 1
    this.init()
  }

  get userName() {
    return UserModule.username
  }

  private async init(isSearch?: boolean) {
    this.isSearch = isSearch
    const params = {
      page: this.page,
      pageSize: this.pageSize,
      name: this.input ? this.input : undefined,
    }
    await getEmployeeList(params)
      .then((res: any) => {
        if (String(res.data.code) === '1') {
          this.tableData = res.data && res.data.data && res.data.data.records
          this.counts = res.data.data.total
        }
        // if (!res.data.data.records.length && type === 'search') {
        //   this.$message.error('未搜索到相关员工，请核对员工姓名是否正确')
        // }
      })
      .catch((err) => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  // 添加
  private addEmployeeHandle(st: string, username: string) {
    if (st === 'add') {
      this.$router.push({ path: '/employee/add' })
    } else {
      if (username === 'admin') {
        return
      }
      this.$router.push({ path: '/employee/add', query: { id: st } })
    }
  }

  //状态修改
  private statusHandle(row: any) {
    if (row.username === 'admin') {
      return
    }
    this.id = row.id
    this.status = row.status
    this.$confirm('确认调整该账号的状态?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }).then(() => {
      enableOrDisableEmployee({ id: this.id, status: !this.status ? 1 : 0 })
        .then((res) => {
          if (String(res.status) === '200') {
            this.$message.success('账号状态更改成功！')
            this.init()
          }
        })
        .catch((err) => {
          this.$message.error('请求出错了：' + err.message)
        })
    })
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
