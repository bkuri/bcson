'use strict'

{expect} = require('chai')
bcson = require('..')
found = require('path-exists').sync

callback = (content) ->
  console.log JSON.stringify({content})
  return

describe 'BCSON', ->
  file = 'test/test.cson'
  cson = null

  it 'should create a new file', ->
    cson = bcson(file, callback, foo: 'bar')
    expect(found file).to.equal yes

  it 'should find a key called "foo".', ->
    expect(cson.foo?).to.equal yes

  it 'should verify that "foo" has a value of "bar".', ->
    expect(cson.foo).to.equal 'bar'

  it 'should verify that "foo" has a value of "BAZ".', ->
    cson.foo = 'BAZ'

    expect(cson.foo).to.equal 'BAZ'
