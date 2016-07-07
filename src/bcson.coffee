'use strict'


{dirname} = require('path')
{existsSync, keepExtension} = require('./lib/helpers')
{readFileSync, writeFileSync} = require('fs-cson')
mkdirp = require('mkdirp')
observed = require('observed')

tmp = {}

module.exports = (file, callback=null) ->
  file = keepExtension(file, '.cson')
  return tmp[file] if tmp[file]?

  unless existsSync(file)
    mkdirp.sync dirname(file)
    writeFileSync file, {}

  parsed = readFileSync(file)
  observe = observed(parsed)

  observe.on 'change', ->
    writeFileSync file, parsed

  callback?(observe)
  return tmp[file] = parsed
