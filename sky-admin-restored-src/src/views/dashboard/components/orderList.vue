<template>
  <div class="container homecon">
    <!-- 修改点：将原来的 conTab 替换为 span 链接 -->
    <h2 class="homeTitle homeTitleBtn">
      订单信息
      <span>
        <a :class="{ active: status === 2 }" @click="handleStatusChange(2)">
          待接单
          <sup class="badge">{{ orderStatics.toBeConfirmed || 0 }}</sup>
        </a>
        <a :class="{ active: status === 3 }" @click="handleStatusChange(3)">
          待派送
          <sup class="badge">{{ orderStatics.confirmed || 0 }}</sup>
        </a>
      </span>
    </h2>
    <!-- 表格内容保持不变 -->
    <div>
      <el-table
        v-if="orderData.length > 0"
        :data="orderData"
        class="tableBox"
        style="width: 100%"
        stripe
        @row-click="handleTable"
      >
        <el-table-column prop="number" label="订单号" width="169" />
        <el-table-column label="订单菜品" width="167">
          <template slot-scope="scope">
            <el-popover
              placement="top-start"
              title=""
              width="200"
              trigger="hover"
              :content="scope.row.orderDishes"
            >
              <span slot="reference" class="ellipsisHidden">{{ scope.row.orderDishes }}</span>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column
          label="地址"
          width="167"
          :class-name="dialogOrderStatus === 2 ? 'address' : ''"
        >
          <template slot-scope="scope">
            <el-popover
              placement="top-start"
              title=""
              width="200"
              trigger="hover"
              :content="scope.row.address"
            >
              <span slot="reference" class="ellipsisHidden">{{ scope.row.address }}</span>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column
          prop="estimatedDeliveryTime"
          label="预计送达时间"
          sortable
          class-name="orderTime"
          min-width="130"
        />
        <el-table-column prop="amount" label="实收金额" />
        <el-table-column label="备注">
          <template slot-scope="scope">
            <el-popover
              placement="top-start"
              title=""
              width="200"
              trigger="hover"
              :content="scope.row.remark"
            >
              <span slot="reference" class="ellipsisHidden">{{ scope.row.remark }}</span>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column
          v-if="status === 3"
          prop="tablewareNumber"
          label="餐具数量"
          min-width="80"
          align="center"
        />
        <el-table-column
          label="操作"
          align="center"
          :class-name="dialogOrderStatus === 0 ? 'operate' : 'otherOperate'"
          :min-width="
            [2, 3].includes(dialogOrderStatus)
              ? 130
              : [0].includes(dialogOrderStatus)
              ? 140
              : 'auto'
          "
        >
          <template slot-scope="{ row }">
            <div class="before">
              <el-button
                v-if="row.status === 2"
                class="blueBug"
                type="text"
                @click.stop="orderAccept(row, $event), (isTableOperateBtn = true)"
              >
                接单
              </el-button>
              <el-button
                v-if="row.status === 3"
                class="blueBug"
                type="text"
                @click.stop="cancelOrDeliveryOrComplete(3, row.id, $event)"
              >
                派送
              </el-button>
            </div>
            <div class="middle">
              <el-button
                v-if="row.status === 2"
                class="delBut"
                type="text"
                @click.stop="orderReject(row, $event), (isTableOperateBtn = true)"
              >
                拒单
              </el-button>
              <el-button
                v-if="[1, 3, 4, 5].includes(row.status)"
                class="delBut"
                type="text"
                @click.stop="cancelOrder(row, $event)"
              >
                取消
              </el-button>
            </div>
            <div class="after">
              <el-button
                class="blueBug non"
                type="text"
                @click.stop="goDetail(row.id, row.status, row, $event)"
              >
                查看
              </el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>
      <Empty v-else :is-search="isSearch" />
      <el-pagination
        v-if="counts > 10"
        class="pageList"
        :page-sizes="[10, 20, 30, 40]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="counts"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>

    <!-- 订单详情弹窗 -->
    <el-dialog
      class="order-dialog"
      title="订单信息"
      :visible.sync="dialogVisible"
      width="53%"
      :before-close="handleClose"
    >
      <el-scrollbar style="height: 100%">
        <div class="order-top">
          <div>
            <div style="display: inline-block">
              <label style="font-size: 16px">订单号：</label>
              <div class="order-num">{{ diaForm.number }}</div>
            </div>
            <div
              class="order-status"
              :class="{ status3: [3, 4].includes(dialogOrderStatus) }"
              style="display: inline-block"
            >
              {{ orderList.filter((item) => item.value === dialogOrderStatus)[0].label }}
            </div>
          </div>
          <p>
            <label>下单时间：</label>
            {{ diaForm.orderTime }}
          </p>
        </div>
        <div class="order-middle">
          <div class="user-info">
            <div class="user-info-box">
              <div class="user-name">
                <label>用户名：</label>
                <span>{{ diaForm.consignee }}</span>
              </div>
              <div class="user-phone">
                <label>手机号：</label>
                <span>{{ diaForm.phone }}</span>
              </div>
              <div v-if="[2, 3, 4, 5].includes(dialogOrderStatus)" class="user-getTime">
                <label>{{ dialogOrderStatus === 5 ? '送达时间：' : '预计送达时间：' }}</label>
                <span>
                  {{ dialogOrderStatus === 5 ? diaForm.deliveryTime : diaForm.estimatedDeliveryTime }}
                </span>
              </div>
              <div class="user-address">
                <label>地址：</label>
                <span>{{ diaForm.address }}</span>
              </div>
            </div>
            <div class="user-remark" :class="{ orderCancel: dialogOrderStatus === 6 }">
              <div>{{ dialogOrderStatus === 6 ? '取消原因' : '备注' }}</div>
              <span>
                {{ dialogOrderStatus === 6 ? diaForm.cancelReason || diaForm.rejectionReason : diaForm.remark }}
              </span>
            </div>
          </div>
          <div class="dish-info">
            <div class="dish-label">菜品</div>
            <div class="dish-list">
              <div v-for="(item, index) in diaForm.orderDetailList" :key="index" class="dish-item">
                <span class="dish-name">{{ item.name }}</span>
                <span class="dish-num">x{{ item.number }}</span>
                <span class="dish-price">￥{{ item.amount ? item.amount.toFixed(2) : '' }}</span>
              </div>
            </div>
            <div class="dish-all-amount">
              <label>菜品小计</label>
              <span>￥{{ (diaForm.amount - 6 - diaForm.packAmount).toFixed(2) }}</span>
            </div>
          </div>
        </div>
        <div class="order-bottom">
          <div class="amount-info">
            <div class="amount-label">费用</div>
            <div class="amount-list">
              <div class="dish-amount">
                <span class="amount-name">菜品小计：</span>
                <span class="amount-price">
                  ￥{{ ((diaForm.amount - 6 - diaForm.packAmount).toFixed(2) * 100) / 100 }}
                </span>
              </div>
              <div class="send-amount">
                <span class="amount-name">派送费：</span>
                <span class="amount-price">￥6</span>
              </div>
              <div class="package-amount">
                <span class="amount-name">打包费：</span>
                <span class="amount-price">
                  ￥{{ diaForm.packAmount ? (diaForm.packAmount.toFixed(2) * 100) / 100 : '' }}
                </span>
              </div>
              <div class="all-amount">
                <span class="amount-name">合计：</span>
                <span class="amount-price">
                  ￥{{ diaForm.amount ? (diaForm.amount.toFixed(2) * 100) / 100 : '' }}
                </span>
              </div>
              <div class="pay-type">
                <span class="pay-name">支付渠道：</span>
                <span class="pay-value">{{ diaForm.payMethod === 1 ? '微信支付' : '支付宝支付' }}</span>
              </div>
              <div class="pay-time">
                <span class="pay-name">支付时间：</span>
                <span class="pay-value">{{ diaForm.checkoutTime }}</span>
              </div>
            </div>
          </div>
        </div>
      </el-scrollbar>
      <span v-if="dialogOrderStatus !== 6" slot="footer" class="dialog-footer">
        <el-checkbox
          v-if="dialogOrderStatus === 2 && status === 2"
          v-model="isAutoNext"
        >
          处理完自动跳转下一条
        </el-checkbox>
        <el-button
          v-if="dialogOrderStatus === 2"
          @click="orderReject(row, $event), (isTableOperateBtn = false)"
        >
          拒 单
        </el-button>
        <el-button
          v-if="dialogOrderStatus === 2"
          type="primary"
          @click="orderAccept(row, $event), (isTableOperateBtn = false)"
        >
          接 单
        </el-button>
        <el-button
          v-if="[1, 3, 4, 5].includes(dialogOrderStatus)"
          @click="dialogVisible = false"
        >
          返 回
        </el-button>
        <el-button
          v-if="dialogOrderStatus === 3"
          type="primary"
          @click="cancelOrDeliveryOrComplete(3, row.id, $event)"
        >
          派 送
        </el-button>
        <el-button
          v-if="dialogOrderStatus === 4"
          type="primary"
          @click="cancelOrDeliveryOrComplete(4, row.id, $event)"
        >
          完 成
        </el-button>
        <el-button
          v-if="[1].includes(dialogOrderStatus)"
          type="primary"
          @click="cancelOrder(row, $event)"
        >
          取消订单
        </el-button>
      </span>
    </el-dialog>

    <!-- 取消/拒单弹窗 -->
    <el-dialog
      class="cancelDialog"
      :title="cancelDialogTitle + '原因'"
      :visible.sync="cancelDialogVisible"
      width="42%"
      :before-close="() => ((cancelDialogVisible = false), (cancelReason = ''))"
    >
      <el-form label-width="90px">
        <el-form-item :label="cancelDialogTitle + '原因：'">
          <el-select
            v-model="cancelReason"
            :placeholder="'请选择' + cancelDialogTitle + '原因'"
          >
            <el-option
              v-for="(item, index) in cancelDialogTitle === '取消'
                ? cancelrReasonList
                : cancelOrderReasonList"
              :key="index"
              :label="item.label"
              :value="item.label"
            />
          </el-select>
        </el-form-item>
        <el-form-item v-if="cancelReason === '自定义原因'" label="原因：">
          <el-input
            v-model.trim="remark"
            type="textarea"
            :placeholder="'请填写您' + cancelDialogTitle + '的原因（限20字内）'"
            maxlength="20"
          />
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click=";(cancelDialogVisible = false), (cancelReason = '')">取 消</el-button>
        <el-button type="primary" @click="confirmCancel">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
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

