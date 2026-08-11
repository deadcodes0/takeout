# Sky Admin - 外卖管理系统前端

基于 Vue 3 + Element Plus 的外卖管理系统前端项目

## 技术栈

- Vue 3
- Element Plus
- Vue Router
- Pinia
- Axios
- Vite

## 项目结构

```
sky-admin/
├── src/
│   ├── api/          # API 接口
│   ├── assets/       # 静态资源
│   ├── components/   # 公共组件
│   ├── router/       # 路由配置
│   ├── store/        # 状态管理
│   ├── utils/        # 工具函数
│   ├── views/        # 页面组件
│   ├── App.vue       # 根组件
│   └── main.js       # 入口文件
├── index.html        # HTML 模板
├── vite.config.js    # Vite 配置
└── package.json      # 项目配置
```

## 安装依赖

```bash
npm install
```

## 启动开发服务器

```bash
npm run dev
```

## 构建生产版本

```bash
npm run build
```

## 预览生产版本

```bash
npm run preview
```

## 功能特性

- 用户登录/登出
- JWT Token 认证
- 路由权限控制
- API 请求封装
- 响应式布局

## 后端接口

项目配置了代理，将 `/api` 开头的请求代理到 `http://localhost:8081`

如需修改后端地址，请编辑 `vite.config.js` 中的 `proxy` 配置