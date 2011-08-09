(function() {
  "use strict";  var collection, collections, models;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  APP.init = function() {
    return APP.instances.app = new collections.app;
  };
  models = {};
  collections = {};
  collection = Backbone.Collection.extend({
    initialize: function(models, options) {
      this.bind("reset", function(collection, options) {
        var container, model, _i, _len, _ref;
        container = document.createDocumentFragment();
        _ref = collection.models;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          model = _ref[_i];
          container.appendChild(this.render(model));
        }
        return $(this.el).html(container);
      });
      this.bind("success", function(collection, response) {});
      this.bind("error", function(collection, response) {});
      return this.fetch({
        success: __bind(function(col, resp) {
          return this.trigger('success', col, resp);
        }, this),
        error: __bind(function(col, resp) {
          return this.trigger('error', col, resp);
        }, this)
      });
    }
  });
  models.app = Backbone.Model.extend({});
  collections.app = collection.extend({
    model: models.app,
    url: "data.json",
    el: "#albums",
    render: function(model) {
      return (new APP.views.view({
        model: model
      })).el;
    }
  });
}).call(this);
