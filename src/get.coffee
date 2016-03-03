{call, isDefined, isObject, isArray} = require "fairmont"
YAML = require "./yaml"

[path, reference] = process.argv[2..]

if path? && reference?
  call ->
    root = current = yield YAML.read path
    [keys..., last] = reference.split "."
    for key in keys
      current = current[key]
    result = current[last]
    YAML.write result
else
  console.error "yaml get: insufficient arguments"
  console.error "yaml get <path> <reference>"
  process.exit -1
