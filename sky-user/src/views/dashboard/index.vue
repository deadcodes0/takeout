<template>
  <div class="home-container">
    <!-- 店铺信息 -->
    <div class="shop-info">
      <div class="shop-header">
        <div class="logo">
          <el-icon :size="40"><Shop /></el-icon>
        </div>
        <div class="shop-title">
          <h2>美味外卖</h2>
          <el-tag :type="shopStatus === 1 ? 'success' : 'danger'" size="small">
            {{ shopStatus === 1 ? '营业中' : '休息中' }}
          </el-tag>
        </div>
        <!-- 个人中心入口 -->
        <div class="user-entry">
          <el-button type="primary" :icon="User" @click="goToProfile" circle></el-button>
        </div>
      </div>
      <div class="shop-details">
        <span><el-icon><Money /></el-icon> 配送费6元</span>
      </div>
      <div class="shop-address">
        <p>美味餐厅为顾客打造专业的大众化美食外送餐饮</p>
        <p><el-icon><Location /></el-icon> 广西南宁市江南区星光大道</p>
      </div>
    </div>

    <!-- 分类和菜品列表 -->
    <div class="menu-container">
      <!-- 左侧分类 -->
      <div class="category-list">
        <el-menu
          :default-active="activeCategory"
          @select="handleCategorySelect"
          class="category-menu"
        >
          <el-menu-item
            v-for="category in categoryList"
            :key="category.id"
            :index="category.id.toString()"
          >
            {{ category.name }}
          </el-menu-item>
        </el-menu>
      </div>

      <!-- 右侧菜品列表 -->
      <div class="dish-list">
        <div v-if="dishList.length > 0" class="dish-grid">
          <div
            v-for="dish in dishList"
            :key="dish.id"
            class="dish-item"
            @click="showDishDetail(dish)"
          >
            <img :src="dish.image" :alt="dish.name" class="dish-image" />
            <div class="dish-info">
              <h4>{{ dish.name }}</h4>
              <p class="dish-desc">{{ dish.description || dish.name }}</p>
              <p class="dish-sales">月销量0</p>
              <div class="dish-price-row">
                <span class="dish-price">¥{{ dish.price.toFixed(2) }}</span>
                <div class="dish-actions">
                  <!-- 有口味选项 -->
                  <el-button
                    v-if="dish.flavors && dish.flavors.length > 0"
                    type="warning"
                    size="small"
                    @click.stop="showFlavorDialog(dish)"
                  >
                    选择规格
                  </el-button>
                  <!-- 无口味选项 -->
                  <div v-else class="quantity-control">
                    <el-button
                      v-if="getDishQuantity(dish.id, dish.isSetmeal) > 0"
                      type="danger"
                      size="small"
                      circle
                      @click.stop="decreaseDish(dish)"
                    >
                      <el-icon><Minus /></el-icon>
                    </el-button>
                    <span v-if="getDishQuantity(dish.id, dish.isSetmeal) > 0" class="quantity">
                      {{ getDishQuantity(dish.id, dish.isSetmeal) }}
                    </span>
                    <el-button
                      type="success"
                      size="small"
                      circle
                      @click.stop="increaseDish(dish)"
                    >
                      <el-icon><Plus /></el-icon>
                    </el-button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <el-empty v-else description="该分类下暂无菜品" />
      </div>
    </div>

    <!-- 购物车 -->
    <div class="cart-bar" :class="{ 'has-items': cartTotalQuantity > 0 }">
      <div class="cart-icon" @click="showCartDialog">
        <el-badge :value="cartTotalQuantity" :hidden="cartTotalQuantity === 0">
          <el-icon :size="30"><ShoppingCart /></el-icon>
        </el-badge>
        <span class="cart-price">¥{{ cartTotalPrice.toFixed(2) }}</span>
      </div>
      <el-button
        type="warning"
        :disabled="cartTotalQuantity === 0"
        @click="goToOrder"
      >
        去结算
      </el-button>
    </div>

    <!-- 菜品详情弹窗 -->
    <el-dialog
      v-model="dishDetailVisible"
      :title="currentDish?.name"
      width="400px"
    >
      <img
        v-if="currentDish"
        :src="currentDish.image"
        :alt="currentDish.name"
        style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px;"
      />
      <p v-if="currentDish" style="margin: 10px 0; color: #666;">
        {{ currentDish.description }}
      </p>
      <div style="display: flex; justify-content: space-between; align-items: center;">
        <span style="color: #ff6b6b; font-size: 20px; font-weight: bold;">
          ¥{{ currentDish?.price?.toFixed(2) }}
        </span>
        <div style="display: flex; align-items: center; gap: 10px;">
          <!-- 收藏按钮 -->
          <el-button
            :type="isCurrentDishFavorite ? 'warning' : 'default'"
            size="small"
            @click="toggleFavorite"
          >
            <el-icon>
              <StarFilled v-if="isCurrentDishFavorite" />
              <Star v-else />
            </el-icon>
            {{ isCurrentDishFavorite ? '已收藏' : '收藏' }}
          </el-button>
          <div class="quantity-control">
            <el-button
              v-if="getDishQuantity(currentDish?.id, currentDish?.isSetmeal) > 0"
              type="danger"
              size="small"
              circle
              @click="decreaseDish(currentDish)"
            >
              <el-icon><Minus /></el-icon>
            </el-button>
            <span v-if="getDishQuantity(currentDish?.id, currentDish?.isSetmeal) > 0">
              {{ getDishQuantity(currentDish?.id, currentDish?.isSetmeal) }}
            </span>
            <el-button
              type="success"
              size="small"
              circle
              @click="increaseDish(currentDish)"
            >
              <el-icon><Plus /></el-icon>
            </el-button>
          </div>
        </div>
      </div>
    </el-dialog>

    <!-- 口味选择弹窗 -->
    <el-dialog
      v-model="flavorDialogVisible"
      :title="flavorDish?.name"
      width="400px"
    >
      <div v-if="flavorDish">
        <div v-for="flavor in flavorDish.flavors" :key="flavor.name" style="margin-bottom: 15px;">
          <h4 style="margin-bottom: 10px;">{{ flavor.name }}</h4>
          <el-radio-group v-model="selectedFlavors[flavor.name]" size="small">
            <el-radio-button
              v-for="option in JSON.parse(flavor.value || '[]')"
              :key="option"
              :label="option"
            >
              {{ option }}
            </el-radio-button>
          </el-radio-group>
        </div>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
          <span style="color: #ff6b6b; font-size: 20px; font-weight: bold;">
            ¥{{ flavorDish.price.toFixed(2) }}
          </span>
          <el-button type="warning" @click="addToCartWithFlavor">
            加入购物车
          </el-button>
        </div>
      </div>
    </el-dialog>

    <!-- 购物车详情弹窗 -->
    <el-dialog v-model="cartDialogVisible" title="购物车" width="500px">
      <div v-if="cartList.length > 0">
        <el-button type="danger" size="small" @click="clearCart" style="margin-bottom: 15px;">
          清空购物车
        </el-button>
        <div v-for="item in cartList" :key="item.id" class="cart-item">
          <img :src="item.image" :alt="item.name" class="cart-item-image" />
          <div class="cart-item-info">
            <h4>{{ item.name }}</h4>
            <p v-if="item.dishFlavor" style="color: #999; font-size: 12px;">
              {{ item.dishFlavor }}
            </p>
            <span style="color: #ff6b6b;">¥{{ item.amount }}</span>
          </div>
          <div class="cart-item-actions">
            <el-button type="danger" size="small" circle @click.stop="decreaseCartItem(item)">
              <el-icon><Minus /></el-icon>
            </el-button>
            <span>{{ item.number }}</span>
            <el-button type="success" size="small" circle @click.stop="increaseCartItem(item)">
              <el-icon><Plus /></el-icon>
            </el-button>
          </div>
        </div>
      </div>
      <el-empty v-else description="购物车是空的" />
    </el-dialog>

    <!-- 店铺休息提示 -->
    <el-dialog
      v-model="shopClosedVisible"
      title="提示"
      width="300px"
      center
    >
      <p style="text-align: center; font-size: 16px;">本店已打烊，暂时无法点餐</p>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Location, Money, Clock, ShoppingCart, Plus, Minus, Shop, User, Star, StarFilled } from '@element-plus/icons-vue'
