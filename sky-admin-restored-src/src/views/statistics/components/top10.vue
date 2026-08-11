<template>
  <div class="container top10">
    <div class="homeTitle">销量排名 TOP10</div>
    <div class="charBox">
      <div id="top" style="width: 100%; height: 380px"></div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator'
import * as echarts from 'echarts'

@Component({ name: 'Top' })
export default class extends Vue {
  @Prop() private top10data!: any

  @Watch('top10data', { deep: true })
  getData() {
    this.$nextTick(() => {
      this.initChart()
    })
  }

  initChart() {
    const chartDom = document.getElementById('top')
    if (!chartDom) return
    const myChart = echarts.init(chartDom)

    const option = {
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'shadow',
        },
      },
      grid: {
        left: '10%',
        right: '4%',
        bottom: '3%',
        top: '4%',
        containLabel: true,
      },
      xAxis: {
        type: 'value',
        axisLine: {
          show: false,
        },
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
      yAxis: {
        type: 'category',
        data: this.top10data?.nameList || [],
        axisLine: {
          show: false,
        },
        axisTick: {
          show: false,
        },
        axisLabel: {
          color: '#475569',
          fontSize: 13,
        },
      },
      series: [
        {
          data: this.top10data?.numberList || [],
          type: 'bar',
          barWidth: '50%',
          itemStyle: {
            color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [
              { offset: 0, color: '#3b82f6' },
              { offset: 1, color: '#60a5fa' },
            ]),
            borderRadius: [0, 6, 6, 0],
          },
          label: {
            show: true,
            position: 'right',
            color: '#475569',
            fontWeight: 500,
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
</style>