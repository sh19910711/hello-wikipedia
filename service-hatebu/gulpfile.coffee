gulp = require("gulp")

gulp.task "sass", ->
  sass = require("gulp-sass")
  concat = require("gulp-concat")
  gulp.src ["src/sass/*.sass"]
    .pipe sass
      indentedSyntax: true
    .pipe concat("style.css")
    .pipe gulp.dest("public/css/")

gulp.task "bower", (done)->
  bower = require("bower")
  bower.commands.install().on "end", ->
    done()
  undefined

gulp.task "webpack", ["bower"], ->
  webpack = require("gulp-webpack")
  concat = require("gulp-concat")

  _ = require("lodash")
  webpackConfig = require("./config/webpack")

  gulp.src ["src/coffee/**/*.coffee"]
    .pipe webpack(webpackConfig)
    .pipe concat("script.js")
    .pipe gulp.dest("public/js/")

gulp.task "watch", ->
  gulp.watch ["src/sass/*.sass"], ["sass"]
  gulp.watch ["src/coffee/**/*.coffee"], ["webpack"]

