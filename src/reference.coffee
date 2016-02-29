module.exports =
  
  get: (object, key) ->
    if (match = key.match /^([^\[]+)\[(\d+)\]$/)?
      [key, index] = match[1..]
      object[key][index]
    else
      object[key]

  set: (object, key, value) ->
    if (match = key.match /^([^\[]+)\[(\d+)\]$/)?
      [key, index] = match[1..]
      object[key][index] = value
    else
      object[key] = value
