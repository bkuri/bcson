'use strict'


bcson = require('..')

# TODO: Make some mocha tests
file = bcson('my/deep/file')
file.foo = 'bar'
file.object = deep: bar: 'foo'