@Component({ name: 'OrderList', components: { Empty } })
export default class extends Vue {
  @Prop({ default: '' }) orderStatics!: any

  private orderId = '' //订单号
  private dialogOrderStatus = 2 //弹窗所需订单状态，用于详情展示字段
  private activeIndex = 0

  private dialogVisible = false //详情弹窗
  private cancelDialogVisible = false //取消，拒单弹窗
  private cancelDialogTitle = '' //取消，拒绝弹窗标题
  private cancelReason = ''
  private remark = '' //自定义原因
  private diaForm = [] as any
  private row = {} as any
  private isAutoNext = true
  private isSearch: boolean = false
  private counts = 0
  private page: number = 1
  private pageSize: number = 10
  private status = 2
  private orderData = [] as any[]
  private isTableOperateBtn = true
  private cancelOrderReasonList = [
    { value: 1, label: '订单量较多，暂时无法接单' },
    { value: 2, label: '菜品已销售完，暂时无法接单' },
    { value: 3, label: '餐厅已打烊，暂时无法接单' },
    { value: 0, label: '自定义原因' },
  ]

  private cancelrReasonList = [
    { value: 1, label: '订单量较多，暂时无法接单' },
    { value: 2, label: '菜品已销售完，暂时无法接单' },
    { value: 3, label: '骑手不足无法配送' },
    { value: 4, label: '客户电话取消' },
    { value: 0, label: '自定义原因' },
  ]

