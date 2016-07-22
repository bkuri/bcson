Bind Cson - "bcson"
===================

Bind Cson: Reactive way to read/write cson files using ES6 Proxies.

Shamelessly forked from [bjson](https://github.com/renatorib/bjson).

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

# one liner:
# settings = require('bcson', prop: 'bar')
```

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

### Test suite

Run `npm test`. Uses mocha and chai.
