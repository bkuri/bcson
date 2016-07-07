Bind Cson - "bcson"
===================

Bind Cson: Reactive way to read/write cson files. Shamelessly forked from [bjson](https://github.com/renatorib/bjson).

How it works
------------

**What do you need to do when you need to edit a cson file programmatically?**

| Without bcson                  | With bcson                                        |
|--------------------------------|---------------------------------------------------|
| Create cson file if not exists |                                                   |
| Read cson file.                | Read cson file *(Will create if not exists)*      |
| Deserialize cson file.         |                                                   |
| Edit parsed object.            | Edit object *(Will reactively save in cson file)* |
| Serialize new object.          |                                                   |
| Write back into file.          |                                                   |

### Examples

**Editing .cson file without bcson**

```coffee
fs = require('fs')

unless fs.existsSync('settings.cson')
  cson.writeFileSync 'settings.cson', {}

settings = cson.readFileSync('settings.cson')
settings.foo = 'bar'
cson.writeFileSync 'settings.cson', settings
```

**Editing .cson file with bcson**

```coffee
bcson = require('bcson')
settings = bcson('settings.cson')
settings.foo = 'bar'
```

Getting started
---------------

### Binding cson

*settings.cson*

```cson
{}
```

*whatever.coffee*

```coffee
bcson = require('bcson')
settings = bcson('settings') # will read or create settings.cson
settings.prop = 'bar'
```

*settings.cson:*

```cson
prop: "bar"
```

### Watching changes with observe

You can watch changes with a instance of `Object.observe` passed as callback argument.

*settings.cson:*

```cson
prop: "bar"
```

whatever.coffee

```coffee
bcson = require('bcson')

settings = bcson 'settings', (observe) ->
  observe.on 'change', (changes) ->
    console.log 'Path:', changes.path
    console.log 'Old Value:', changes.oldValue
    console.log 'New Value:', changes.value
    console.log '-----'

settings.prop = 'foo'
settings.otherprop = 'bar'
```

Log output:

```
Path: prop
Old Value: bar
New Value: foo
-----
Path: otherprop
Old Value: undefined
New Value: bar
-----
```

*settings.cson:*

```cson
prop: "foo"
otherprop": "bar"
```

### Observe events

```coffee
bcson = require('bcson')

settings = bcson('settings', (observe) ->
  observe.on 'add', (changes) ->
  observe.on 'update', (changes) ->
  observe.on 'delete', (changes) ->
  observe.on 'reconfigure', (changes) ->
  observe.on 'change', (changes) -> # fired when any of the above events are emitted
```

### Observe events callback `changes`

`path`: full path to the property, including nesting  
`name`: name of the path  
`type`: name of the event  
`object`: object  
`value`: current value for the given path. same as object[name]  
`oldValue`: previous value of the property

Example:

```coffee
bcson = require('bcson')

settings = bcson 'settings', (observe) ->
  observe.on 'change', (changes) ->
    console.log changes

settings.foo = 'bar'

#log:
# path: 'foo'
# name: 'foo'
# type: 'add'
# object: { foo: 'bar' }
# value: 'bar'
# oldValue: undefined
```
