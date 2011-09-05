(function() {
  "use strict";
  var collection, collections, models;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
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
      if (this.init) {
        this.init(models, options);
      }
      return this.bind("reset", function(collection, options) {
        var container, model, _i, _len, _ref;
        container = document.createDocumentFragment();
        _ref = collection.models;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          model = _ref[_i];
          container.appendChild(this.render(model));
        }
        this.el.html(container);
        if (this.post_render) {
          return this.post_render(collection, options);
        }
      });
    };
    collection.prototype.render = function(model) {
      return (new APP.views[this.view]({
        model: model,
        collection: this
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
    app.prototype.url = "data.json";
    app.prototype.el = $("#albums");
    app.prototype.view = "app";
    app.prototype.init = function() {
      return this.fetch();
    };
    return app;
  })();
}).call(this);
