gulp = require("gulp")

gulp.task "bower", (done)->
  bower = require("bower")
  bower.commands.install().on "end", ->
    done()
  undefined

gulp.task "webpack", ["bower"], ->
  webpack = require("gulp-webpack")
  concat = require("gulp-concat")
  webpackConfig = require("./config/webpack")
  gulp.src ["src/coffee/**/*.coffee"]
    .pipe webpack(webpackConfig)
    .pipe concat("script.js")
    .pipe gulp.dest("public/js/")
