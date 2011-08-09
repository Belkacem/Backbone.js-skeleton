"use strict"

# Create a new collection on init()
APP.init = -> new collections.app

models = {}
collections = {}

#################################

# Boilerplate collection with some nifty tricks
# Reset is called when fetch is complete, uses @url to do a GET
# Reset is set up to create a docFrag and append all the rendered model views
# When complete inserts it in one DOW draw, in @el
collection = Backbone.Collection.extend
  initialize : (models, options) ->
    @bind "reset", (collection, options) ->
      container = document.createDocumentFragment()
      for model in collection.models
        container.appendChild @render model
      $(@el).html container
    @bind "success", (collection, response) ->
    @bind "error", (collection, response) ->
    @fetch
      success : (col, resp) => @trigger 'success', col, resp
      error : (col, resp) => @trigger 'error', col, resp

##################################

# model used in the collection
models.app = Backbone.Model.extend({})

collections.app = collection.extend
  model : models.app
  # Collection url, fetch, save etc
  url : "data.json"
  # Element to render the collection in
  el : "#albums"
  # Create a new view and return a rendered html blob
  render : (model) ->
    ( new APP.views.view model : model ).el
