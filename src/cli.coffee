[path, query, value] = process.argv[2..]

if path? && query?
  _query = require "./query"
  _query {path, query, value}
  .then (result) -> console.log result
else
  console.error "yaml: insufficient arguments"
  console.error "yaml <path> <query>"
