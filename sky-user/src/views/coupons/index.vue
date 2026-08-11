<template>
  <div class="coupons-container">
    <!-- 页面头部 -->
    <div class="page-header">
      <el-button @click="goBack" :icon="ArrowLeft" circle></el-button>
      <h2>优惠券</h2>
    </div>

    <!-- Tab 切换 -->
    <el-tabs v-model="activeTab" @tab-change="handleTabChange">
      <!-- 领券中心 -->
      <el-tab-pane label="领券中心" name="available">
        <div v-if="availableList.length > 0" class="coupon-list">
          <div
            v-for="coupon in availableList"
            :key="coupon.id"
            class="coupon-card"
            :class="{ claimed: coupon.hasClaimed }"
          >
            <div class="coupon-left">
              <div class="coupon-value" v-if="coupon.discountType === 'PERCENT'">
                {{ (coupon.discountValue * 10).toFixed(1) }}<span class="unit">折</span>
              </div>
              <div class="coupon-value" v-else>
                <span class="unit">¥</span>{{ coupon.discountValue }}
              </div>
              <div class="coupon-type">
                {{ coupon.discountType === 'PERCENT' ? '折扣券' : '满减券' }}
              </div>
            </div>
            <div class="coupon-right">
              <div class="coupon-name">{{ coupon.name }}</div>
              <div class="coupon-desc" v-if="coupon.description">{{ coupon.description }}</div>
              <div class="coupon-condition">
                满¥{{ coupon.minAmount || 0 }}可用
                <span v-if="coupon.isStackable === 1" class="stackable-tag">可叠加</span>
              </div>
              <div class="coupon-time">
                {{ coupon.validStartTime }} ~ {{ coupon.validEndTime }}
              </div>
              <div class="coupon-stock" v-if="!coupon.hasClaimed">
                剩余 {{ coupon.remainingStock }} 张
              </div>
              <el-button
                v-if="!coupon.hasClaimed"
                type="danger"
                size="small"
                :loading="claimingId === coupon.id"
                @click="handleReceive(coupon.id)"
              >
                立即领取
              </el-button>
              <el-button v-else type="info" size="small" disabled>已领取</el-button>
            </div>
          </div>
        </div>
        <el-empty v-else description="暂无可领取的优惠券" />
      </el-tab-pane>

      <!-- 我的优惠券 -->
      <el-tab-pane label="我的优惠券" name="mine">
        <!-- 状态筛选 -->
        <div class="status-tabs">
          <el-radio-group v-model="myStatus" @change="loadMyCoupons">
            <el-radio-button :value="0">未使用</el-radio-button>
            <el-radio-button :value="1">已使用</el-radio-button>
            <el-radio-button :value="2">已过期</el-radio-button>
          </el-radio-group>
        </div>

        <div v-if="myList.length > 0" class="coupon-list">
          <div
            v-for="coupon in myList"
            :key="coupon.id"
            class="coupon-card"
            :class="{ disabled: coupon.status !== 0 }"
          >
            <div class="coupon-left">
              <div class="coupon-value" v-if="coupon.discountType === 'PERCENT'">
                {{ (coupon.discountValue * 10).toFixed(1) }}<span class="unit">折</span>
              </div>
              <div class="coupon-value" v-else>
                <span class="unit">¥</span>{{ coupon.discountValue }}
              </div>
              <div class="coupon-type">
                {{ coupon.discountType === 'PERCENT' ? '折扣券' : '满减券' }}
              </div>
            </div>
            <div class="coupon-right">
              <div class="coupon-name">{{ coupon.name }}</div>
              <div class="coupon-condition">
                满¥{{ coupon.minAmount || 0 }}可用
                <span v-if="coupon.isStackable === 1" class="stackable-tag">可叠加</span>
              </div>
              <div class="coupon-time">
                {{ coupon.validStartTime }} ~ {{ coupon.validEndTime }}
              </div>
              <div class="coupon-status">
                <el-tag v-if="coupon.status === 0" type="success" size="small">未使用</el-tag>
                <el-tag v-else-if="coupon.status === 1" type="info" size="small">已使用</el-tag>
                <el-tag v-else type="warning" size="small">已过期</el-tag>
              </div>
            </div>
          </div>
        </div>
        <el-empty v-else description="暂无优惠券" />

        <!-- 分页 -->
        <div class="pagination" v-if="myTotal > myPageSize">
          <el-pagination
            v-model:current-page="myPage"
            :page-size="myPageSize"
            :total="myTotal"
            layout="prev, pager, next"
            @current-change="loadMyCoupons"
          />
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft } from '@element-plus/icons-vue'
import { getAvailableCoupons, receiveCoupon, getMyCoupons } from '@/api/coupon'

