webpack = require("webpack")
path = require("path")

webpackPlugins = []

webpackPlugins.push new webpack.ResolverPlugin [
  new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin "bower.json", ["main"]
]

webpackPlugins.push new webpack.optimize.UglifyJsPlugin
  compress:
    warnings: false

module.exports =
  
  resolve:
    root: [
      path.join(__dirname, "../bower_components")
      path.join(__dirname, "../src/coffee")
    ]

    extensions: [
      ""
      ".coffee"
      ".js"
    ]

  externals:
    "jquery": "jQuery"

  output:
    filename: "[name].js"
    path: path.join(__dirname, "..", "public/js/")
    publicPath: "/js/"

  module:
    loaders: [
      { test: /\.coffee$/, loader: "coffee" }
    ]

  plugins: webpackPlugins

