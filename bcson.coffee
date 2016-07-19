'use strict'

{dirname} = require('path')
{readFileSync, writeFileSync} = require('fs-cson')
found = require('path-exists').sync
mkdir = require('mkdirp').sync
tmp = {}

keepExtension = (file, ext='.cson') ->
  io = file.indexOf(ext, file.length - ext.length)
  return unless (io < 0) then "#{ file }#{ ext }" else file

module.exports = (file, callback=null, content={}) ->
  file = keepExtension(file)
  return tmp[file] if tmp[file]?

  unless found(file)
    mkdir dirname(file)
    writeFileSync file, content

  watched = new Proxy readFileSync(file),
    get: (target, key) ->
      return target[key]

    set: (target, key, value, receiver) ->
      target[key] = value

      writeFileSync file, target
      callback(target) if callback?
      return value

  callback(watched) if callback?
  return tmp[file] = watched