  private orderList = [
    { label: '全部订单', value: 0 },
    { label: '待付款', value: 1 },
    { label: '待接单', value: 2 },
    { label: '待派送', value: 3 },
    { label: '派送中', value: 4 },
    { label: '已完成', value: 5 },
    { label: '已取消', value: 6 },
  ]

  created() {
    this.getOrderListData(this.status)
  }

  // 获取订单数据
  async getOrderListData(status: number) {
    const params = {
      page: this.page,
      pageSize: this.pageSize,
      status: status,
    }
    try {
      const data = await getOrderDetailPage(params)
      this.orderData = data.data.data.records || []
      this.counts = data.data.data.total || 0
      this.$emit('getOrderListBy3Status')
    } catch (err) {
      console.error('获取订单数据失败:', err)
      this.orderData = []
      this.counts = 0
    }
  }

  //接单
  orderAccept(row: any, event: any) {
    event.stopPropagation()
    this.orderId = row.id
    this.dialogOrderStatus = row.status
    orderAccept({ id: this.orderId })
      .then((res) => {
        if (res.data.code === 1) {
          this.$message.success('操作成功')
          this.orderId = ''
          this.dialogVisible = false
          this.getOrderListData(this.status)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  //打开取消订单弹窗
  cancelOrder(row: any, event: any) {
    event.stopPropagation()
    this.cancelDialogVisible = true
    this.orderId = row.id
    this.dialogOrderStatus = row.status
    this.cancelDialogTitle = '取消'
    this.dialogVisible = false
    this.cancelReason = ''
  }

  //打开拒单弹窗
  orderReject(row: any, event: any) {
    event.stopPropagation()
    this.cancelDialogVisible = true
    this.orderId = row.id
    this.dialogOrderStatus = row.status
    this.cancelDialogTitle = '拒绝'
    this.dialogVisible = false
    this.cancelReason = ''
  }

  //确认取消或拒绝订单并填写原因
  confirmCancel() {
    if (!this.cancelReason) {
      return this.$message.error(`请选择${this.cancelDialogTitle}原因`)
    } else if (this.cancelReason === '自定义原因' && !this.remark) {
      return this.$message.error(`请输入${this.cancelDialogTitle}原因`)
    }

    (this.cancelDialogTitle === '取消' ? orderCancel : orderReject)({
      id: this.orderId,
      [this.cancelDialogTitle === '取消' ? 'cancelReason' : 'rejectionReason']:
        this.cancelReason === '自定义原因' ? this.remark : this.cancelReason,
    })
      .then((res) => {
        if (res.data.code === 1) {
          this.$message.success('操作成功')
          this.cancelDialogVisible = false
          this.orderId = ''
          this.getOrderListData(this.status)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  // 派送，完成
  cancelOrDeliveryOrComplete(status: number, id: string, event: any) {
    event.stopPropagation()
    const params = {
      status,
      id,
    }
    (status === 3 ? deliveryOrder : completeOrder)(params)
      .then((res) => {
        if (res.data.code === 1) {
          this.$message.success('操作成功')
          this.orderId = ''
          this.dialogVisible = false
          this.getOrderListData(this.status)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('请求出错了：' + err.message)
      })
  }

  // 查看详情
  async goDetail(id: any, status: number, row: any, event: any) {
    event.stopPropagation()
    this.diaForm = [] as any
    this.dialogVisible = true
    this.dialogOrderStatus = status
    const { data } = await queryOrderDetailById({ orderId: id })
    this.diaForm = data.data
    this.row = row
  }

  // 关闭弹层
  handleClose() {
    this.dialogVisible = false
  }

  // 切换订单状态
  handleStatusChange(status: number) {
    if (this.status === status) return
    this.status = status
    this.page = 1
    this.dialogOrderStatus = status
    this.getOrderListData(status)
  }

  // 触发table某一行
  handleTable(row: any, column: any, event: any) {
    event.stopPropagation()
    this.goDetail(row.id, row.status, row, event)
  }

  // 分页
  private handleSizeChange(val: any) {
    this.pageSize = val
    this.getOrderListData(this.status)
  }

  private handleCurrentChange(val: any) {
    this.page = val
    this.getOrderListData(this.status)
  }
}
</script>

<style lang="scss" scoped>
.container {
  .homeTitle {
    display: flex;
    align-items: center;
    font-size: 16px;
    font-weight: 700;
    color: #1d2129;
    margin-bottom: 12px;
    padding-bottom: 8px;
    border-bottom: 2px solid #e8edf5;
    flex-wrap: wrap;
    gap: 6px 12px;

    span {
      margin-left: auto;
      font-size: 13px;
      font-weight: normal;
      display: flex;
      align-items: center;
      gap: 10px;

      a {
        color: #409eff;
        text-decoration: none;
        transition: color 0.2s;
        font-weight: 500;
        cursor: pointer;

        &:hover {
          color: #66b1ff;
        }

        &.active {
          color: #1d2129;
          font-weight: 700;
          text-decoration: none;
        }
      }
    }
  }

  .homeTitleBtn {
    border-bottom: 1px solid #f0f0f0;
    padding-bottom: 12px;
    margin-bottom: 12px;
  }

  // 链接徽标（数字）
  .badge {
    display: inline-block;
    background: #f56c6c;
    color: #fff;
    border-radius: 50%;
    width: 16px;
    height: 16px;
    line-height: 16px;
    text-align: center;
    font-size: 11px;
    margin-left: 2px;
    vertical-align: super;
  }
}

// 表格样式
.tableBox {
  .cell {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
}

.ellipsisHidden {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.orderTime .cell {
  color: #409eff;
}

.operate .cell,
.otherOperate .cell {
  display: flex;
  justify-content: center;
  gap: 6px;
  flex-wrap: wrap;
}

.blueBug {
  color: #409eff;
}

.delBut {
  color: #f56c6c;
}

.non {
  color: #909399;
}

.pageList {
  margin-top: 12px;
  text-align: right;
}

// 响应式设计
@media screen and (max-width: 768px) {
  .container .homeTitle span {
    margin-left: 0;
    width: 100%;
    justify-content: flex-start;
  }
}
</style>