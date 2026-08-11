<script lang="ts">
// Render function (decompiled from source map)
const __render__ = function(createElement) {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"navbar"},[_c('div',{staticClass:"statusBox"},[_c('hamburger',{staticClass:"hamburger-container",attrs:{"id":"hamburger-container","is-active":_vm.sidebar.opened},on:{"toggleClick":_vm.toggleSideBar}}),(_vm.status===1)?_c('span',{staticClass:"businessBtn"},[_vm._v("营业中")]):_c('span',{staticClass:"businessBtn closing"},[_vm._v("打烊中")])],1),_c('div',{key:_vm.restKey,staticClass:"right-menu"},[_c('div',{staticClass:"rightStatus"},[_c('audio',{ref:"audioVo",attrs:{"hidden":""}},[_c('source',{attrs:{"src":require("./../../../assets/preview.mp3"),"type":"audio/mp3"}})]),_c('audio',{ref:"audioVo2",attrs:{"hidden":""}},[_c('source',{attrs:{"src":require("./../../../assets/reminder.mp3"),"type":"audio/mp3"}})]),_c('span',{staticClass:"navicon operatingState",on:{"click":_vm.handleStatus}},[_c('i'),_vm._v("营业状态设置")])]),_c('div',{staticClass:"avatar-wrapper"},[_c('div',{class:_vm.shopShow?'userInfo':'',on:{"mouseenter":_vm.toggleShow,"mouseleave":_vm.mouseLeaves}},[_c('el-button',{class:_vm.shopShow?'active':'',attrs:{"type":"primary"}},[_vm._v("\n          "+_vm._s(_vm.name)),_c('i',{staticClass:"el-icon-arrow-down"})]),(_vm.shopShow)?_c('div',{staticClass:"userList"},[_c('p',{staticClass:"outLogin",on:{"click":_vm.logout}},[_vm._v("\n            退出登录"),_c('i')])]):_vm._e()],1)])]),_c('el-dialog',{attrs:{"title":"营业状态设置","visible":_vm.dialogVisible,"width":"480px","show-close":false,"modal":false},on:{"update:visible":function($event){_vm.dialogVisible=$event}}},[_c('el-radio-group',{model:{value:(_vm.setStatus),callback:function ($$v) {_vm.setStatus=$$v},expression:"setStatus"}},[_c('el-radio',{attrs:{"label":1}},[_vm._v("\n        营业中\n        "),_c('span',[_vm._v("当前餐厅处于营业状态，自动接收任何订单，可点击打烊进入店铺打烊状态。")])]),_c('el-radio',{attrs:{"label":0}},[_vm._v("\n        打烊中\n        "),_c('span',[_vm._v("当前餐厅处于打烊状态，仅接受营业时间内的预定订单，可点击营业中手动恢复营业状态。")])])],1),_c('span',{staticClass:"dialog-footer",attrs:{"slot":"footer"},slot:"footer"},[_c('el-button',{on:{"click":function($event){_vm.dialogVisible = false}}},[_vm._v("取 消")]),_c('el-button',{attrs:{"type":"primary"},on:{"click":_vm.handleSave}},[_vm._v("确 定")])],1)],1)],1)}
const __staticRenderFns__ = []





















































































import { Component, Vue, Watch } from 'vue-property-decorator'
import { AppModule } from '@/store/modules/app'
import { UserModule } from '@/store/modules/user'
import Breadcrumb from '@/components/Breadcrumb/index.vue'
import Hamburger from '@/components/Hamburger/index.vue'
import { getStatus, setStatus } from '@/api/users'
import Cookies from 'js-cookie'
import { debounce, throttle } from '@/utils/common'
import { setNewData, getNewData } from '@/utils/cookies'

// 接口
import { getCountUnread } from '@/api/inform'

@Component({ name: 'Navbar',
  components: {
    Breadcrumb,
    Hamburger,
  }, render: __render__, staticRenderFns: __staticRenderFns__ })
export default class extends Vue {
  private storeId = this.getStoreId
  private restKey: number = 0
  private websocket = null
  private newOrder = ''
  private message = ''
  private audioIsPlaying = false
  private audioPaused = false
  private statusValue = true
  private audioUrl: './../../../assets/preview.mp3'
  private shopShow = false
  private dialogVisible = false
  private status = 1
  private setStatus = 1
  private ountUnread = 0
  private hideTimeout: any = null
  // get ountUnread() {
  //   return Number(getNewData())
  // }
  get sidebar() {
    return AppModule.sidebar
  }

  get device() {
    return AppModule.device.toString()
  }

  getuserInfo() {
    return UserModule.userInfo
  }

  get name() {
    return (UserModule.userInfo as any).name
      ? (UserModule.userInfo as any).name
      : JSON.parse(Cookies.get('user_info') as any).name
  }

