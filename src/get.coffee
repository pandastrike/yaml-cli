{call, read, isDefined, isObject, isArray} = require "fairmont"
YAML = require "js-yaml"

[path, reference] = process.argv[2..]

if path? && reference?
  call ->
    path = if path == "-" then process.stdin else path
    root = current = YAML.safeLoad yield read path
    [keys..., last] = reference.split "."
    for key in keys
      current = current[key]
    result = current[last]
    if isDefined result
      if (isObject result) || (isArray result)
        result = YAML.safeDump result
      console.log result
else
  console.error "yaml get: insufficient arguments"
  console.error "yaml get <path> <reference>"
  process.exit -1
