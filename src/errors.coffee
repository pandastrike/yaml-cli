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
