(function() {

  "use strict";

  var collection, collections, models;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  APP.init = function() {
    return new collections.app;
  };

  models = {};

  collections = {};

  collection = (function() {

    __extends(collection, Backbone.Collection);

    function collection() {
      collection.__super__.constructor.apply(this, arguments);
    }

    collection.prototype.initialize = function(models, options) {
      var elem;
      elem = document.getElementById(this.el);
      this.bind("reset", function(collection, options) {
        var frag, model, _i, _len, _ref;
        frag = document.createDocumentFragment();
        _ref = this.models;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          model = _ref[_i];
          frag.appendChild(this.render(model));
        }
        elem.appendChild(frag);
        if (this.post_render) return this.post_render(this, options);
      });
      return this.bind("add", function(model, options) {
        return elem.appendChild(this.render(model));
      });
    };

    collection.prototype.render = function(model) {
      return (new APP.views[this.view]({
        model: model
      })).el;
    };

    return collection;

  })();

  models.app = (function() {

    __extends(app, Backbone.Model);

    function app() {
      app.__super__.constructor.apply(this, arguments);
    }

    return app;

  })();

  collections.app = (function() {

    __extends(app, collection);

    function app() {
      app.__super__.constructor.apply(this, arguments);
    }

    app.prototype.model = models.app;

    app.prototype.view = "app";

    app.prototype.url = "data.json";

    app.prototype.el = "albums";

    app.prototype.initialize = function(models, options) {
      app.__super__.initialize.call(this);
      return this.fetch();
    };

    return app;

  })();

}).call(this);
