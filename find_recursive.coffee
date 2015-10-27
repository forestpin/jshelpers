#Find Files

    fs = require 'fs'

Find files in a directory

    findAll = (options, dir, callback) ->
     list = []
     err = []

     callbackCount = 0

     done = ->
      callbackCount--
      if callbackCount is 0
       err = null if err.length is 0
       callback err, list

     recurse = (path) ->
      callbackCount++
      fs.readdir path, (e1, files) ->
       if e1?
        err.push e1
        done()
        return

       for file in files
        continue if file[0] is '.'
        continue if file[file.length - 1] is '~'
        do (file) ->
         f = "#{path}/#{file}"
         callbackCount++
         fs.stat f, (e2, stats) ->
          if e2?
           err.push e2
           done()
           return

          if stats.isDirectory()
           recurse f
           list.push f if options.directory
          else if stats.isFile()
           list.push f if options.file
          done()

       done()

     recurse dir

##Export

    module.exports = findAll