import { getCategoryList } from '@/api/category'
import { getDishList } from '@/api/dish'
import { getSetmealList } from '@/api/setmeal'
import { getShopStatus } from '@/api/shop'
import { addShoppingCart, getShoppingCartList, subShoppingCart, cleanShoppingCart } from '@/api/shoppingCart'
import { addFavorite, removeFavorite, checkFavorite } from '@/api/favorite'

const router = useRouter()

// 前往个人中心
const goToProfile = () => {
  router.push('/profile')
}

// 店铺状态
const shopStatus = ref(0)
const shopClosedVisible = ref(false)

// 分类列表
const categoryList = ref([])
const activeCategory = ref('')

// 菜品列表
const dishList = ref([])

// 购物车
const cartList = ref([])
const cartDialogVisible = ref(false)

// 菜品详情
const dishDetailVisible = ref(false)
const currentDish = ref(null)

// 口味选择
const flavorDialogVisible = ref(false)
const flavorDish = ref(null)
const selectedFlavors = ref({})

// 收藏状态
const isCurrentDishFavorite = ref(false)

// 计算购物车总价
const cartTotalPrice = computed(() => {
  return cartList.value.reduce((total, item) => total + item.amount * item.number, 0)
})

// 计算购物车总数量
const cartTotalQuantity = computed(() => {
  return cartList.value.reduce((total, item) => total + item.number, 0)
})

