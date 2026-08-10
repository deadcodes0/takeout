<template>
  <div class="favorites-container">
    <!-- 页面头部 -->
    <div class="page-header">
      <el-button @click="goBack" :icon="ArrowLeft" circle></el-button>
      <h2>收藏菜品</h2>
    </div>

    <!-- 收藏列表 -->
    <div v-if="favoriteList.length > 0" class="favorite-grid">
      <div
        v-for="item in favoriteList"
        :key="item.id"
        class="favorite-item"
      >
        <img :src="item.image" :alt="item.name" class="favorite-image" />
        <div class="favorite-info">
          <h4>{{ item.name }}</h4>
          <p class="favorite-desc">{{ item.description || item.name }}</p>
          <div class="favorite-price-row">
            <span class="favorite-price">¥{{ item.price?.toFixed(2) }}</span>
            <div class="favorite-actions">
              <el-button
                type="danger"
                size="small"
                @click="handleRemoveFavorite(item)"
              >
                取消收藏
              </el-button>
              <el-button
                type="primary"
                size="small"
                @click="handleAddToCart(item)"
              >
                加入购物车
              </el-button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <el-empty v-else description="暂无收藏的菜品" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ArrowLeft } from '@element-plus/icons-vue'
import { getFavoriteList, removeFavoriteById, addFavorite, removeFavorite } from '@/api/favorite'
import { addShoppingCart } from '@/api/shoppingCart'

const router = useRouter()
const favoriteList = ref([])

// 返回个人中心
const goBack = () => {
  router.push('/profile')
}

// 加载收藏列表
const loadFavorites = async () => {
  try {
    const res = await getFavoriteList()
    if (res.code === 1) {
      favoriteList.value = res.data || []
    }
  } catch (error) {
    console.error('加载收藏列表失败', error)
  }
}

// 取消收藏
const handleRemoveFavorite = async (item) => {
  try {
    await ElMessageBox.confirm('确定取消收藏该菜品吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })

    await removeFavoriteById(item.id)
    ElMessage.success('已取消收藏')
    await loadFavorites()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('取消收藏失败')
    }
  }
}

// 加入购物车
const handleAddToCart = async (item) => {
  try {
    const data = {}
    if (item.dishId && item.dishId !== -1) {
      data.dishId = item.dishId
    }
    if (item.setmealId && item.setmealId !== -1) {
      data.setmealId = item.setmealId
    }
    await addShoppingCart(data)
    ElMessage.success('已加入购物车')
  } catch (error) {
    ElMessage.error('添加失败')
  }
}

onMounted(async () => {
  await loadFavorites()
})
</script>

<style scoped>
.favorites-container {
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

.favorite-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(305px, 1fr));
  gap: 15px;
}

.favorite-item {
  display: flex;
  background: white;
  border-radius: 8px;
  padding: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s;
  weight:20px;
}

.favorite-item:hover {
  transform: translateY(-2px);
}

.favorite-image {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 8px;
  margin-right: 10px;
}

.favorite-info {
  flex: 1;
}

.favorite-info h4 {
  margin: 0 0 5px 0;
  font-size: 16px;
}

.favorite-desc {
  color: #999;
  font-size: 12px;
  margin: 5px 0;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.favorite-price-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
}

.favorite-price {
  color: #ff6b6b;
  font-size: 18px;
  font-weight: bold;
}

.favorite-actions {
  display: flex;
  gap: 5px;
}
</style>