<template>
  <div class="container">
    <h2 class="homeTitle">
      今日数据
      <i>{{ days[1] }}</i>
      <span>
        <router-link to="statistics">详细数据</router-link>
      </span>
    </h2>
    <div class="overviewBox">
      <ul>
        <li>
          <p class="tit">营业额</p>
          <p class="num">¥ {{ overviewData.turnover || 0 }}</p>
        </li>
        <li>
          <p class="tit">有效订单</p>
          <p class="num">{{ overviewData.validOrderCount || 0 }}</p>
        </li>
        <li>
          <p class="tit">订单完成率</p>
          <p class="num">{{ completionRate }}%</p>
        </li>
        <li>
          <p class="tit">平均客单价</p>
          <p class="num">¥ {{ overviewData.unitPrice || 0 }}</p>
        </li>
        <li>
          <p class="tit">新增用户</p>
          <p class="num">{{ overviewData.newUsers || 0 }}</p>
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { getday } from '@/utils/formValidate'

@Component({ name: 'Overview' })
export default class extends Vue {
  @Prop() private overviewData!: any

  get days() {
    return getday()
  }

  // 处理订单完成率，避免NaN%异常显示
  get completionRate(): string {
    const rate = this.overviewData?.orderCompletionRate
    if (rate === null || rate === undefined || isNaN(rate) || !isFinite(rate)) {
      return '0'
    }
    return (rate * 100).toFixed(0)
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

    i {
      font-style: normal;
      font-size: 13px;
      color: #86909c;
      font-weight: normal;
      margin-left: 6px;
    }

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

        &:hover {
          color: #66b1ff;
          text-decoration: underline;
        }
      }
    }
  }

  .overviewBox {
    ul {
      display: flex;
      flex-wrap: wrap;
      gap: 16px 32px;
      padding: 2px 0;
      margin: 0;
      list-style: none;

      li {
        display: flex;
        align-items: baseline;
        gap: 5px;
      }

      .tit {
        font-size: 13px;
        color: #86909c;
        margin: 0;
      }

      .num {
        font-size: 18px;
        font-weight: 700;
        color: #1d2129;
        margin: 0;
      }
    }
  }
}

// 响应式设计
@media screen and (max-width: 768px) {
  .container {
    .homeTitle span {
      margin-left: 0;
      width: 100%;
      justify-content: flex-start;
    }

    .overviewBox ul {
      gap: 12px;

      li {
        min-width: calc(50% - 6px);
      }
    }
  }
}
</style>