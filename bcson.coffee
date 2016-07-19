'use strict'


{dirname} = require('path')
{readFileSync, writeFileSync} = require('fs-cson')
found = require('path-exists').sync
mkdir = require('mkdirp').sync
observed = require('observed')
tmp = {}


keepExtension = (file, ext) ->
  found = file.indexOf(ext, file.length - ext.length) > -1
  return if found then file else "#{ file }#{ ext }"


module.exports = (file, callback=null) ->
  file = keepExtension(file, '.cson')
  return tmp[file] if tmp[file]?

  unless found(file)
    mkdir dirname(file)
    writeFileSync file, {}

  parsed = readFileSync(file)
  observe = observed(parsed)

  observe.on 'change', ->
    writeFileSync file, parsed

  callback?(observe)
  return tmp[file] = parsed
