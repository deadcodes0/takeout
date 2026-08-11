<template>
  <div class="dashboard-container">
    <!-- 营业数据概览 -->
    <section class="dashboard-section">
      <Overview :overview-data="overviewData" />
    </section>

    <!-- 订单管理 -->
    <section class="dashboard-section">
      <Orderview :orderview-data="orderviewData" />
    </section>

    <!-- 订单列表 -->
    <section class="dashboard-section">
      <OrderList :order-statics="orderStatics" @getOrderListBy3Status="getOrderListBy3Status" />
    </section>

    <!-- 菜品总览和套餐总览 -->
    <section class="dashboard-section statistics-row">
      <CuisineStatistics :dishes-data="dishesData" />
      <SetMealStatistics :set-meal-data="setMealData" />
    </section>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import {
  getBusinessData,
  getDataOverView, //营业数据
  getOrderData, //订单管理今日订单
  getOverviewDishes, //菜品总览
  getSetMealStatistics, //套餐总览
} from '@/api/index'
import { getOrderListBy } from '@/api/order'
// 组件
// 营业数据
import Overview from './components/overview.vue'
// 订单管理
import Orderview from './components/orderview.vue'
// 菜品总览
import CuisineStatistics from './components/cuisineStatistics.vue'
// 套餐总览
import SetMealStatistics from './components/setMealStatistics.vue'
// 订单列表
import OrderList from './components/orderList.vue'

@Component({
  name: 'Dashboard',
  components: {
    Overview,
    Orderview,
    CuisineStatistics,
    SetMealStatistics,
    OrderList,
  },
})
export default class extends Vue {
  private todayData = {} as any
  private overviewData = {} as any
  private orderviewData = {} as any
  private flag = 2
  private tateData = []
  private dishesData = {} as any
  private setMealData = {} as any
  private orderListData = [] as any[]
  private counts = 0
  private page: number = 1
  private pageSize: number = 10
  private status = 2
  private orderStatics = {} as any

  created() {
    this.init()
  }

  init() {
    this.$nextTick(() => {
      this.getBusinessData()
      this.getOrderStatisticsData()
      this.getOverStatisticsData()
      this.getSetMealStatisticsData()
      this.getOrderListBy3Status()
    })
  }

  // 获取营业数据
  async getBusinessData() {
    try {
      const data = await getBusinessData()
      this.overviewData = data.data.data || {}
    } catch (err) {
      console.error('获取营业数据失败:', err)
      this.overviewData = {}
    }
  }

  // 获取今日订单
  async getOrderStatisticsData() {
    try {
      const data = await getOrderData()
      this.orderviewData = data.data.data || {}
    } catch (err) {
      console.error('获取今日订单失败:', err)
      this.orderviewData = {}
    }
  }

  // 获取菜品总览数据
  async getOverStatisticsData() {
    try {
      const data = await getOverviewDishes()
      this.dishesData = data.data.data || {}
    } catch (err) {
      console.error('获取菜品总览失败:', err)
      this.dishesData = {}
    }
  }

  // 获取套餐总览数据
  async getSetMealStatisticsData() {
    try {
      const data = await getSetMealStatistics()
      this.setMealData = data.data.data || {}
    } catch (err) {
      console.error('获取套餐总览失败:', err)
      this.setMealData = {}
    }
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
}
</script>

<style lang="scss" scoped>
.dashboard-container {
  padding: 12px;
  background-color: #f0f2f5;
  min-height: calc(100vh - 72px);

  .dashboard-section {
    margin-bottom: 12px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
    padding: 16px;

    &:last-child {
      margin-bottom: 0;
    }
  }

  .statistics-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
    background: transparent;
    box-shadow: none;
    padding: 0;

    > * {
      margin-bottom: 0;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
      padding: 16px;
    }
  }
}

// 响应式设计
@media screen and (max-width: 768px) {
  .dashboard-container {
    padding: 8px;

    .dashboard-section {
      margin-bottom: 8px;
      padding: 12px;
    }

    .statistics-row {
      grid-template-columns: 1fr;
      gap: 8px;
    }
  }
}
</style>

