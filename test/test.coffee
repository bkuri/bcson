'use strict'

{expect} = require('chai')
bcson = require('..')
found = require('path-exists').sync

callback = (what) ->
  console.log "    · content: #{ JSON.stringify(what) }"
  return

describe 'BCSON', ->
  cson = null
  file = 'test/test.cson'

  it 'should create a new file with initial content.', ->
    cson = bcson(file, one: 'uno', callback)
    expect(found file).to.equal yes

  it 'should find a key called "one" with a value of "uno".', ->
    expect(cson.one).not.to.equal undefined
    expect(cson.one).to.equal 'uno'

  it 'should find a key called "two" with a value of "dos".', ->
    cson.two = 'dos'
    expect(cson.two).not.to.equal undefined
    expect(cson.two).to.equal 'dos'

  it 'should verify that all content has been replaced.', ->
    cson = Object.assign(cson, one: 'UNO', two: 'DOS')
    expect(cson.one).to.equal 'UNO'
    expect(cson.two).to.equal 'DOS'