// 获取菜品在购物车中的数量
const getDishQuantity = (dishId, isSetmeal = false) => {
  if (isSetmeal) {
    const item = cartList.value.find(item => item.setmealId === dishId)
    return item ? item.number : 0
  } else {
    const item = cartList.value.find(item => item.dishId === dishId)
    return item ? item.number : 0
  }
}

// 初始化
onMounted(async () => {
  await loadShopStatus()
  await loadCategories()
  await loadCart()
})

// 加载店铺状态
const loadShopStatus = async () => {
  try {
    const res = await getShopStatus()
    if (res.code === 1) {
      shopStatus.value = res.data
    }
  } catch (error) {
    console.error('获取店铺状态失败', error)
  }
}

// 加载分类列表
const loadCategories = async () => {
  try {
    // 加载菜品分类
    const dishCategoryRes = await getCategoryList(1)
    // 加载套餐分类
    const setmealCategoryRes = await getCategoryList(2)
    
    // 合并分类列表
    const dishCategories = dishCategoryRes.code === 1 ? (dishCategoryRes.data || []) : []
    const setmealCategories = setmealCategoryRes.code === 1 ? (setmealCategoryRes.data || []) : []
    
    // 先显示菜品分类，再显示套餐分类
    categoryList.value = [...dishCategories, ...setmealCategories]
    
    if (categoryList.value.length > 0) {
      activeCategory.value = categoryList.value[0].id.toString()
      // 根据分类类型加载不同内容
      if (categoryList.value[0].type === 1) {
        await loadDishes(categoryList.value[0].id)
      } else {
        await loadSetmeals(categoryList.value[0].id)
      }
    }
  } catch (error) {
    console.error('加载分类失败', error)
  }
}

// 加载菜品列表
const loadDishes = async (categoryId) => {
  try {
    const res = await getDishList(categoryId)
    if (res.code === 1) {
      dishList.value = res.data || []
    }
  } catch (error) {
    console.error('加载菜品失败', error)
  }
}

// 加载套餐列表
const loadSetmeals = async (categoryId) => {
  try {
    const res = await getSetmealList(categoryId)
    if (res.code === 1) {
      // 套餐数据结构适配菜品列表显示
      dishList.value = (res.data || []).map(setmeal => ({
        ...setmeal,
        id: setmeal.id,
        name: setmeal.name,
        price: setmeal.price,
        image: setmeal.image,
        description: setmeal.description,
        isSetmeal: true // 标记为套餐
      }))
    }
  } catch (error) {
    console.error('加载套餐失败', error)
  }
}

