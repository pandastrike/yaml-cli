{async, read} = require "fairmont"
YAML = require "js-yaml"

get = (object, key) ->
  if (match = key.match /^([^\[]+)\[(\d+)\]$/)?
    [key, index] = match[1..]
    object[key][index]
  else
    object[key]

set = (object, key, value) ->
  if (match = key.match /^([^\[]+)\[(\d+)\]$/)?
    [key, index] = match[1..]
    object[key][index] = value
  else
    object[key] = value

_query = async ({path, query, value}) ->
  root = current = YAML.safeLoad yield read path
  [keys..., last] = query.split "."
  for key in keys
    current = get current, key
  if value?
    set current, last, value
    YAML.safeDump root
  else
    get current, last

module.exports = _query
