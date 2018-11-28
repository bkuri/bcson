'use strict'

{ dirname } = require('path')
{ readFileSync, writeFileSync } = require('fs-cson')
found = require('path-exists').sync
mkdir = require('mkdirp').sync

full = (file, ext='.cson') ->
  io = file.indexOf(ext, file.length - ext.length)
  return if (io < 0) then "#{ file }#{ ext }" else file

module.exports = (file, content={}, callback=null) ->
  file = full(file)

  unless found(file)
    mkdir dirname(file)
    writeFileSync file, content

  watched = new Proxy readFileSync(file),
    set: (target, key, value, proxy) ->
      target[key] = value

      writeFileSync file, target
      callback?(watched)
      return Reflect.set(target, key, value, proxy)

  callback?(watched)
  return watched
