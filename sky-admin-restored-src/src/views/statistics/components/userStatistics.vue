<template>
  <div class="container">
    <div class="homeTitle">用户统计</div>
    <div class="charBox">
      <div id="usermain" style="width: 100%; height: 320px"></div>
      <ul class="orderListLine user">
        <li class="one"><span></span>用户总量（个）</li>
        <li class="three"><span></span>新增用户（个）</li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator'
import * as echarts from 'echarts'

@Component({ name: 'UserStatistics' })
export default class extends Vue {
  @Prop() private userdata!: any

  @Watch('userdata', { deep: true })
  getData() {
    this.$nextTick(() => {
      this.initChart()
    })
  }

  initChart() {
    const chartDom = document.getElementById('usermain')
    if (!chartDom) return
    const myChart = echarts.init(chartDom)

    const option = {
      tooltip: {
        trigger: 'axis',
      },
      grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        top: '6%',
        containLabel: true,
      },
      xAxis: {
        type: 'category',
        data: this.userdata.dateList || [],
        axisLine: {
          lineStyle: {
            color: '#e2e8f0',
          },
        },
        axisLabel: {
          color: '#64748b',
          fontSize: 12,
        },
      },
      yAxis: {
        type: 'value',
        splitLine: {
          lineStyle: {
            color: '#f0f2f5',
            type: 'dashed',
          },
        },
        axisLabel: {
          color: '#64748b',
          fontSize: 12,
        },
      },
      series: [
        {
          name: '用户总量',
          data: this.userdata.totalUserList || [],
          type: 'line',
          smooth: true,
          lineStyle: {
            width: 3,
            color: '#ffd000',
          },
          symbol: 'circle',
          symbolSize: 8,
          itemStyle: {
            color: '#ffd000',
          },
        },
        {
          name: '新增用户',
          data: this.userdata.newUserList || [],
          type: 'line',
          smooth: true,
          lineStyle: {
            width: 3,
            color: '#fd7f7f',
          },
          symbol: 'diamond',
          symbolSize: 10,
          itemStyle: {
            color: '#fd7f7f',
          },
        },
      ],
    }
    option && myChart.setOption(option)

    // 窗口自适应
    window.addEventListener('resize', () => {
      myChart.resize()
    })
  }
}
</script>

<style lang="scss" scoped>
.container {
  background: #ffffff;
  border-radius: 12px;
  padding: 12px 16px 16px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
  transition: box-shadow 0.2s;

  &:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
  }

  .homeTitle {
    font-size: 16px;
    font-weight: 600;
    color: #0f172a;
    margin-bottom: 12px;
    letter-spacing: 0.2px;
    display: flex;
    align-items: center;
    gap: 6px;

    &::after {
      content: '';
      flex: 1;
      height: 1px;
      background: #e9edf2;
      margin-left: 10px;
    }
  }

  .charBox {
    position: relative;
    width: 100%;
  }
}

// 图例
.orderListLine {
  display: flex;
  flex-wrap: wrap;
  gap: 16px 24px;
  margin-top: 8px;
  padding-top: 8px;
  border-top: 1px solid #f0f2f5;
  list-style: none;
  font-size: 12px;
  color: #475569;
  padding-left: 0;

  li {
    display: flex;
    align-items: center;
    gap: 5px;

    span {
      display: inline-block;
      width: 10px;
      height: 10px;
      border-radius: 3px;
      margin-right: 3px;
    }
  }

  &.user li.one span {
    background: #ffd000;
  }

  &.user li.three span {
    background: #fd7f7f;
  }
}
</style>