<template>
  <div class="container">
    <h2 class="homeTitle">
      菜品总览
      <span>
        <router-link to="dish">菜品管理</router-link>
      </span>
    </h2>
    <div class="orderviewBox">
      <ul>
        <li>
          <span class="status">
            <i class="iconfont icon-open"></i>已启售
          </span>
          <span class="num">{{ dishesData.sold || 0 }}</span>
        </li>
        <li>
          <span class="status">
            <i class="iconfont icon-stop"></i>已停售
          </span>
          <span class="num">{{ dishesData.discontinued || 0 }}</span>
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'

@Component({ name: 'CuisineStatistics' })
export default class extends Vue {
  @Prop() private dishesData!: any
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
        align-items: center;
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