#!/usr/bin/env coffee
os = require "os"
{join} = require "path"
assert = require "assert"
Amen = require "amen"
{write, shell, async, include} = require "fairmont"

# convenience functions to make it easier to call the CLI
yaml = async (action, args...) ->
  {stdout} = yield shell "bin/yaml #{action} #{args.join ' '}"
  stdout.trim()

include yaml,
  get: (args...) -> yaml "get", args...
  set: (args...) -> yaml "set", args...
  template: (args...) -> yaml "template", args...

# use mktemp for output files to avoid parallel tests
# from interfering with each other...
mktemp = do (tmp=os.tmpdir(), counter=0) ->
  -> join tmp, "out-#{counter++}.yaml"

Amen.describe "YAML CLI", (context) ->

  context.test "get", (context) ->

    context.test "a property", ->
      assert.equal '7',
        yield yaml.get "test/test.yaml", "foo.bar"

    context.test "an array element", ->
      assert.equal 'hello world',
         yield yaml.get "test/test.yaml", "foo.baz.1"

    context.test "undefined as blank", ->
      assert.equal '',
        yield yaml.get "test/test.yaml", "foo.blurg"

  context.test "set", (context) ->

    context.test "a property", ->

      tmpFile = mktemp()

      write tmpFile,
        yield yaml.set "test/test.yaml", "foo.bar 3"

      assert.equal '3',
        yield yaml.get tmpFile, "foo.bar"

    context.test "an array element", ->

      tmpFile = mktemp()

      write tmpFile,
        yield yaml.set "test/test.yaml", "foo.baz.1 goodbye world"

      assert.equal 'goodbye world',
        yield yaml.get tmpFile, "foo.baz.1"

  context.test "template", (context) ->

    context.test "instantiation", ->
      assert.equal "I'd like to say hello world",
        yield yaml.template "test/test.yaml", "test/template.txt"
