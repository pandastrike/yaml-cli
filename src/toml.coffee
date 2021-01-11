{async, call, read} = require "fairmont"
TOML = require "@iarna/toml"
YAML = require "./yaml"
errors = require "./errors"

[subcommand, path] = process.argv[2..]

_TOML =

  read: async (_path) ->

    path = if _path == "-" then process.stdin else _path

    try
      toml = yield read path
    catch error
      errors.readingPath error, path

    try
      data = TOML.parse toml
    catch error
      errors.parsingTOML error

    data

  write: (data) ->

    result =
      if data?
        try
          TOML.stringify data
        catch error
          errors.formattingTOML error
      else
        ""

    console.log result

if subcommand? && subcommand in ["read", "write"] && path?
  call ->
    if subcommand == "write"
      _TOML.write yield YAML.read path
    else
      YAML.write yield _TOML.read path

else
  console.error "yaml toml: invalid arguments"
  console.error "yaml toml [read|write] <path>"
  process.exit -1
