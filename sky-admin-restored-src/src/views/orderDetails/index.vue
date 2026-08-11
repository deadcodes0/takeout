<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"dashboard-container"},[_c('TabChange',{attrs:{"order-statics":_vm.orderStatics,"default-activity":_vm.defaultActivity},on:{"tabChange":_vm.change}}),_c('div',{staticClass:"container",class:{ hContainer: _vm.tableData.length }},[_c('div',{staticClass:"tableBar"},[_c('label',{staticStyle:{"margin-right":"10px"}},[_vm._v("订单号：")]),_c('el-input',{staticStyle:{"width":"15%"},attrs:{"placeholder":"请填写订单号","clearable":""},on:{"clear":function($event){return _vm.init(_vm.orderStatus)}},nativeOn:{"keyup":function($event){if(!$event.type.indexOf('key')&&_vm._k($event.keyCode,"enter",13,$event.key,"Enter")){ return null; }return _vm.initFun(_vm.orderStatus)}},model:{value:(_vm.input),callback:function ($$v) {_vm.input=$$v},expression:"input"}}),_c('label',{staticStyle:{"margin-left":"20px"}},[_vm._v("手机号：")]),_c('el-input',{staticStyle:{"width":"15%"},attrs:{"placeholder":"请填写手机号","clearable":""},on:{"clear":function($event){return _vm.init(_vm.orderStatus)}},nativeOn:{"keyup":function($event){if(!$event.type.indexOf('key')&&_vm._k($event.keyCode,"enter",13,$event.key,"Enter")){ return null; }return _vm.initFun(_vm.orderStatus)}},model:{value:(_vm.phone),callback:function ($$v) {_vm.phone=$$v},expression:"phone"}}),_c('label',{staticStyle:{"margin-left":"20px"}},[_vm._v("下单时间：")]),_c('el-date-picker',{staticStyle:{"width":"25%","margin-left":"10px"},attrs:{"clearable":"","value-format":"yyyy-MM-dd HH:mm:ss","range-separator":"至","default-time":['00:00:00', '23:59:59'],"type":"daterange","start-placeholder":"开始日期","end-placeholder":"结束日期"},on:{"clear":function($event){return _vm.init(_vm.orderStatus)}},model:{value:(_vm.valueTime),callback:function ($$v) {_vm.valueTime=$$v},expression:"valueTime"}}),_c('el-button',{staticClass:"normal-btn continue",on:{"click":function($event){return _vm.init(_vm.orderStatus, true)}}},[_vm._v("\n        查询\n      ")])],1),(_vm.tableData.length)?_c('el-table',{staticClass:"tableBox",attrs:{"data":_vm.tableData,"stripe":""}},[_c('el-table-column',{key:"number",attrs:{"prop":"number","label":"订单号"}}),([2, 3, 4].includes(_vm.orderStatus))?_c('el-table-column',{key:"orderDishes",attrs:{"prop":"orderDishes","label":"订单菜品"}}):_vm._e(),([0].includes(_vm.orderStatus))?_c('el-table-column',{key:"status",attrs:{"prop":"订单状态","label":"订单状态"},scopedSlots:_vm._u([{key:"default",fn:function(ref){
var row = ref.row;
return [_c('span',[_vm._v(_vm._s(_vm.getOrderType(row)))])]}}],null,false,1146136203)}):_vm._e(),([0, 2, 3, 4, 5, 6].includes(_vm.orderStatus))?_c('el-table-column',{key:"consignee",attrs:{"prop":"consignee","label":"用户名","show-overflow-tooltip":""}}):_vm._e(),([0, 2, 3, 4, 5, 6].includes(_vm.orderStatus))?_c('el-table-column',{key:"phone",attrs:{"prop":"phone","label":"手机号"}}):_vm._e(),([0, 2, 3, 4, 5, 6].includes(_vm.orderStatus))?_c('el-table-column',{key:"address",attrs:{"prop":"address","label":"地址","class-name":_vm.orderStatus === 6 ? 'address' : ''}}):_vm._e(),([0, 6].includes(_vm.orderStatus))?_c('el-table-column',{key:"orderTime",attrs:{"prop":"orderTime","label":"下单时间","class-name":"orderTime","min-width":"110"}}):_vm._e(),([6].includes(_vm.orderStatus))?_c('el-table-column',{key:"cancelTime",attrs:{"prop":"cancelTime","class-name":"cancelTime","label":"取消时间","min-width":"110"}}):_vm._e(),([6].includes(_vm.orderStatus))?_c('el-table-column',{key:"cancelReason",attrs:{"prop":"cancelReason","label":"取消原因","class-name":"cancelReason","min-width":[6].includes(_vm.orderStatus) ? 80 : 'auto'}}):_vm._e(),([5].includes(_vm.orderStatus))?_c('el-table-column',{key:"deliveryTime",attrs:{"prop":"deliveryTime","label":"送达时间"}}):_vm._e(),([2, 3, 4].includes(_vm.orderStatus))?_c('el-table-column',{key:"estimatedDeliveryTime",attrs:{"prop":"estimatedDeliveryTime","label":"预计送达时间","min-width":"110"}}):_vm._e(),([0, 2, 5].includes(_vm.orderStatus))?_c('el-table-column',{key:"amount",attrs:{"prop":"amount","label":"实收金额","align":"center"},scopedSlots:_vm._u([{key:"default",fn:function(ref){
var row = ref.row;
return [_c('span',[_vm._v("￥"+_vm._s((row.amount.toFixed(2) * 100) / 100))])]}}],null,false,1581866610)}):_vm._e(),([2, 3, 4, 5].includes(_vm.orderStatus))?_c('el-table-column',{key:"remark",attrs:{"prop":"remark","label":"备注","align":"center"}}):_vm._e(),([2, 3, 4].includes(_vm.orderStatus))?_c('el-table-column',{key:"tablewareNumber",attrs:{"prop":"tablewareNumber","label":"餐具数量","align":"center","min-width":"80"}}):_vm._e(),_c('el-table-column',{attrs:{"prop":"btn","label":"操作","align":"center","class-name":_vm.orderStatus === 0 ? 'operate' : 'otherOperate',"min-width":[2, 3, 4].includes(_vm.orderStatus)
            ? 130
            : [0].includes(_vm.orderStatus)
            ? 140
            : 'auto'},scopedSlots:_vm._u([{key:"default",fn:function(ref){
            var row = ref.row;
return [_c('div',{staticClass:"before"},[(row.status === 2)?_c('el-button',{staticClass:"blueBug",attrs:{"type":"text"},on:{"click":function($event){_vm.orderAccept(row), (_vm.isTableOperateBtn = true)}}},[_vm._v("\n              接单\n            ")]):_vm._e(),(row.status === 3)?_c('el-button',{staticClass:"blueBug",attrs:{"type":"text"},on:{"click":function($event){return _vm.cancelOrDeliveryOrComplete(3, row.id)}}},[_vm._v("\n              派送\n            ")]):_vm._e(),(row.status === 4)?_c('el-button',{staticClass:"blueBug",attrs:{"type":"text"},on:{"click":function($event){return _vm.cancelOrDeliveryOrComplete(4, row.id)}}},[_vm._v("\n              完成\n            ")]):_vm._e()],1),_c('div',{staticClass:"middle"},[(row.status === 2)?_c('el-button',{staticClass:"delBut",attrs:{"type":"text"},on:{"click":function($event){_vm.orderReject(row), (_vm.isTableOperateBtn = true)}}},[_vm._v("\n              拒单\n            ")]):_vm._e(),([1, 3, 4, 5].includes(row.status))?_c('el-button',{staticClass:"delBut",attrs:{"type":"text"},on:{"click":function($event){return _vm.cancelOrder(row)}}},[_vm._v("\n              取消\n            ")]):_vm._e()],1),_c('div',{staticClass:"after"},[_c('el-button',{staticClass:"blueBug non",attrs:{"type":"text"},on:{"click":function($event){return _vm.goDetail(row.id, row.status, row)}}},[_vm._v("\n              查看\n            ")])],1)]}}],null,false,415560991)})],1):_c('Empty',{attrs:{"is-search":_vm.isSearch}}),(_vm.counts > 10)?_c('el-pagination',{staticClass:"pageList",attrs:{"page-sizes":[10, 20, 30, 40],"page-size":_vm.pageSize,"layout":"total, sizes, prev, pager, next, jumper","total":_vm.counts},on:{"size-change":_vm.handleSizeChange,"current-change":_vm.handleCurrentChange}}):_vm._e()],1),_c('el-dialog',{staticClass:"order-dialog",attrs:{"title":"订单信息","visible":_vm.dialogVisible,"width":"53%","before-close":_vm.handleClose},on:{"update:visible":function($event){_vm.dialogVisible=$event}}},[_c('el-scrollbar',{staticStyle:{"height":"100%"}},[_c('div',{staticClass:"order-top"},[_c('div',[_c('div',{staticStyle:{"display":"inline-block"}},[_c('label',{staticStyle:{"font-size":"16px"}},[_vm._v("订单号：")]),_c('div',{staticClass:"order-num"},[_vm._v("\n              "+_vm._s(_vm.diaForm.number)+"\n            ")])]),_c('div',{staticClass:"order-status",class:{ status3: [3, 4].includes(_vm.dialogOrderStatus) },staticStyle:{"display":"inline-block"}},[_vm._v("\n            "+_vm._s(_vm.orderList.filter(function (item) { return item.value === _vm.dialogOrderStatus; })[0]
                .label)+"\n          ")])]),_c('p',[_c('label',[_vm._v("下单时间：")]),_vm._v(_vm._s(_vm.diaForm.orderTime))])]),_c('div',{staticClass:"order-middle"},[_c('div',{staticClass:"user-info"},[_c('div',{staticClass:"user-info-box"},[_c('div',{staticClass:"user-name"},[_c('label',[_vm._v("用户名：")]),_c('span',[_vm._v(_vm._s(_vm.diaForm.consignee))])]),_c('div',{staticClass:"user-phone"},[_c('label',[_vm._v("手机号：")]),_c('span',[_vm._v(_vm._s(_vm.diaForm.phone))])]),([2, 3, 4, 5].includes(_vm.dialogOrderStatus))?_c('div',{staticClass:"user-getTime"},[_c('label',[_vm._v(_vm._s(_vm.dialogOrderStatus === 5 ? '送达时间：' : '预计送达时间：'))]),_c('span',[_vm._v(_vm._s(_vm.dialogOrderStatus === 5
                  ? _vm.diaForm.deliveryTime
                  : _vm.diaForm.estimatedDeliveryTime))])]):_vm._e(),_c('div',{staticClass:"user-address"},[_c('label',[_vm._v("地址：")]),_c('span',[_vm._v(_vm._s(_vm.diaForm.address))])])]),_c('div',{staticClass:"user-remark",class:{ orderCancel: _vm.dialogOrderStatus === 6 }},[_c('div',[_vm._v(_vm._s(_vm.dialogOrderStatus === 6 ? '取消原因' : '备注'))]),_c('span',[_vm._v(_vm._s(_vm.dialogOrderStatus === 6
                ? _vm.diaForm.cancelReason || _vm.diaForm.rejectionReason
                : _vm.diaForm.remark))])])]),_c('div',{staticClass:"dish-info"},[_c('div',{staticClass:"dish-label"},[_vm._v("菜品")]),_c('div',{staticClass:"dish-list"},_vm._l((_vm.diaForm.orderDetailList),function(item,index){return _c('div',{key:index,staticClass:"dish-item"},[_c('div',{staticClass:"dish-item-box"},[_c('span',{staticClass:"dish-name"},[_vm._v(_vm._s(item.name)+(item.dishFlavor?"("+_vm._s(item.dishFlavor)+")":""))]),_c('span',{staticClass:"dish-num"},[_vm._v("x"+_vm._s(item.number))])]),_c('span',{staticClass:"dish-price"},[_vm._v("￥"+_vm._s(item.amount ? item.amount.toFixed(2) : ''))])])}),0),_c('div',{staticClass:"dish-all-amount"},[_c('label',[_vm._v("菜品小计")]),_c('span',[_vm._v("￥"+_vm._s((_vm.diaForm.amount + (_vm.diaForm.couponAmount || 0) - 6 - _vm.diaForm.packAmount).toFixed(2)))])])])]),_c('div',{staticClass:"order-bottom"},[_c('div',{staticClass:"amount-info"},[_c('div',{staticClass:"amount-label"},[_vm._v("费用")]),_c('div',{staticClass:"amount-list"},[_c('div',{staticClass:"dish-amount"},[_c('span',{staticClass:"amount-name"},[_vm._v("菜品小计：")]),_c('span',{staticClass:"amount-price"},[_vm._v("￥"+_vm._s(((_vm.diaForm.amount + (_vm.diaForm.couponAmount || 0) - 6 - _vm.diaForm.packAmount).toFixed(2) *
                    100) /
                  100))])]),_c('div',{staticClass:"send-amount"},[_c('span',{staticClass:"amount-name"},[_vm._v("派送费：")]),_c('span',{staticClass:"amount-price"},[_vm._v("￥"+_vm._s(6))])]),_c('div',{staticClass:"package-amount"},[_c('span',{staticClass:"amount-name"},[_vm._v("打包费：")]),_c('span',{staticClass:"amount-price"},[_vm._v("￥"+_vm._s(_vm.diaForm.packAmount
                    ? (_vm.diaForm.packAmount.toFixed(2) * 100) / 100
                    : ''))])]),(_vm.diaForm.couponAmount && _vm.diaForm.couponAmount > 0)?_c('div',{staticClass:"coupon-amount"},[_c('span',{staticClass:"amount-name"},[_vm._v("优惠券：")]),_c('span',{staticClass:"amount-price",staticStyle:{"color":"#67c23a"}},[_vm._v("-￥"+_vm._s(_vm.diaForm.couponAmount.toFixed(2)))])]):_vm._e(),_c('div',{staticClass:"all-amount"},[_c('span',{staticClass:"amount-name"},[_vm._v("合计：")]),_c('span',{staticClass:"amount-price"},[_vm._v("￥"+_vm._s(_vm.diaForm.amount
                    ? (_vm.diaForm.amount.toFixed(2) * 100) / 100
                    : ''))])]),_c('div',{staticClass:"pay-type"},[_c('span',{staticClass:"pay-name"},[_vm._v("支付渠道：")]),_c('span',{staticClass:"pay-value"},[_vm._v(_vm._s(_vm.diaForm.payMethod === 1 ? '微信支付' : '支付宝支付'))])]),_c('div',{staticClass:"pay-time"},[_c('span',{staticClass:"pay-name"},[_vm._v("支付时间：")]),_c('span',{staticClass:"pay-value"},[_vm._v(_vm._s(_vm.diaForm.checkoutTime))])])])])])]),(_vm.diaForm.reviewed)?_c('div',{staticClass:"review-section"},[_c('div',{staticClass:"section-title",staticStyle:{"margin-bottom":"12px"}},[_c('i',{staticClass:"el-icon-star-on",staticStyle:{"color":"#f7b731"}}),_vm._v(" 用户评价")]),_c('div',{staticClass:"review-content"},[_c('div',{staticClass:"review-header"},[_c('div',{staticClass:"title"},[_c('i',{staticClass:"el-icon-star-on"}),_vm._v(" 评价详情")]),_c('span',{staticClass:"review-time"},[_vm._v("评价于 "+_vm._s(_vm.diaForm.reviewTime))])]),_c('div',{staticClass:"review-score"},[_c('el-rate',{attrs:{"disabled":true,"show-score":true,"colors":["#409eff","#409eff","#409eff"]},model:{value:(_vm.diaForm.reviewScore),callback:function ($$v) {_vm.diaForm.reviewScore=$$v},expression:"diaForm.reviewScore"}}),_c('span',{staticClass:"score-text"},[_vm._v(_vm._s(_vm.getScoreText(_vm.diaForm.reviewScore)))])],1),_c('div',{staticClass:"review-comment"},[(_vm.diaForm.reviewComment && _vm.diaForm.reviewComment.trim())?[_vm._v(_vm._s(_vm.diaForm.reviewComment))]:[_c('span',{staticClass:"empty-text"},[_vm._v("—— 用户未留下留言 ——")])]],2)])]):_c('div',{staticClass:"no-review"},[_c('i',{staticClass:"el-icon-info"}),_vm._v(" 该订单暂无评价")]),(_vm.dialogOrderStatus !== 6)?_c('span',{staticClass:"dialog-footer",attrs:{"slot":"footer"},slot:"footer"},[(_vm.dialogOrderStatus === 2 && _vm.orderStatus === 2)?_c('el-checkbox',{model:{value:(_vm.isAutoNext),callback:function ($$v) {_vm.isAutoNext=$$v},expression:"isAutoNext"}},[_vm._v("处理完自动跳转下一条")]):_vm._e(),(_vm.dialogOrderStatus === 2)?_c('el-button',{on:{"click":function($event){_vm.orderReject(_vm.row), (_vm.isTableOperateBtn = false)}}},[_vm._v("拒 单")]):_vm._e(),(_vm.dialogOrderStatus === 2)?_c('el-button',{attrs:{"type":"primary"},on:{"click":function($event){_vm.orderAccept(_vm.row), (_vm.isTableOperateBtn = false)}}},[_vm._v("接 单")]):_vm._e(),([1, 3, 4, 5].includes(_vm.dialogOrderStatus))?_c('el-button',{on:{"click":function($event){_vm.dialogVisible = false}}},[_vm._v("返 回")]):_vm._e(),(_vm.dialogOrderStatus === 3)?_c('el-button',{attrs:{"type":"primary"},on:{"click":function($event){return _vm.cancelOrDeliveryOrComplete(3, _vm.row.id)}}},[_vm._v("派 送")]):_vm._e(),(_vm.dialogOrderStatus === 4)?_c('el-button',{attrs:{"type":"primary"},on:{"click":function($event){return _vm.cancelOrDeliveryOrComplete(4, _vm.row.id)}}},[_vm._v("完 成")]):_vm._e(),([1].includes(_vm.dialogOrderStatus))?_c('el-button',{attrs:{"type":"primary"},on:{"click":function($event){return _vm.cancelOrder(_vm.row)}}},[_vm._v("取消订单")]):_vm._e()],1):_vm._e()],1),_c('el-dialog',{staticClass:"cancelDialog",attrs:{"title":_vm.cancelDialogTitle + '原因',"visible":_vm.cancelDialogVisible,"width":"42%","before-close":function () { return ((_vm.cancelDialogVisible = false), (_vm.cancelReason = '')); }},on:{"update:visible":function($event){_vm.cancelDialogVisible=$event}}},[_c('el-form',{attrs:{"label-width":"90px"}},[_c('el-form-item',{attrs:{"label":_vm.cancelDialogTitle + '原因：'}},[_c('el-select',{attrs:{"placeholder":'请选择' + _vm.cancelDialogTitle + '原因'},model:{value:(_vm.cancelReason),callback:function ($$v) {_vm.cancelReason=$$v},expression:"cancelReason"}},_vm._l((_vm.cancelDialogTitle === '取消'
              ? _vm.cancelrReasonList
              : _vm.cancelOrderReasonList),function(item,index){return _c('el-option',{key:index,attrs:{"label":item.label,"value":item.label}})}),1)],1),(_vm.cancelReason === '自定义原因')?_c('el-form-item',{attrs:{"label":"原因："}},[_c('el-input',{attrs:{"type":"textarea","placeholder":'请填写您' + _vm.cancelDialogTitle + '的原因（限20字内）',"maxlength":"20"},model:{value:(_vm.remark),callback:function ($$v) {_vm.remark=(typeof $$v === 'string'? $$v.trim(): $$v)},expression:"remark"}})],1):_vm._e()],1),_c('span',{staticClass:"dialog-footer",attrs:{"slot":"footer"},slot:"footer"},[_c('el-button',{on:{"click":function($event){;(_vm.cancelDialogVisible = false), (_vm.cancelReason = '')}}},[_vm._v("取 消")]),_c('el-button',{attrs:{"type":"primary"},on:{"click":_vm.confirmCancel}},[_vm._v("确 定")])],1)],1)],1)}
