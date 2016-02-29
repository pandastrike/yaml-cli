// Generated by CoffeeScript 1.10.0
(function() {
  var YAML, call, get, path, read, ref, ref1, ref2, set, template;

  ref = require("fairmont"), call = ref.call, read = ref.read;

  YAML = require("js-yaml");

  ref1 = require("./reference"), get = ref1.get, set = ref1.set;

  ref2 = process.argv.slice(2), path = ref2[0], template = ref2[1];

  if ((path != null) && (template != null)) {
    call(function*() {
      var context;
      context = YAML.safeLoad((yield read(path)));
      return console.log((require("markup-js")).up((yield read(template)), context));
    });
  } else {
    console.error("yaml template: insufficient arguments");
    console.error("yaml template <yaml-path> <template-path>");
    process.exit(-1);
  }

}).call(this);