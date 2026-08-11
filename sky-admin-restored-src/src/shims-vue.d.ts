import Vue from 'vue'
import { VueRouter, Route } from 'vue-router'

declare module '*.vue' {
  export default Vue
}

// 扩展 Vue 类型
declare module 'vue/types/vue' {
  interface Vue {
    $message: {
      success: (msg: string) => void
      error: (msg: string) => void
      warning: (msg: string) => void
      info: (msg: string) => void
    }
    $confirm: (msg: string, title: string, options?: any) => Promise<any>
    $alert: (msg: string, title: string, options?: any) => Promise<any>
    $prompt: (msg: string, title: string, options?: any) => Promise<any>
    $notify: {
      success: (msg: string) => void
      error: (msg: string) => void
      warning: (msg: string) => void
      info: (msg: string) => void
    }
    $loading: {
      service: (options?: any) => { close: () => void }
    }
    $router: VueRouter
    $route: Route
    $echarts: any
    moment: any
    $checkProcessEnv: () => boolean
    $nextTick: (callback?: () => void) => Promise<void>
    $forceUpdate: () => void
    $set: (obj: any, key: string, value: any) => void
    $emit: (event: string, ...args: any[]) => void
  }
}

// 扩展 vue-class-component 类型
declare module 'vue-class-component/lib/types' {
  import Vue from 'vue'
  interface Vue extends Vue {
    $message: {
      success: (msg: string) => void
      error: (msg: string) => void
      warning: (msg: string) => void
      info: (msg: string) => void
    }
    $confirm: (msg: string, title: string, options?: any) => Promise<any>
    $alert: (msg: string, title: string, options?: any) => Promise<any>
    $prompt: (msg: string, title: string, options?: any) => Promise<any>
    $notify: {
      success: (msg: string) => void
      error: (msg: string) => void
      warning: (msg: string) => void
      info: (msg: string) => void
    }
    $loading: {
      service: (options?: any) => { close: () => void }
    }
    $router: VueRouter
    $route: Route
    $echarts: any
    moment: any
    $checkProcessEnv: () => boolean
    $nextTick: (callback?: () => void) => Promise<void>
    $forceUpdate: () => void
    $set: (obj: any, key: string, value: any) => void
    $emit: (event: string, ...args: any[]) => void
    $refs: {
      [key: string]: Vue | Element | Vue[] | Element[]
    }
  }
}

declare module 'vue-svgicon' {
  const SvgIcon: any
  export default SvgIcon
}

declare module 'vue-area-linkage' {
  const VueAreaLinkage: any
  export default VueAreaLinkage
}

declare module 'vue-area-linkage/dist/index.css'

declare module 'normalize.css'

declare module 'nprogress/nprogress.css'

declare module 'vue-property-decorator' {
  export { Component, Vue, Watch, Prop, Emit, Provide, Inject, Model } from 'vue-class-component'
}

declare module 'vuex-module-decorators' {
  export { VuexModule, Module, Action, Mutation, getModule } from 'vuex-module-decorators'
}