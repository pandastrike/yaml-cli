{call, read, isObject, isArray} = require "fairmont"
YAML = require "js-yaml"

[path, reference, value...] = process.argv[2..]

if path? && reference? && value?
  call ->
    root = current = YAML.safeLoad yield read path
    [keys..., last] = reference.split "."
    for key in keys
      current = current[key]
    current[last] = value.join(" ")
    result = YAML.safeDump root
    console.log result
else
  console.error "yaml set: insufficient arguments"
  console.error "yaml set <path> <reference> <value>"
  process.exit -1
