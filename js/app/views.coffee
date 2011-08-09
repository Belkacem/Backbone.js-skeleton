"use strict"

templates =
  # Compile a handlebars template
  app : Handlebars.compile $("#template").html()

##################################

# Boilerplate view
view = Backbone.View.extend
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
    @set_content() if @set_content
    @
  # Called when destroy is called on the model
  remove : ->
    $(@el).remove()
  # Like here:
  clear : ->
    @model.destroy()

##################################
##################################

# Inherits from "view"
# Eg. override render : -> if the view doesn't have a model set
# Make accessible to models through the global "APP"
APP.views.view = view.extend
  # the model is rendered with this template
  template : templates.app
