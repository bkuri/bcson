'use strict'


{accessSync} = require('fs')


module.exports =
  keepExtension: (file, ext) ->
    found = file.indexOf(ext, file.length - ext.length) > -1
    return if found then file else "#{file}#{ext}"

  existsSync: (file) ->
    ###
    We need this function since
    fs.existsSync is deprecated
    ###

    try
      accessSync file
      return yes

    catch ex
      return no