// 加载购物车
const loadCart = async () => {
  try {
    const res = await getShoppingCartList()
    if (res.code === 1) {
      cartList.value = res.data || []
    }
  } catch (error) {
    console.error('加载购物车失败', error)
  }
}

// 选择分类
const handleCategorySelect = async (categoryId) => {
  activeCategory.value = categoryId
  // 找到当前选中的分类
  const category = categoryList.value.find(c => c.id.toString() === categoryId)
  if (category) {
    if (category.type === 1) {
      // 菜品分类，加载菜品
      await loadDishes(parseInt(categoryId))
    } else {
      // 套餐分类，加载套餐
      await loadSetmeals(parseInt(categoryId))
    }
  }
}

// 显示菜品详情
const showDishDetail = async (dish) => {
  currentDish.value = dish
  dishDetailVisible.value = true
  // 检查是否已收藏
  try {
    const res = await checkFavorite(dish.id, null)
    if (res.code === 1) {
      isCurrentDishFavorite.value = res.data
    }
  } catch (error) {
    console.error('检查收藏状态失败', error)
    isCurrentDishFavorite.value = false
  }
}

// 显示口味选择弹窗
const showFlavorDialog = (dish) => {
  flavorDish.value = dish
  selectedFlavors.value = {}
  // 初始化口味选择
  dish.flavors.forEach(flavor => {
    const options = JSON.parse(flavor.value || '[]')
    if (options.length > 0) {
      selectedFlavors.value[flavor.name] = options[0]
    }
  })
  flavorDialogVisible.value = true
}

// 添加到购物车（带口味）
const addToCartWithFlavor = async () => {
  if (shopStatus.value === 0) {
    shopClosedVisible.value = true
    return
  }

  try {
    const flavorStr = Object.values(selectedFlavors.value).join(',')
    await addShoppingCart({
      dishId: flavorDish.value.id,
      dishFlavor: flavorStr
    })
    ElMessage.success('已加入购物车')
    flavorDialogVisible.value = false
    await loadCart()
  } catch (error) {
    ElMessage.error('添加失败')
  }
}

// 增加菜品数量
const increaseDish = async (dish) => {
  if (shopStatus.value === 0) {
    shopClosedVisible.value = true
    return
  }

  try {
    // 判断是菜品还是套餐
    if (dish.isSetmeal) {
      await addShoppingCart({ setmealId: dish.id })
    } else {
      await addShoppingCart({ dishId: dish.id })
    }
    await loadCart()
  } catch (error) {
    ElMessage.error('添加失败')
  }
}

// 减少菜品数量
const decreaseDish = async (dish) => {
  try {
    // 判断是菜品还是套餐
    if (dish.isSetmeal) {
      await subShoppingCart({ setmealId: dish.id })
    } else {
      await subShoppingCart({ dishId: dish.id })
    }
    await loadCart()
  } catch (error) {
    ElMessage.error('减少失败')
  }
}

// 增加购物车商品数量
const increaseCartItem = async (item) => {
  try {
    // 后端会将不存在的ID设置为-1，前端需要过滤掉
    const data = {
      dishFlavor: item.dishFlavor
    }
    // 只有当ID存在且不为-1时才传递
    if (item.dishId && item.dishId !== -1) {
      data.dishId = item.dishId
    }
    if (item.setmealId && item.setmealId !== -1) {
      data.setmealId = item.setmealId
    }
    await addShoppingCart(data)
    await loadCart()
  } catch (error) {
    ElMessage.error('添加失败')
  }
}

// 减少购物车商品数量
const decreaseCartItem = async (item) => {
  try {
    // 后端会将不存在的ID设置为-1，前端需要过滤掉
    const data = {
      dishFlavor: item.dishFlavor
    }
    // 只有当ID存在且不为-1时才传递
    if (item.dishId && item.dishId !== -1) {
      data.dishId = item.dishId
    }
    if (item.setmealId && item.setmealId !== -1) {
      data.setmealId = item.setmealId
    }
    await subShoppingCart(data)
    await loadCart()
  } catch (error) {
    ElMessage.error('减少失败')
  }
}