  get getStoreId() {
    let storeId = ''
    if (UserModule.storeId) {
      storeId = UserModule.storeId
    } else if ((UserModule.userInfo as any).stores != null) {
      storeId = (UserModule.userInfo as any).stores[0].storeId
    }
    return storeId
  }
  mounted() {
    document.addEventListener('click', this.handleClose)
    //console.log(this.$store.state.app.statusNumber)
    // const msg = {
    //   data: {
    //     type: 2,
    //     content: '订单1653904906519客户催单，已下单23分钟，仍未接单。',
    //     details: '434'
    //   }
    // }
    this.getStatus()
  }
  created() {
    this.webSocket()
  }
  onload() {
  }
  destroyed() {
    this.websocket.close() //离开路由之后断开websocket连接
  }

  // 添加新订单提示弹窗
  webSocket() {
    const that = this as any
    let clientId = Math.random().toString(36).substr(2)
    let socketUrl = 'ws://localhost:8888/ws/' + clientId
    console.log(socketUrl, 'socketUrl')
    if (typeof WebSocket == 'undefined') {
      that.$notify({
        title: '提示',
        message: '当前浏览器无法接收实时报警信息，请使用谷歌浏览器！',
        type: 'warning',
        duration: 0,
      })
    } else {
      this.websocket = new WebSocket(socketUrl)
      // 监听socket打开
      this.websocket.onopen = function () {
        console.log('浏览器WebSocket已打开')
      }
      // 监听socket消息接收
      this.websocket.onmessage = function (msg) {
        // 转换为json对象
        that.$refs.audioVo.currentTime = 0
        that.$refs.audioVo2.currentTime = 0

        console.log(msg, JSON.parse(msg.data), 'msg')
        // const h = this.$createElement
        const jsonMsg = JSON.parse(msg.data)
        if (jsonMsg.type === 1) {
          that.$refs.audioVo.play()
        } else if (jsonMsg.type === 2) {
          that.$refs.audioVo2.play()
        } else if (jsonMsg.type === 3) {
          // 用户取消订单，播放提示音
          that.$refs.audioVo2.play()
        }
        that.$notify({
          title: jsonMsg.type === 1 ? '待接单' : (jsonMsg.type === 2 ? '催单' : '订单取消'),
          duration: 0,
          dangerouslyUseHTMLString: true,
          onClick: () => {
            that.$router
              .push(`/order?orderId=${jsonMsg.orderId}`)
              .catch((err) => {
                console.log(err)
              })
            setTimeout(() => {
              location.reload()
            }, 100)
          },
          // 这里也可以把返回信息加入到message中显示
          message: `${
            jsonMsg.type === 1
              ? `<span>您有1个<span style=color:#419EFF>订单待处理</span>,${jsonMsg.content},请及时接单</span>`
              : (jsonMsg.type === 2 
                ? `${jsonMsg.content}<span style='color:#419EFF;cursor: pointer'>去处理</span>`
                : `<span>用户取消了订单，${jsonMsg.content}</span>`)
          }`,
        })
      }
      // 监听socket错误
      this.websocket.onerror = function () {
        that.$notify({
          title: '错误',
          message: '服务器错误，无法接收实时报警信息',
          type: 'error',
          duration: 0,
        })
      }
      // 监听socket关闭
      this.websocket.onclose = function () {
        console.log('WebSocket已关闭')
      }
    }
  }

  private toggleSideBar() {
    AppModule.ToggleSideBar(false)
  }
  // 退出
  private async logout() {
    this.$store.dispatch('LogOut').then(() => {
      // location.href = '/'
      this.$router.replace({ path: '/login' })
    })
    // this.$router.push(`/login?redirect=${this.$route.fullPath}`)
  }
  // 获取未读消息
  async getCountUnread() {
    const { data } = await getCountUnread()
    if (data.code === 1) {
      // this.ountUnread = data.data
      AppModule.StatusNumber(data.data)
      // setNewData(data.data)
      // this.$message.success('操作成功！')
    } else {
      this.$message.error(data.msg)
    }
  }
  // 营业状态
  async getStatus() {
    const { data } = await getStatus()
    this.status = data.data
    this.setStatus = this.status
  }
  // 下拉菜单显示
  toggleShow() {
    if (this.hideTimeout) {
      clearTimeout(this.hideTimeout)
      this.hideTimeout = null
    }
    this.shopShow = true
  }
  // 下拉菜单隐藏
  mouseLeaves() {
    this.hideTimeout = setTimeout(() => {
      this.shopShow = false
    }, 300)
  }
  // 触发空白处下来菜单关闭
  handleClose() {
    // clearTimeout(this.leave)
    // this.shopShow = false
  }
  // 设置营业状态
  handleStatus() {
    this.dialogVisible = true
  }
  // 营业状态设置
  async handleSave() {
    const { data } = await setStatus(this.setStatus)
    if (data.code === 1) {
      this.dialogVisible = false
      this.getStatus()
    }
  }
}
</script>