const router = useRouter()
const goBack = () => router.back()

const activeTab = ref('available')

// 领券中心
const availableList = ref([])
const claimingId = ref(null)

// 我的优惠券
const myList = ref([])
const myStatus = ref(0)
const myPage = ref(1)
const myPageSize = ref(10)
const myTotal = ref(0)

onMounted(() => {
  loadAvailable()
})

const handleTabChange = (tab) => {
  if (tab === 'mine') {
    myPage.value = 1
    loadMyCoupons()
  }
}

// 加载可领取优惠券
const loadAvailable = async () => {
  try {
    const res = await getAvailableCoupons()
    if (res.code === 1) {
      availableList.value = res.data || []
    }
  } catch (error) {
    console.error('加载优惠券失败', error)
  }
}

// 领取优惠券
const handleReceive = async (id) => {
  claimingId.value = id
  try {
    const res = await receiveCoupon(id)
    if (res.code === 1) {
      ElMessage.success('领取成功！')
      // 刷新列表，更新已领取状态
      await loadAvailable()
    } else {
      ElMessage.error(res.msg || '领取失败')
    }
  } catch (error) {
    if (error.response && error.response.data) {
      ElMessage.error(error.response.data.msg || '领取失败')
    } else {
      ElMessage.error('领取失败')
    }
  } finally {
    claimingId.value = null
  }
}

// 加载我的优惠券
const loadMyCoupons = async () => {
  try {
    const res = await getMyCoupons({
      status: myStatus.value,
      page: myPage.value,
      pageSize: myPageSize.value
    })
    if (res.code === 1) {
      myList.value = res.data.records || []
      myTotal.value = res.data.total || 0
    }
  } catch (error) {
    console.error('加载我的优惠券失败', error)
  }
}
</script>

<style scoped>
.coupons-container {
  min-height: 100vh;
  background: #f5f5f5;
  padding: 20px;
}

.page-header {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 20px;
}

.page-header h2 {
  margin: 0;
}

.status-tabs {
  margin-bottom: 15px;
}

.coupon-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.coupon-card {
  display: flex;
  background: white;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  transition: all 0.3s;
}

.coupon-card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.coupon-card.claimed {
  opacity: 0.6;
}

.coupon-card.disabled {
  opacity: 0.5;
  filter: grayscale(0.5);
}

.coupon-left {
  width: 110px;
  background: linear-gradient(135deg, #ff6b6b, #ff8e53);
  color: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 15px 10px;
  position: relative;
}

.coupon-left::after {
  content: '';
  position: absolute;
  right: -6px;
  top: 50%;
  transform: translateY(-50%);
  width: 12px;
  height: 12px;
  background: #f5f5f5;
  border-radius: 50%;
  box-shadow: inset -12px 0 0 -6px #f5f5f5, inset 0 -12px 0 -6px #f5f5f5;
}

.coupon-card.disabled .coupon-left {
  background: linear-gradient(135deg, #999, #bbb);
}

.coupon-value {
  font-size: 28px;
  font-weight: bold;
  line-height: 1;
}

.coupon-value .unit {
  font-size: 14px;
  font-weight: normal;
}

.coupon-type {
  font-size: 12px;
  margin-top: 8px;
  opacity: 0.9;
}

.coupon-right {
  flex: 1;
  padding: 12px 15px;
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.coupon-name {
  font-size: 16px;
  font-weight: bold;
  color: #333;
}

.coupon-desc {
  font-size: 12px;
  color: #999;
}

.coupon-condition {
  font-size: 13px;
  color: #666;
}

.stackable-tag {
  display: inline-block;
  background: #fff7e6;
  color: #ff9800;
  font-size: 11px;
  padding: 1px 6px;
  border-radius: 4px;
  margin-left: 6px;
}

.coupon-time {
  font-size: 12px;
  color: #999;
}

.coupon-stock {
  font-size: 12px;
  color: #ff6b6b;
}

.coupon-right .el-button {
  align-self: flex-start;
  margin-top: 5px;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}
</style>
