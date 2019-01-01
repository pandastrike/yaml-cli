#!/usr/bin/env coffee
os = require "os"
{join} = require "path"
assert = require "assert"
Amen = require "amen"
{shell, async, read} = require "fairmont"

# convenience functions to make it easier to call the CLI
sh = async (command) ->
  {stdout} = yield shell command
  stdout.trim()

Amen.describe "YAML CLI", (context) ->

  context.test "get", (context) ->

    context.test "a property", ->
      assert.equal '7',
        yield sh "bin/yaml get test/test.yaml foo.bar"

    context.test "an array element", ->
      assert.equal 'hello world',
         yield sh "bin/yaml get test/test.yaml foo.baz.1"

    context.test "undefined as blank", ->
      assert.equal '',
        yield sh "bin/yaml get test/test.yaml foo.blurg"

    context.test "read from stdin", ->
      assert.equal '7',
        yield sh "cat test/test.yaml | bin/yaml get - foo.bar"

    context.test "bad path", ->
      # TODO: seems like there should be a better way to do this
      fails = undefined
      yield (sh "bin/yaml get test/fubar.yaml foo.bar"
      .then -> fails = false
      .catch -> fails = true)
      assert.equal fails, true, "expected bad path error"

    context.test "bad YAML", ->
      # TODO: seems like there should be a better way to do this
      fails = undefined
      yield (sh "bin/yaml get test/bad.yaml foo.bar"
      .then -> fails = false
      .catch -> fails = true)
      assert.equal fails, true, "expected parse error"

  context.test "set", (context) ->

    context.test "a property", ->
      assert.equal '3',
        yield sh "bin/yaml set test/test.yaml foo.bar 3 |
           bin/yaml get - foo.bar"

    context.test "an array element", ->
      assert.equal 'goodbye world',
        yield sh "bin/yaml set test/test.yaml foo.baz.1 goodbye world |
           bin/yaml get - foo.baz.1"

    context.test "read from stdin", ->
      assert.equal '3',
        yield sh "cat test/test.yaml |
          bin/yaml set - foo.bar 3 |
          bin/yaml get - foo.bar"


  context.test "template", (context) ->

    context.test "instantiation", ->
      assert.equal "I'd like to say hello world",
        yield sh "bin/yaml template  test/test.yaml test/template.txt"

  context.test "json", (context) ->

    context.test "read", ->
      YAML = require "js-yaml"
      data = YAML.safeLoad yield sh "bin/yaml json read test/test.json"
      assert.equal "7", data.foo.bar
      assert.equal "hello world", data.foo.baz[1]


    context.test "write", ->
      data = JSON.parse yield sh "bin/yaml json write test/test.yaml"
      assert.equal "7", data.foo.bar
      assert.equal "hello world", data.foo.baz[1]

  context.test "toml", (context) ->

    context.test "read", ->
      YAML = require "js-yaml"
      data = YAML.safeLoad yield sh "bin/yaml toml read test/test.toml"
      assert.equal "7", data.foo.bar
      assert.equal "7", data.somename.partone.one
      assert.equal "hello world", data.somename.partone.two[1]


    context.test "write", ->
      TOML = require "@iarna/toml"
      data = TOML.parse yield sh "bin/yaml toml write test/test-toml.yaml"
      assert.equal "7", data.foo.bar
      assert.equal "hello world", data.foo.baz[1]
