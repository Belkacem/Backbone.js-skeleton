"use strict"

templates =
  # Compile a handlebars template
  # Should work seamlessly with any template lang that returns a function
  # which in turn expects a object to be passed on invoc.
  # e.g. _.template $("#app_template").html()
  app : Handlebars.compile $("#app_template").html()

##################################

# Boilerplate view
class view extends Backbone.View
  # - Bind model events onto the view, then render
  # - When the model changes, re-render
  # - When destroy is called in the corresponding model, remove view
  # - On model error, call @error,
  #   good when you would want to show errors in the view
  initialize : ->
    @model.bind 'change' , @render, @
    @model.bind 'destroy', @remove, @
    @model.bind 'error'  , (model, response, options) =>
      @error model, response, options if @error
    @render()
  # - Every view has a "el" attribute
  #   If not set, it is created, which is often good stuff.
  #   Don't set a existing element on the page as the view "el" if the view would be rendered loads of times
  #   very easy to create shit loads of delegated events
  # - Runs @set_content if exists, nice if you want to inherit from the base view but bind some other stuff on the el. 
  render : ->
    $(@el).html @template @model.toJSON()
    @
  # Called when destroy is called on the model
  remove : ->
    $(@el).remove()
  # Destroy model and clear view:
  clear : ->
    @model.destroy()

##################################
##################################

# Inherits from "view"
# e.g. override render : -> if the view doesn't have a model set
# Make accessible to models through the global "APP" namespace
class APP.views.app extends view
  # the render func expects a template function to be set,
  # and passes in a obj to be rendered
  template : templates.app
  render : ->
    # call render function set in parent
    super()
    
    # do stuff after render: