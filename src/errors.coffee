module.exports =

  readingPath: (error, path) ->
    if path == "-"
      console.error "yaml: error reading from stdin"
    else
      console.error "yaml: error reading from #{path}"
    process.exit -1

  parsingYAML: (error) ->
    console.error "yaml: error parsing YAML\n#{error.message}"
    process.exit -1

  formattingYAML: (error) ->
    console.error "yaml: unable to format result as YAML\n#{error.message}"
    process.exit -1

  parsingJSON: (error) ->
    console.error "yaml: error parsing JSON\n#{error.message}"
    process.exit -1

  formattingJSON: (error) ->
    console.error "yaml: unable to format result as JSON\n#{error.message}"
    process.exit -1

  parsingTOML: (error) ->
    console.error "yaml: error parsing TOML\n#{error.message}"
    process.exit -1

  formattingTOML: (error) ->
    console.error "yaml: unable to format result as TOML\n#{error.message}"
    process.exit -1