// 清空购物车
const clearCart = async () => {
  try {
    await cleanShoppingCart()
    cartList.value = []
    ElMessage.success('已清空购物车')
    cartDialogVisible.value = false
  } catch (error) {
    ElMessage.error('清空失败')
  }
}

// 显示购物车详情
const showCartDialog = () => {
  cartDialogVisible.value = true
}

// 去结算
const goToOrder = () => {
  if (shopStatus.value === 0) {
    shopClosedVisible.value = true
    return
  }
  router.push('/order')
}

// 切换收藏状态
const toggleFavorite = async () => {
  if (!currentDish.value) return

  try {
    if (isCurrentDishFavorite.value) {
      // 取消收藏
      await removeFavorite({ dishId: currentDish.value.id })
      isCurrentDishFavorite.value = false
      ElMessage.success('已取消收藏')
    } else {
      // 添加收藏
      await addFavorite({ dishId: currentDish.value.id })
      isCurrentDishFavorite.value = true
      ElMessage.success('已收藏')
    }
  } catch (error) {
    ElMessage.error('操作失败')
  }
}
</script>

<style scoped>
.home-container {
  min-height: 100vh;
  background: #f5f5f5;
  padding-bottom: 60px;
}

.shop-info {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 20px;
  margin-bottom: 10px;
}

.shop-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 15px;
}

.logo {
  width: 60px;
  height: 60px;
  border-radius: 8px;
  margin-right: 15px;
  background: rgba(255, 255, 255, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
}

.shop-title {
  flex: 1;
}

.shop-title h2 {
  margin: 0 0 5px 0;
  font-size: 20px;
}

.user-entry {
  margin-left: 15px;
}

.shop-details {
  display: flex;
  gap: 20px;
  margin-bottom: 10px;
  font-size: 14px;
}

.shop-details span {
  display: flex;
  align-items: center;
  gap: 5px;
}

.shop-address p {
  margin: 5px 0;
  font-size: 12px;
}

.menu-container {
  display: flex;
  height: calc(100vh - 200px);
  background: white;
}

.category-list {
  width: 120px;
  background: #f8f8f8;
  overflow-y: auto;
}

.category-menu {
  border-right: none;
}

.category-menu .el-menu-item {
  height: 50px;
  line-height: 50px;
  text-align: center;
}

.dish-list {
  flex: 1;
  overflow-y: auto;
  padding: 10px;
}

.dish-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 15px;
}

.dish-item {
  display: flex;
  background: white;
  border-radius: 8px;
  padding: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: transform 0.2s;
}

.dish-item:hover {
  transform: translateY(-2px);
}

.dish-image {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 8px;
  margin-right: 10px;
}

.dish-info {
  flex: 1;
}

.dish-info h4 {
  margin: 0 0 5px 0;
  font-size: 16px;
}

.dish-desc {
  color: #999;
  font-size: 12px;
  margin: 5px 0;
}

.dish-sales {
  color: #999;
  font-size: 12px;
  margin: 5px 0;
}

.dish-price-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
}

.dish-price {
  color: #ff6b6b;
  font-size: 18px;
  font-weight: bold;
}

.dish-actions {
  display: flex;
  align-items: center;
}

.quantity-control {
  display: flex;
  align-items: center;
  gap: 5px;
}

.quantity {
  min-width: 20px;
  text-align: center;
}

.cart-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  height: 60px;
  background: #333;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
  z-index: 100;
}

.cart-bar.has-items {
  background: #333;
}

.cart-icon {
  display: flex;
  align-items: center;
  gap: 15px;
  color: white;
  cursor: pointer;
}

.cart-price {
  font-size: 18px;
  font-weight: bold;
}

.cart-item {
  display: flex;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid #eee;
}

.cart-item-image {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
  margin-right: 10px;
}

.cart-item-info {
  flex: 1;
}

.cart-item-info h4 {
  margin: 0;
  font-size: 14px;
}

.cart-item-actions {
  display: flex;
  align-items: center;
  gap: 5px;
}
</style>