<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"upload-item"},[_c('el-upload',{ref:"uploadfiles",staticClass:"avatar-uploader",class:{ borderNone: _vm.imageUrl },attrs:{"accept":_vm.type,"action":"/api/common/upload","show-file-list":false,"on-success":_vm.handleAvatarSuccess,"on-remove":_vm.handleRemove,"on-error":_vm.handleError,"before-upload":_vm.beforeAvatarUpload,"headers":_vm.headers}},[(_vm.imageUrl)?_c('img',{staticClass:"avatar",attrs:{"src":_vm.imageUrl}}):_c('i',{staticClass:"el-icon-plus avatar-uploader-icon"}),(_vm.imageUrl)?_c('span',{staticClass:"el-upload-list__item-actions"},[_c('span',{staticClass:"el-upload-span",on:{"click":function($event){$event.stopPropagation();return _vm.oploadImgDel($event)}}},[_vm._v("\n        删除图片\n      ")]),_c('span',{staticClass:"el-upload-span"},[_vm._v(" 重新上传 ")])]):_vm._e()]),_c('p',{staticClass:"upload-tips"},[_vm._t("default")],2)],1)}
const __staticRenderFns__ = []





































import { Vue, Component, Prop, Watch } from 'vue-property-decorator'
import { baseUrl } from '@/config.json'
import { getToken } from '@/utils/cookies'
@Component({ name: 'UploadImage', render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  @Prop({ default: '.jpg,.jpeg,.png' }) type: string
  @Prop({ default: 2 }) size: number
  @Prop({ default: '' }) propImageUrl: string

  private headers = {
    token: getToken()
  }
  private imageUrl = ''
  handleRemove() {}

  @Watch('propImageUrl')
  private onChange(val) {
    this.imageUrl = val
  }

  handleError(err, file, fileList) {
    console.log(err, file, fileList, 'handleError')
    this.$message({
      message: '图片上传失败',
      type: 'error'
    })
  }

  handleAvatarSuccess(response: any, file: any, fileList: any) {
    // this.imageUrl = response.data
    // this.imageUrl = `http://172.17.2.120:8080/common/download?name=${response.data}`
    this.imageUrl = `${response.data}`
    // this.imageUrl = `${baseUrl}/common/download?name=${response.data}`

    this.$emit('imageChange', this.imageUrl)
  }

  oploadImgDel() {
    this.imageUrl = ''
    this.$emit('imageChange', this.imageUrl)
  }
  beforeAvatarUpload(file) {
    const isLt2M = file.size / 1024 / 1024 < this.size
    if (!isLt2M) {
      this.$message({
        message: `上传文件大小不能超过${this.size}M!`,
        type: 'error'
      })
      return false
    }
  }
}
</script>
