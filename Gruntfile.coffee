LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)


# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt) ->

  # show elapsed time at the end
  require("time-grunt") grunt

  # load all grunt tasks
  require("load-grunt-tasks") grunt

  # configurable paths
  cfg =
    app: ""
    tmp: '.tmp'

  grunt.initConfig
    cfg: cfg
    watch:

      livereload:
        options:
          livereload: LIVERELOAD_PORT

        files: [
          "<%= cfg.app %>/*.html"
          "<%= cfg.app %>/{,*/}{,*/}{,*/}*.css"
          "<%= cfg.app %>/{,*/}{,*/}{,*/}*.js"
        ]

    connect:
      options:
        port: 3001
        hostname: "0.0.0.0"

      livereload:
        options:
          keepalive: true
          livereload: LIVERELOAD_PORT
          middleware: (connect) ->
            [
              lrSnippet
              mountFolder(connect, cfg.tmp)
              mountFolder(connect, cfg.app)
            ]


    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"


  # --------------------------------- Server Tasks
  grunt.registerTask "server", [
    "open"
    "connect:livereload"
  ]


  # --------------------------------- Build Tasks


  grunt.registerTask "default", [ "server" ]
