module.exports = {
  publicPath: './',
  outputDir: 'dist',
  assetsDir: 'static',
  lintOnSave: false,
  productionSourceMap: true,
  devServer: {
    port: 8081,
    open: true,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        pathRewrite: {
          '^/api': '/admin'
        }
      }
    }
  },
  // 禁用 TypeScript 类型检查以加快编译速度
  chainWebpack: config => {
    // 完全移除 fork-ts-checker 插件
    config.plugins.delete('fork-ts-checker')
  }
}