const __staticRenderFns__ = []




























































































































































































































































































































































































































































































import { Component, Vue } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import InputAutoComplete from '@/components/InputAutoComplete/index.vue'
import TabChange from './tabChange.vue'
import Empty from '@/components/Empty/index.vue'
import {
  getOrderDetailPage,
  queryOrderDetailById,
  completeOrder,
  deliveryOrder,
  orderCancel,
  orderReject,
  orderAccept,
  getOrderListBy,
} from '@/api/order'

@Component({ components: {
    HeadLable,
    InputAutoComplete,
    TabChange,
    Empty,
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  private defaultActivity: any = 0
  private orderStatics = {}
  private row = {}
  private isAutoNext = true
  private isTableOperateBtn = true
  private currentPageIndex = 0 //记录查看详情数据的index
  private orderId = '' //订单号
  private input = '' //搜索条件的订单号
  private phone = '' //搜索条件的手机号
  private valueTime = []
  private dialogVisible = false //详情弹窗
  private cancelDialogVisible = false //取消，拒单弹窗
  private cancelDialogTitle = '' //取消，拒绝弹窗标题
  private cancelReason = ''
  private remark = '' //自定义原因
  private counts: number = 0
  private page: number = 1
  private pageSize: number = 10
  private tableData = []
  private diaForm = []
  private isSearch: boolean = false
  private orderStatus = 0 //列表字段展示所需订单状态,用于分页请求数据
  private dialogOrderStatus = 0 //弹窗所需订单状态，用于详情展示字段
  private cancelOrderReasonList = [
    {
      value: 1,
      label: '订单量较多，暂时无法接单',
    },
    {
      value: 2,
      label: '菜品已销售完，暂时无法接单',
    },
    {
      value: 3,
      label: '餐厅已打烊，暂时无法接单',
    },
    {
      value: 0,
      label: '自定义原因',
    },
  ]

  private cancelrReasonList = [
    {
      value: 1,
      label: '订单量较多，暂时无法接单',
    },
    {
      value: 2,
      label: '菜品已销售完，暂时无法接单',
    },
    {
      value: 3,
      label: '骑手不足无法配送',
    },
    {
      value: 4,
      label: '客户电话取消',
    },
    {
      value: 0,
      label: '自定义原因',
    },
  ]
  private orderList = [
    {
      label: '全部订单',
      value: 0,
    },
    {
      label: '待付款',
      value: 1,
    },
    {
      label: '待接单',
      value: 2,
    },
    {
      label: '待派送',
      value: 3,
    },
    {
      label: '派送中',
      value: 4,
    },
    {
      label: '已完成',
      value: 5,
    },
    {
      label: '已取消',
      value: 6,
    },
  ]

  created() {
    this.init(Number(this.$route.query.status) || 0)
  }

  mounted() {
    //如果有值说明是消息通知点击进来的
    if (
      this.$route.query.orderId &&
      this.$route.query.orderId !== 'undefined'
    ) {
      this.goDetail(this.$route.query.orderId, 2)
    }
    if (this.$route.query.status) {
      this.defaultActivity = this.$route.query.status
    }
    // console.log(this.$route.query, 'this.$route')
  }

  initFun(orderStatus) {
    this.page = 1
    this.init(orderStatus)
  }

  change(activeIndex) {
    if (activeIndex === this.orderStatus) return
    this.init(activeIndex)
    this.input = ''
    this.phone = ''
    this.valueTime = []
    this.dialogOrderStatus = 0
    this.$router.push('/order')
    console.log(activeIndex, '接收到了子组件的index')
  }

  //获取待处理，待派送，派送中数量
  getOrderListBy3Status() {
    getOrderListBy({})
      .then((res) => {
        if (res.data.code === 1) {
          this.orderStatics = res.data.data
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  init(activeIndex: number = 0, isSearch?) {
    this.isSearch = isSearch
    const params = {
      page: this.page,
      pageSize: this.pageSize,
      number: this.input || undefined,
      phone: this.phone || undefined,
      beginTime:
        this.valueTime && this.valueTime.length > 0
          ? this.valueTime[0]
          : undefined,
      endTime:
        this.valueTime && this.valueTime.length > 0
          ? this.valueTime[1]
          : undefined,
      status: activeIndex || undefined,
    }
    getOrderDetailPage({ ...params })
      .then((res) => {
        if (res.data.code === 1) {
          // 按下单时间倒序排序（最新的在前面）
          this.tableData = res.data.data.records.sort((a: any, b: any) => {
            const timeA = new Date(a.orderTime || a.cancelTime || a.deliveryTime || 0).getTime()
            const timeB = new Date(b.orderTime || b.cancelTime || b.deliveryTime || 0).getTime()
            return timeB - timeA // 倒序：最新的在前面
          })
          this.orderStatus = activeIndex
          this.counts = Number(res.data.data.total)
          this.getOrderListBy3Status()
          if (
            this.dialogOrderStatus === 2 &&
            this.orderStatus === 2 &&
            this.isAutoNext &&
            !this.isTableOperateBtn &&
            res.data.data.records.length > 1
          ) {
            const row = res.data.data.records[0]
            this.goDetail(row.id, row.status, row)
          } else {
            return null
          }
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  getOrderType(row: any) {
    if (row.status === 1) {
      return '待付款'
    } else if (row.status === 2) {
      return '待接单'
    } else if (row.status === 3) {
      return '待派送'
    } else if (row.status === 4) {
      return '派送中'
    } else if (row.status === 5) {
      return '已完成'
    } else if (row.status === 6) {
      return '已取消'
    } else {
      return '退款'
    }
  }

  // 查看详情
  async goDetail(id: any, status: number, row?: any) {
    // console.log(111, index, row)
    this.diaForm = []
    this.dialogVisible = true
    this.dialogOrderStatus = status
    this.orderId = id
    const { data } = await queryOrderDetailById({ orderId: id })
    this.diaForm = data.data
    this.row = row || { id: this.$route.query.orderId, status: status }
    if (this.$route.query.orderId) {
      this.$router.push('/order')
    }
  }

  //打开拒单弹窗
  orderReject(row: any) {
    this.cancelDialogVisible = true
    this.orderId = row.id
    this.dialogOrderStatus = row.status
    this.cancelDialogTitle = '拒绝'
    this.dialogVisible = false
    this.cancelReason = ''
  }

  //接单
  orderAccept(row: any) {
    this.orderId = row.id
    this.dialogOrderStatus = row.status
    orderAccept({ id: this.orderId })
      .then((res) => {
        if (res.data.code === 1) {
          this.$message.success('操作成功')
          this.orderId = ''
          // this.dialogOrderStatus = 0
          this.dialogVisible = false
          this.init(this.orderStatus)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  //打开取消订单弹窗
  cancelOrder(row: any) {
    this.cancelDialogVisible = true
    this.orderId = row.id
    this.dialogOrderStatus = row.status
    this.cancelDialogTitle = '取消'
    this.dialogVisible = false
    this.cancelReason = ''
  }

  //确认取消或拒绝订单并填写原因
  confirmCancel(type) {
    if (!this.cancelReason) {
      return this.$message.error(`请选择${this.cancelDialogTitle}原因`)
    } else if (this.cancelReason === '自定义原因' && !this.remark) {
      return this.$message.error(`请输入${this.cancelDialogTitle}原因`)
    }

    ;(this.cancelDialogTitle === '取消' ? orderCancel : orderReject)({
      id: this.orderId,
      // eslint-disable-next-line standard/computed-property-even-spacing
      [this.cancelDialogTitle === '取消' ? 'cancelReason' : 'rejectionReason']:
        this.cancelReason === '自定义原因' ? this.remark : this.cancelReason,
    })
      .then((res) => {
        if (res.data.code === 1) {
          this.$message.success('操作成功')
          this.cancelDialogVisible = false
          this.orderId = ''
          // this.dialogOrderStatus = 0
          this.init(this.orderStatus)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  // 派送，完成
  cancelOrDeliveryOrComplete(status: number, id: string) {
    const params = {
      status,
      id,
    }
    ;(status === 3 ? deliveryOrder : completeOrder)(params)
      .then((res) => {
        if (res.data.code === 1) {
          this.$message.success('操作成功')
          this.orderId = ''
          // this.dialogOrderStatus = 0
          this.dialogVisible = false
          this.init(this.orderStatus)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  handleClose() {
    this.dialogVisible = false
  }

  private handleSizeChange(val: any) {
    this.pageSize = val
    this.init(this.orderStatus)
  }

  private handleCurrentChange(val: any) {
    this.page = val
    this.init(this.orderStatus)
  }

  // 获取评分文本
  private getScoreText(score: number) {
    const texts = {
      1: '很差',
      2: '较差',
      3: '一般',
      4: '满意',
      5: '非常满意'
    }
    return texts[score] || ''
  }
}
</script>

<style lang="scss" scoped>
.review-section {
  margin-top: 20px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;

  .section-title {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 16px;
    font-weight: 600;
    color: #262626;
  }

  .review-content {
    margin-top: 12px;

    .review-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;

      .title {
        display: flex;
        align-items: center;
        gap: 4px;
        font-size: 14px;
        font-weight: 500;
        color: #4e5a6b;
      }

      .review-time {
        font-size: 12px;
        color: #909399;
      }
    }

    .review-score {
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 10px;

      .score-text {
        font-size: 14px;
        color: #4e5a6b;
        font-weight: 500;
      }
    }

    .review-comment {
      font-size: 14px;
      color: #4e5a6b;
      line-height: 1.6;
      padding: 10px;
      background: white;
      border-radius: 4px;

      .empty-text {
        color: #c0c4cc;
        font-style: italic;
      }
    }
  }
}

.no-review {
  margin-top: 20px;
  padding: 15px;
  background: #fef0f0;
  color: #f56c6c;
  border-radius: 4px;
  font-size: 14px;
  display: flex;
  align-items: center;
  gap: 6px;
}

// 修复日期选择器分隔符显示问题
::v-deep .el-date-editor--daterange {
  .el-range-separator {
    padding: 0 5px;
    width: auto !important;
  }
}
</style>
