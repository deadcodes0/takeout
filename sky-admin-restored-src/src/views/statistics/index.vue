<template>
  <div class="dashboard-container">
    <!-- 标题栏 -->
    <div class="title-index">
      <div class="month">
        <ul class="tabs">
          <li class="li-tab" :class="{ active: flag === 1 }" @click="getTitleNum(1)">昨日</li>
          <li class="li-tab" :class="{ active: flag === 2 }" @click="getTitleNum(2)">近7日</li>
          <li class="li-tab" :class="{ active: flag === 3 }" @click="getTitleNum(3)">近30日</li>
          <li class="li-tab" :class="{ active: flag === 4 }" @click="getTitleNum(4)">本周</li>
          <li class="li-tab" :class="{ active: flag === 5 }" @click="getTitleNum(5)">本月</li>
        </ul>
      </div>
      <div class="get-time">
        <p>已选时间：{{ tateData[0] }} 至 {{ tateData[1] }}</p>
      </div>
    </div>

    <!-- 图表区域 -->
    <div class="homeMain">
      <!-- 营业额统计 -->
      <TurnoverStatistics :turnoverdata="turnoverData" />

      <!-- 用户统计 -->
      <UserStatistics :userdata="userData" />
    </div>

    <div class="homeMain homecon">
      <!-- 订单统计 -->
      <OrderStatistics :orderdata="orderData" :overview-data="overviewData" />

      <!-- 销量排名TOP10 -->
      <Top :top10data="top10Data" />
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import {
  get1stAndToday,
  past7Day,
  past30Day,
  pastWeek,
  pastMonth,
} from '@/utils/formValidate'
import {
  getDataOverView, //数据概览
  getTurnoverStatistics,
  getUserStatistics,
  getOrderStatistics,
  getTop,
} from '@/api/index'
// 组件
// 营业额统计
import TurnoverStatistics from './components/turnoverStatistics.vue'
// 用户统计
import UserStatistics from './components/userStatistics.vue'
// 订单统计
import OrderStatistics from './components/orderStatistics.vue'
// 排名
import Top from './components/top10.vue'

@Component({
  name: 'Statistics',
  components: {
    TurnoverStatistics,
    UserStatistics,
    OrderStatistics,
    Top,
  },
})
export default class extends Vue {
  private overviewData = {} as any
  private flag = 2
  private tateData: string[] = []
  private turnoverData = {} as any
  private userData = {} as any
  private orderData = {
    data: {},
  } as any
  private top10Data = {} as any

  created() {
    this.getTitleNum(2)
  }

  // 获取基本数据
  init(begin: string, end: string) {
    this.$nextTick(() => {
      this.getTurnoverStatisticsData(begin, end)
      this.getUserStatisticsData(begin, end)
      this.getOrderStatisticsData(begin, end)
      this.getTopData(begin, end)
    })
  }

  // 获取营业额统计数据
  async getTurnoverStatisticsData(begin: string, end: string) {
    try {
      const data = await getTurnoverStatistics({ begin, end })
      const turnoverData = data.data.data
      this.turnoverData = {
        dateList: turnoverData.dateList.split(','),
        turnoverList: turnoverData.turnoverList.split(','),
      }
    } catch (err) {
      console.error('获取营业额统计失败:', err)
    }
  }

  // 获取用户统计数据
  async getUserStatisticsData(begin: string, end: string) {
    try {
      const data = await getUserStatistics({ begin, end })
      const userData = data.data.data
      this.userData = {
        dateList: userData.dateList.split(','),
        totalUserList: userData.totalUserList.split(','),
        newUserList: userData.newUserList.split(','),
      }
    } catch (err) {
      console.error('获取用户统计失败:', err)
    }
  }

  // 获取订单统计数据
  async getOrderStatisticsData(begin: string, end: string) {
    try {
      const data = await getOrderStatistics({ begin, end })
      const orderData = data.data.data
      this.orderData = {
        data: {
          dateList: orderData.dateList.split(','),
          orderCountList: orderData.orderCountList.split(','),
          validOrderCountList: orderData.validOrderCountList.split(','),
        },
        totalOrderCount: orderData.totalOrderCount,
        validOrderCount: orderData.validOrderCount,
        orderCompletionRate: orderData.orderCompletionRate,
      }
    } catch (err) {
      console.error('获取订单统计失败:', err)
    }
  }

  // 获取排行数据
  async getTopData(begin: string, end: string) {
    try {
      const data = await getTop({ begin, end })
      const top10Data = data.data.data
      this.top10Data = {
        nameList: top10Data.nameList.split(',').reverse(),
        numberList: top10Data.numberList.split(',').reverse(),
      }
    } catch (err) {
      console.error('获取排行数据失败:', err)
    }
  }

  // 获取当前选中的tab时间
  getTitleNum(data: number) {
    this.flag = data
    switch (data) {
      case 1:
        this.tateData = get1stAndToday()
        break
      case 2:
        this.tateData = past7Day()
        break
      case 3:
        this.tateData = past30Day()
        break
      case 4:
        this.tateData = pastWeek()
        break
      case 5:
        this.tateData = pastMonth()
        break
    }
    this.init(this.tateData[0], this.tateData[1])
  }
}
</script>

<style lang="scss" scoped>
.dashboard-container {
  padding: 12px;
  background-color: #f4f7fb;
  min-height: calc(100vh - 72px);
}

// 标题栏
.title-index {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-between;
  background: #ffffff;
  padding: 12px 16px;
  border-radius: 12px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
  gap: 8px 16px;
  margin-bottom: 12px;

  .month {
    display: flex;
    align-items: center;
    gap: 4px;
  }

  .tabs {
    display: flex;
    list-style: none;
    gap: 4px;
    background: #f1f5f9;
    padding: 4px;
    border-radius: 10px;
    margin: 0;
  }

  .li-tab {
    padding: 5px 12px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 500;
    color: #64748b;
    cursor: pointer;
    transition: all 0.2s;
    user-select: none;

    &:hover:not(.active) {
      color: #1e293b;
    }

    &.active {
      background: #ffffff;
      color: #0f172a;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
    }
  }

  .get-time {
    font-size: 13px;
    color: #475569;
    background: #f8fafc;
    padding: 3px 12px;
    border-radius: 16px;
    border: 1px solid #e2e8f0;

    p {
      margin: 0;
    }
  }
}

// 图表区域
.homeMain {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;

  &.homecon {
    margin-top: 12px;
  }
}

// 响应式
@media (max-width: 1024px) {
  .homeMain {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 640px) {
  .dashboard-container {
    padding: 8px;
  }

  .title-index {
    flex-direction: column;
    align-items: stretch;

    .month {
      overflow-x: auto;
    }

    .tabs {
      flex-wrap: nowrap;
    }

    .get-time {
      text-align: center;
    }

    .right-el-button {
      justify-content: center;
    }
  }
}
</style>