module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    exec:
      server:
        cmd: 'coffee app/server.coffee & open "http://localhost:3000" & wait'
    coffeelint:
      app: 'app/*.coffee'

  grunt.loadNpmTasks 'grunt-exec'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'default', ['coffeelint']
  grunt.registerTask 'server', ['exec:server']
