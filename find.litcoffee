#Find Files

    fs = require 'fs'

Find files in a directory

    find = (root, options, callback) ->
     options.directory ?= false
     options.file ?= false

     results = []
     err = []

     callbackCount = 0

     done = ->
      callbackCount--
      if callbackCount is 0
       err = null if err.length is 0
       callback err, results

     filter = (name) ->
      if options.filter?
       options.filter.test name
      else
       true

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
           if options.directory and filter file
            results.push f
           recurse f
          else if stats.isFile()
           if options.file and filter file
            results.push f
          done()

       done()

     recurse root

##Export

    module.exports = find
