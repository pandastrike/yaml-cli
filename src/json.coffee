{async, call, read, isObject, isArray} = require "fairmont"
YAML = require "./yaml"

[subcommand, path] = process.argv[2..]

_JSON =

  read: async (_path) ->

    path = if _path == "-" then process.stdin else _path

    try
      json = yield read path
    catch error
      errors.readingPath error, path

    try
      data = JSON.parse json
    catch error
      errors.parsingJSON error

    data

  write: (data) ->

    result =
      if data?
        if (isObject data) || (isArray data)
          try
            JSON.stringify data, null, 2
          catch error
            errors.formatJSON error
        else
          data.toString()
      else
        ""

    process.stdout.write result

if subcommand? && subcommand in ["read", "write"] && path?
  call ->
    if subcommand == "write"
      _JSON.write yield YAML.read path
    else
      YAML.write yield _JSON.read path

else
  console.error "yaml json: invalid arguments"
  console.error "yaml json [read|write] <path>"
  process.exit -1
