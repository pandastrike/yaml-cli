[path, query, value] = process.argv[2..]

_query = require "./query"
_query {path, query, value}
.then (result) -> console.log result
