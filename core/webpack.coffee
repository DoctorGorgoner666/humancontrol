path                 = require 'path'
webpack              = require 'webpack'
webpackDevMiddleware = require 'webpack-dev-middleware'
webpackHotMiddleware = require 'webpack-hot-middleware'
ExtractTextPlugin    = require 'extract-text-webpack-plugin'
stylusLoader         = ExtractTextPlugin.extract "style-loader", "css-loader!stylus-loader"

root = process.env.PWD

compiler = webpack(
  context: root + "/build"
  entry: {
    app: "./app/app.coffee"
    admin: "./admin/admin.coffee"
  }
  output:
    path: path.resolve("../public"),
    filename: '[name].js'
    # library: '[name]'
  watch: true
  devtool: "source-map"
  module:
    # preLoaders: [
    #     test: /\.coffee$/
    #     loader: 'coffeelint'
    # ]
    loaders: [
        test: /\.coffee$/
        loader: 'coffee'
    ,
        test: /\.styl$/
        loader: stylusLoader
    ,
        test: /\.tag$/
        loader: 'tag'
    ,
        test: /\.less$/
        loader: "style!css!less"
    ,
        include: /\.json$/
        loader: "json-loader"
    ]
  resolve:
    extensions:
      ['', '.coffee', '.js', '.styl', '.tag', '.json', '.jsx']
    alias:
      "jquery": root + "/public/js/lib/jquery-2.1.4.min"
      "socketsio": root +  "/public/js/lib/socket.io-1.3.7"
  plugins: [
      new webpack.optimize.CommonsChunkPlugin({name: 'common'})
      new webpack.EnvironmentPlugin('NODE_ENV')
      new webpack.NoErrorsPlugin()
      new ExtractTextPlugin("[name].css")
      new webpack.optimize.UglifyJsPlugin({
        compress: {
          warnings: false
        }
      })
      new webpack.ContextReplacementPlugin(/moment[\/\\]locale$/, /ru/)
      new webpack.ContextReplacementPlugin(/redux/)
      new webpack.ContextReplacementPlugin(/socket/)
    ]
)

module.exports.DevMiddleware = webpackDevMiddleware(compiler, {
  #  It suppress error shown in console, so it has to be set to false.
  quiet: false
  #  It suppress everything except error, so it has to be set to false as well
  #  to see success build.
  noInfo: true
  stats:
    #  Config for minimal console.log mess.
    assets: false
    colors: true
    version: true
    hash: true
    timings: true
    chunks: false
    chunkModules: true
    reasons: true
})
module.exports.HotMiddleware = webpackHotMiddleware(compiler, {
  log: console.log
})
