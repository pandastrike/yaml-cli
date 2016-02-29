{call, read, isObject, isArray} = require "fairmont"
YAML = require "js-yaml"
{get} = require "./reference"


[path, reference] = process.argv[2..]

if path? && reference?
  call ->
    root = current = YAML.safeLoad yield read path
    [keys..., last] = reference.split "."
    for key in keys
      current = get current, key
    result = get current, last
    if (isObject result) || (isArray result)
      result = YAML.safeDump result
    else
      result
    console.log result
else
  console.error "yaml get: insufficient arguments"
  console.error "yaml get <path> <reference>"
  process.exit -1
