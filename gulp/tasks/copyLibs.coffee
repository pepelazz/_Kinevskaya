gulp = require("gulp")
config = require("../config").copyLibs

gulp.task "copyLibs", [], (->
  gulp.src("#{config.libs}/normalize/**").pipe(gulp.dest(config.dest + '/lib'));
  gulp.src("#{config.libs}/angular-1.3.8/angular.min.js").pipe(gulp.dest(config.dest + '/lib'));
  gulp.src("#{config.libs}/jquery-2.0.3/jquery-2.0.3.min.js").pipe(gulp.dest(config.dest + '/lib'));
  gulp.src("#{config.libs}/snabbt/snabbt.min.js").pipe(gulp.dest(config.dest + '/lib'));
  return)