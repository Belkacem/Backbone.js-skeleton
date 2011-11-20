"use strict"

# Create a new collection on init()
APP.init = -> new collections.app

models = {}
collections = {}

# Boilerplate collection with some nifty tricks
# Reset is called when fetch is complete
# Reset is set up to create a docFrag and append all the rendered model views
# When complete inserts it in one DOW draw, in @el
class collection extends Backbone.Collection
  initialize : (models, options) ->
    elem = document.getElementById @el
    # collection is reset on fetch, or manually
    @bind "reset", (collection, options) ->
      # build the dom:
      frag = document.createDocumentFragment()
      for model in @models
        frag.appendChild @render model
      # inject rendered view into @el
      elem.appendChild frag
      # if defined, call this func to do stuff after reset
      @post_render @, options if @post_render
    @bind "add", (model, options) ->
      elem.appendChild @render model
  # collection render func
  render : (model) ->
    # @view name is set as a string on each collection
    # returns a html blob if the view has a self invoking render function
    (new APP.views[@view]
      model: model
    ).el

# model used in the collection
class models.app extends Backbone.Model

class collections.app extends collection
  model : models.app
  # also used to associate model by same name
  view : "app"
  # Collection url, fetch, save etc
  url : "data.json"
  # #ID Element to render the collection in
  el : "albums"
  initialize : (models, options) ->
    super()
    @fetch()
    