<template>
  <div class="dashboard-container">
    <div class="container">
      <!-- 顶部操作栏 -->
      <div class="tableBar">
        <el-button type="primary" @click="openAddDialog">+ 新建优惠券</el-button>
        <el-button @click="init">刷新</el-button>
      </div>

      <!-- 列表 -->
      <el-table :data="tableData" stripe class="tableBox" v-if="tableData.length">
        <el-table-column prop="name" label="券名称" min-width="120" />
        <el-table-column label="优惠类型" width="100">
          <template slot-scope="scope">
            <el-tag :type="scope.row.discountType === 'PERCENT' ? 'warning' : 'success'" size="small">
              {{ scope.row.discountType === 'PERCENT' ? '折扣' : '满减' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="优惠值" width="120">
          <template slot-scope="scope">
            <span v-if="scope.row.discountType === 'PERCENT'">
              {{ (scope.row.discountValue * 10).toFixed(1) }}折
            </span>
            <span v-else>¥{{ scope.row.discountValue }}</span>
          </template>
        </el-table-column>
        <el-table-column label="使用门槛" width="100">
          <template slot-scope="scope">
            满¥{{ scope.row.minAmount || 0 }}
          </template>
        </el-table-column>
        <el-table-column label="有效期" min-width="300">
          <template slot-scope="scope">
            {{ scope.row.validStartTime }} ~ {{ scope.row.validEndTime }}
          </template>
        </el-table-column>
        <el-table-column label="库存" width="100">
          <template slot-scope="scope">
            {{ scope.row.remainingStock }} / {{ scope.row.totalStock }}
          </template>
        </el-table-column>
        <el-table-column label="限领" width="70" prop="perUserLimit" />
        <el-table-column label="状态" width="80">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === 1 ? 'success' : 'info'" size="small">
              {{ scope.row.status === 1 ? '启用' : '停用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="160" />
      </el-table>
      <el-empty v-else description="暂无优惠券" />

      <!-- 分页 -->
      <el-pagination
        v-if="counts > pageSize"
        class="pageList"
        :page-sizes="[10, 20, 30, 40]"
        :page-size="pageSize"
        :total="counts"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>

    <!-- 新建优惠券弹窗 -->
    <el-dialog title="新建优惠券" :visible.sync="dialogVisible" width="600px" :before-close="handleClose">
      <el-form ref="couponForm" :model="form" :rules="rules" label-width="120px" class="coupon-form">
        <el-form-item label="券名称" prop="name">
          <el-input v-model="form.name" placeholder="如：满30减5" maxlength="50" />
        </el-form-item>

        <el-form-item label="优惠类型" prop="discountType">
          <el-radio-group v-model="form.discountType">
            <el-radio label="FIXED">满减（固定金额）</el-radio>
            <el-radio label="PERCENT">折扣</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item :label="form.discountType === 'PERCENT' ? '折扣率' : '优惠金额'" prop="discountValue">
          <el-input-number
            v-model="form.discountValue"
            :min="0"
            :step="form.discountType === 'PERCENT' ? 0.05 : 1"
            :precision="form.discountType === 'PERCENT' ? 2 : 2"
            :placeholder="form.discountType === 'PERCENT' ? '0.85表示打85折' : '5表示减5元'"
          />
          <span class="form-tip" v-if="form.discountType === 'PERCENT'">
            （0.85 = 85折，优惠15%）
          </span>
          <span class="form-tip" v-else>（元）</span>
        </el-form-item>

        <el-form-item v-if="form.discountType === 'PERCENT'" label="最大优惠上限">
          <el-input-number v-model="form.maxDiscountAmount" :min="0" :precision="2" placeholder="留空则不限" />
          <span class="form-tip">（元，折扣券最大可优惠金额）</span>
        </el-form-item>

        <el-form-item label="使用门槛" prop="minAmount">
          <el-input-number v-model="form.minAmount" :min="0" :precision="2" />
          <span class="form-tip">（满此金额方可使用）</span>
        </el-form-item>

        <el-form-item label="是否可叠加">
          <el-switch v-model="form.isStackable" :active-value="1" :inactive-value="0" />
          <span class="form-tip">（允许多张券同时使用）</span>
        </el-form-item>

        <el-form-item label="总发行量" prop="totalStock">
          <el-input-number v-model="form.totalStock" :min="1" :step="10" />
        </el-form-item>

        <el-form-item label="每人限领" prop="perUserLimit">
          <el-input-number v-model="form.perUserLimit" :min="1" />
          <span class="form-tip">（张）</span>
        </el-form-item>

        <el-form-item label="有效期开始" prop="validStartTime">
          <el-date-picker
            v-model="form.validStartTime"
            type="datetime"
            placeholder="选择开始时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            style="width: 100%"
          />
        </el-form-item>

        <el-form-item label="有效期结束" prop="validEndTime">
          <el-date-picker
            v-model="form.validEndTime"
            type="datetime"
            placeholder="选择结束时间"
            value-format="yyyy-MM-dd HH:mm:ss"
            style="width: 100%"
          />
        </el-form-item>

        <el-form-item label="描述">
          <el-input v-model="form.description" type="textarea" :rows="2" placeholder="优惠券描述（可选）" />
        </el-form-item>

        <el-form-item label="状态">
          <el-switch v-model="form.status" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="停用" />
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" :loading="submitting" @click="submitForm">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import { getCouponPage, addCoupon } from '@/api/coupon'

@Component({ name: 'Coupon' })
export default class extends Vue {
  private tableData: any[] = []
  private counts: number = 0
  private page: number = 1
  private pageSize: number = 10
  private dialogVisible: boolean = false
  private submitting: boolean = false

  private form: any = {
    name: '',
    discountType: 'FIXED',
    discountValue: 0,
    maxDiscountAmount: null,
    minAmount: 0,
    isStackable: 0,
    totalStock: 100,
    perUserLimit: 1,
    validStartTime: '',
    validEndTime: '',
    description: '',
    status: 1
  }

  get rules() {
    return {
      name: [{ required: true, message: '请输入券名称', trigger: 'blur' }],
      discountType: [{ required: true, message: '请选择优惠类型', trigger: 'change' }],
      discountValue: [{ required: true, message: '请输入优惠值', trigger: 'blur' }],
      minAmount: [{ required: true, message: '请输入使用门槛', trigger: 'blur' }],
      totalStock: [{ required: true, message: '请输入总发行量', trigger: 'blur' }],
      perUserLimit: [{ required: true, message: '请输入每人限领张数', trigger: 'blur' }],
      validStartTime: [{ required: true, message: '请选择有效期开始时间', trigger: 'change' }],
      validEndTime: [{ required: true, message: '请选择有效期结束时间', trigger: 'change' }]
    }
  }

  $refs!: { couponForm: any }

  created() {
    this.init()
  }

  private async init() {
    try {
      const res = await getCouponPage({ page: this.page, pageSize: this.pageSize })
      if (String(res.data.code) === '1') {
        this.tableData = res.data.data.records || []
        this.counts = Number(res.data.data.total)
      } else {
        this.$message.error(res.data.msg || '查询失败')
      }
    } catch (err: any) {
      this.$message.error('请求出错了：' + err.message)
    }
  }

  private openAddDialog() {
    this.form = {
      name: '',
      discountType: 'FIXED',
      discountValue: 0,
      maxDiscountAmount: null,
      minAmount: 0,
      isStackable: 0,
      totalStock: 100,
      perUserLimit: 1,
      validStartTime: '',
      validEndTime: '',
      description: '',
      status: 1
    }
    this.dialogVisible = true
  }

  private handleClose() {
    this.dialogVisible = false
    this.$refs.couponForm.resetFields()
  }

  private submitForm() {
    this.$refs.couponForm.validate(async (valid: boolean) => {
      if (!valid) return
      // 校验时间
      if (this.form.validEndTime <= this.form.validStartTime) {
        this.$message.error('有效期结束时间必须晚于开始时间')
        return
      }
      // PERCENT 类型校验折扣率范围
      if (this.form.discountType === 'PERCENT') {
        if (this.form.discountValue <= 0 || this.form.discountValue >= 1) {
          this.$message.error('折扣率必须在 0~1 之间（如 0.85 表示85折）')
          return
        }
      }
      this.submitting = true
      try {
        const res = await addCoupon(this.form)
        if (String(res.data.code) === '1') {
          this.$message.success('优惠券创建成功')
          this.dialogVisible = false
          this.$refs.couponForm.resetFields()
          this.init()
        } else {
          this.$message.error(res.data.msg || '创建失败')
        }
      } catch (err: any) {
        this.$message.error('请求出错了：' + err.message)
      } finally {
        this.submitting = false
      }
    })
  }

  private handleSizeChange(val: number) {
    this.pageSize = val
    this.init()
  }

  private handleCurrentChange(val: number) {
    this.page = val
    this.init()
  }
}
</script>

<style scoped>
.tableBar {
  margin-bottom: 20px;
}
.tableBox {
  width: 100%;
}
.pageList {
  margin-top: 20px;
  text-align: right;
}
.coupon-form .form-tip {
  color: #999;
  font-size: 12px;
  margin-left: 8px;
}
</style>
