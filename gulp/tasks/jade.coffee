gulp = require("gulp")
browserSync = require("browser-sync")
handleErrors = require("../util/handleErrors")
jade = require('gulp-jade')
gulpif = require('gulp-if')
jadeData = require('../../src/html/data/data.json')
config = require("../config").jade

gulp.task "jade", (->
  return gulp.src(config.src)
  .pipe(gulpif(/[.]jade$/,  jade({locals: jadeData})))
  .on("error", handleErrors)
  .pipe(gulp.dest(config.dest))
  .pipe(browserSync.reload(stream: true)))














