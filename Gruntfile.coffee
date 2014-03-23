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

  grunt.registerTask 'help', 'Get a list of commands for building Send A Message', () ->
    grunt.log.writeln '\n===== SEND A MESSAGE ====='
    grunt.log.writeln '\ncommands:'
    grunt.log.writeln 'help   --- get a list of grunt commands'
    grunt.log.writeln 'server --- run the Send A Message server'
    grunt.log.writeln '\n=========================='
  grunt.registerTask 'default', ['coffeelint']
  grunt.registerTask 'server', ['exec:server']
