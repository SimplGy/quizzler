// Generated by CoffeeScript 1.7.1
(function() {
  var LIVERELOAD_PORT, lrSnippet, mountFolder;

  LIVERELOAD_PORT = 35729;

  lrSnippet = require("connect-livereload")({
    port: LIVERELOAD_PORT
  });

  mountFolder = function(connect, dir) {
    return connect["static"](require("path").resolve(dir));
  };

  module.exports = function(grunt) {
    var cfg;
    require("time-grunt")(grunt);
    require("load-grunt-tasks")(grunt);
    cfg = {
      app: "",
      tmp: '.tmp'
    };
    grunt.initConfig({
      cfg: cfg,
      watch: {
        livereload: {
          options: {
            livereload: LIVERELOAD_PORT
          },
          files: ["<%= cfg.app %>/*.html", "<%= cfg.app %>/{,*/}{,*/}{,*/}*.css", "<%= cfg.app %>/{,*/}{,*/}{,*/}*.js"]
        }
      },
      connect: {
        options: {
          port: 3001,
          hostname: "0.0.0.0"
        },
        livereload: {
          options: {
            keepalive: true,
            livereload: LIVERELOAD_PORT,
            middleware: function(connect) {
              return [lrSnippet, mountFolder(connect, cfg.tmp), mountFolder(connect, cfg.app)];
            }
          }
        }
      },
      open: {
        server: {
          path: "http://localhost:<%= connect.options.port %>"
        }
      }
    });
    grunt.registerTask("server", ["open", "connect:livereload"]);
    return grunt.registerTask("default", ["server"]);
  };

}).call(this);