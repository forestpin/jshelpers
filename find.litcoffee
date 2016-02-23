#Find Files

    FS = require 'fs'
    PATH = require 'path'

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

     addFile = (path, file) ->
      return if file[0] is '.'
      return if file[file.length - 1] is '~'
      if path?
       f = "#{path}#{PATH.sep}#{file}"
      else
       f = file
      callbackCount++
      FS.stat f, (e, stats) ->
       if e?
        err.push e
        return done()

       if stats.isDirectory()
        if options.directory and filter file
         results.push f
        recurse f
       else if stats.isFile()
        if options.file and filter file
         results.push f
       done()


     recurse = (path) ->
      callbackCount++
      FS.readdir path, (e, files) ->
       if e?
        err.push e
        return done()

       for file in files
        addFile path, file

       done()

     callbackCount++
     addFile null, root
     done()

##Export

    module.exports = find
