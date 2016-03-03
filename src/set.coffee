{call} = require "fairmont"
YAML = require "./yaml"

[path, reference, value...] = process.argv[2..]

if path? && reference? && value?
  call ->
    root = current = yield YAML.read path
    [keys..., last] = reference.split "."
    for key in keys
      current = current[key]
    current[last] = value.join(" ")
    YAML.write root
else
  console.error "yaml set: insufficient arguments"
  console.error "yaml set <path> <reference> <value>"
  process.exit -1
