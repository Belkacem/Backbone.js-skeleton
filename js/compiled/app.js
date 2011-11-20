(function() {

  "use strict";

  var _ref;
  var __slice = Array.prototype.slice;

  window.APP = {
    views: {},
    models: {},
    instances: {}
  };

  if ((_ref = window.console) == null) {
    window.console = {
      log: function() {}
    };
  }

  Handlebars.registerHelper("debug", function() {
    var input, inputs, options, _i, _j, _len, _results;
    inputs = 2 <= arguments.length ? __slice.call(arguments, 0, _i = arguments.length - 1) : (_i = 0, []), options = arguments[_i++];
    console.log(this, "Current Context");
    console.log(options, "Options");
    if (input) {
      _results = [];
      for (_j = 0, _len = inputs.length; _j < _len; _j++) {
        input = inputs[_j];
        _results.push(console.log(input, "Input #" + _i));
      }
      return _results;
    }
  });

  Handlebars.registerHelper("iftype", function(context, type, options) {
    if (context === type) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  });

  Handlebars.registerHelper("unlesstype", function(context, type, options) {
    var fn, inverse;
    fn = options.fn;
    inverse = options.inverse;
    options.fn = inverse;
    options.inverse = fn;
    return Handlebars.helpers['iftype'].call(this, context, type, options);
  });

  Handlebars.registerHelper('ifany', function() {
    var context, contexts, invalids, options, valids, _i, _j, _len;
    contexts = 2 <= arguments.length ? __slice.call(arguments, 0, _i = arguments.length - 1) : (_i = 0, []), options = arguments[_i++];
    invalids = 0;
    valids = 0;
    for (_j = 0, _len = contexts.length; _j < _len; _j++) {
      context = contexts[_j];
      if (context || Handlebars.Utils.isEmpty(context) === false) {
        valids++;
      } else {
        invalids++;
      }
    }
    if (valids) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  });

  Handlebars.registerHelper("ternaryIf", function(context, r_true, r_false) {
    if (context && Handlebars.Utils.isEmpty(context) === false) {
      return r_true;
    } else {
      return r_false;
    }
  });

  Handlebars.registerHelper("inlineIf", function(context, check, return_me) {
    if (context === check) return return_me;
  });

}).call(this);