<!-- 全局样式覆盖：蓝色主色调 -->
<style lang="scss">
.dashboard-container {
  // 标题统一风格
  .homeTitle {
    display: flex;
    align-items: center;
    font-size: 18px;
    font-weight: 700;
    color: #1d2129;
    margin-bottom: 16px;
    padding-bottom: 10px;
    border-bottom: 2px solid #e8edf5;
    flex-wrap: wrap;
    gap: 8px 16px;

    i {
      font-style: normal;
      font-size: 14px;
      color: #86909c;
      font-weight: normal;
      margin-left: 8px;
    }

    span {
      margin-left: auto;
      font-size: 14px;
      font-weight: normal;
      display: flex;
      align-items: center;
      gap: 12px;

      a {
        color: #409eff;
        text-decoration: none;
        transition: color 0.2s;
        font-weight: 500;

        &:hover {
          color: #66b1ff;
          text-decoration: underline;
        }
      }
    }
  }

  // 链接徽标（数字）
  .homeTitle span a .badge {
    display: inline-block;
    background: #f56c6c;
    color: #fff;
    border-radius: 10px;
    padding: 0 6px;
    font-size: 12px;
    line-height: 18px;
    min-width: 18px;
    text-align: center;
    margin-left: 3px;
  }

  // 各模块概览卡片
  .overviewBox ul,
  .orderviewBox ul {
    display: flex;
    flex-wrap: wrap;
    gap: 20px 40px;
    list-style: none;
    padding: 4px 0;
  }

  .overviewBox ul li,
  .orderviewBox ul li {
    display: flex;
    align-items: baseline;
    gap: 6px;
  }

  .overviewBox .tit {
    color: #86909c;
    font-size: 14px;
  }

  .overviewBox .num {
    font-size: 22px;
    font-weight: 700;
    color: #1d2129;
  }

  .orderviewBox .status {
    font-size: 14px;
    color: #4e5a6b;
    display: flex;
    align-items: center;
    gap: 6px;

    .iconfont {
      font-size: 16px;
    }
  }

  .orderviewBox .num {
    font-size: 18px;
    font-weight: 600;
    color: #1d2129;

    a {
      color: #409eff;
      text-decoration: none;

      &:hover {
        text-decoration: underline;
      }
    }
  }

  .orderviewBox .add a {
    display: flex;
    align-items: center;
    gap: 6px;
    color: #409eff;
    text-decoration: none;
    font-weight: 500;

    &:hover {
      text-decoration: underline;
    }
  }

  // 订单列表区域
  .homecon {
    .homeTitleBtn {
      border-bottom: 1px solid #f0f0f0;
      padding-bottom: 16px;
      margin-bottom: 16px;
    }

    .conTab {
      display: flex;
      gap: 16px;
      list-style: none;
      padding: 0;
      margin: 0;

      li {
        cursor: pointer;
        padding: 8px 16px;
        border-radius: 4px;
        transition: all 0.3s;
        color: #606266;
        font-size: 14px;

        &:hover {
          background: #f5f7fa;
        }

        &.active {
          color: #409eff;
          background: #ecf5ff;
        }
      }
    }
  }

  // 表格风格
  .tableBox {
    background: #fff !important;
    border-radius: 8px;
    overflow: hidden;

    &::before {
      display: none;
    }

    th {
      background: #fafafa !important;
      color: #606266 !important;
      font-weight: 600;
    }

    td {
      color: #606266 !important;
    }

    tr:hover td {
      background: #f5f7fa !important;
    }
  }

  // 操作按钮风格
  .blueBug {
    color: #409eff !important;

    &:hover {
      color: #66b1ff !important;
    }
  }

  .delBut {
    color: #f56c6c !important;

    &:hover {
      color: #f78989 !important;
    }
  }

  .non {
    color: #909399 !important;
  }

  // 分页风格
  .pageList {
    margin-top: 16px;
    text-align: right;

    .el-pagination {
      .btn-prev,
      .btn-next {
        color: #606266 !important;
      }

      .el-pager li {
        color: #606266 !important;

        &.active {
          color: #409eff !important;
        }
      }
    }
  }

  // 新增按钮风格
  .add {
    a {
      background: #fafafa !important;
      border: 1px dashed #d9d9d9 !important;
      border-radius: 8px !important;
      color: #606266 !important;
      transition: all 0.3s;

      &:hover {
        border-color: #409eff !important;
        color: #409eff !important;
        background: #ecf5ff !important;
      }
    }
  }

  // 弹窗风格
  .order-dialog {
    .el-dialog {
      border-radius: 8px;

      .el-dialog__header {
        border-bottom: 1px solid #f0f0f0;
        padding: 16px 20px;
      }

      .el-dialog__body {
        padding: 20px;
      }
    }
  }

  .cancelDialog {
    .el-dialog {
      border-radius: 8px;
    }
  }

  // 空状态风格
  .empty {
    padding: 40px 0;
    color: #909399;

    img {
      opacity: 0.5;
    }
  }

  // 滚动条风格
  .el-scrollbar__thumb {
    background: #d9d9d9;

    &:hover {
      background: #bfbfbf;
    }
  }
}

// 响应式设计
@media screen and (max-width: 768px) {
  .dashboard-container {
    .homeTitle span {
      margin-left: 0;
      width: 100%;
      justify-content: flex-start;
    }

    .overviewBox ul,
    .orderviewBox ul {
      gap: 16px;
    }

    .overviewBox ul li,
    .orderviewBox ul li {
      min-width: calc(50% - 8px);
    }
  }
}
</style>