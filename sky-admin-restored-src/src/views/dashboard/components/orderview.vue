<template>
  <div class="container">
    <h2 class="homeTitle">
      订单管理
      <i>{{ days[1] }}</i>
      <span>
        <router-link to="/order">订单明细</router-link>
      </span>
    </h2>
    <div class="orderviewBox">
      <ul>
        <li>
          <span class="status">
            <i class="iconfont icon-waiting"></i>待接单
          </span>
          <span class="num tip">
            <router-link to="/order?status=2">{{ orderviewData.waitingOrders || 0 }}</router-link>
          </span>
        </li>
        <li>
          <span class="status">
            <i class="iconfont icon-staySway"></i>待派送
          </span>
          <span class="num tip">
            <router-link to="/order?status=3">{{ orderviewData.deliveredOrders || 0 }}</router-link>
          </span>
        </li>
        <li>
          <span class="status">
            <i class="iconfont icon-complete"></i>已完成
          </span>
          <span class="num">
            <router-link to="/order?status=5">{{ orderviewData.completedOrders || 0 }}</router-link>
          </span>
        </li>
        <li>
          <span class="status">
            <i class="iconfont icon-cancel"></i>已取消
          </span>
          <span class="num">
            <router-link to="/order?status=6">{{ orderviewData.cancelledOrders || 0 }}</router-link>
          </span>
        </li>
        <li>
          <span class="status">
            <i class="iconfont icon-all"></i>全部订单
          </span>
          <span class="num">
            <router-link to="/order">{{ orderviewData.allOrders || 0 }}</router-link>
          </span>
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { getday } from '@/utils/formValidate'

@Component({ name: 'Orderview' })
export default class extends Vue {
  @Prop() private orderviewData!: any

  get days() {
    return getday()
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

  .orderviewBox {
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

      .status {
        font-size: 13px;
        color: #4e5a6b;
        display: flex;
        align-items: center;
        gap: 5px;

        .iconfont {
          font-size: 14px;
        }
      }

      .num {
        font-size: 16px;
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

    .orderviewBox ul {
      gap: 12px;

      li {
        min-width: calc(50% - 6px);
      }
    }
  }
}
</style>