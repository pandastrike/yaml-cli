{async, read, isObject, isArray} = require "fairmont"
YAML = require "js-yaml"
errors = require "./errors"

module.exports =

  read: async (_path) ->

    path = if _path == "-" then process.stdin else _path

    try
      yaml = yield read path
    catch error
      errors.readingPath error, path

    try
      data = YAML.safeLoad yaml
    catch error
      errors.parsingYAML error

    data

  write: (data) ->

    result =
      if data?
        if (isObject data) || (isArray data)
          try
            YAML.safeDump data
          catch error
            errors.formatYAML error
        else
          data.toString()
      else
        ""

    console.log result
