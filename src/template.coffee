{call, read} = require "fairmont"
YAML = require "js-yaml"
{get, set} = require "./reference"


[path, template] = process.argv[2..]

if path? && template?
  call ->
    context = YAML.safeLoad yield read path
    console.log ((require "markup-js").up (yield read template), context)

else
  console.error "yaml template: insufficient arguments"
  console.error "yaml template <yaml-path> <template-path>"
  process.exit -1
