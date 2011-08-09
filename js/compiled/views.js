(function() {
  "use strict";  var templates, view;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  templates = {
    app: Handlebars.compile($("#template").html())
  };
  view = Backbone.View.extend({
    initialize: function() {
      this.model.bind('change', this.render, this);
      this.model.bind('destroy', this.remove, this);
      this.model.bind('error', __bind(function(model, response, options) {
        if (this.error) {
          return this.error(model, response, options);
        }
      }, this));
      return this.render();
    },
    render: function() {
      $(this.el).html(this.template(this.model.toJSON()));
      if (this.set_content) {
        this.set_content();
      }
      return this;
    },
    remove: function() {
      return $(this.el).remove();
    },
    clear: function() {
      return this.model.destroy();
    }
  });
  APP.views.view = view.extend({
    template: templates.app
  });
}).call(this);
