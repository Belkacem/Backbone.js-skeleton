"use strict"

window.APP =
  views     : {}
  models    : {}
  instances : {}

# HELPERS : 

# mute console.log crap in ie etc
window.console ?= log : ->

# Handlebars helper functions:
# --> delete as needed.
Handlebars.registerHelper "debug", (inputs..., options) ->
  console.log @, "Current Context"
  console.log options, "Options"
  if input
    for input in inputs
      console.log input, "Input ##{_i}"

# check if input context is equal to input type
# {{#iftype value "equal" }}
#   do something 
# {{^}} --> # else
#   do something else
# {{/iftype}} --> if value is "equal"
Handlebars.registerHelper "iftype", (context, type, options) ->
  if context is type then options.fn @ else options.inverse @

# reverse of iftype
Handlebars.registerHelper "unlesstype", (context, type, options) ->
  fn = options.fn
  inverse = options.inverse
  options.fn = inverse
  options.inverse = fn
  Handlebars.helpers['iftype'].call @, context, type, options

# check if any of specified contexts are valid
# can be easily modified to check if all contexts are truthy
# instead of "if valids", do: "if valids.length is contexts.length"
Handlebars.registerHelper 'ifany', (contexts..., options) ->
  invalids = 0
  valids = 0
  for context in contexts
    if context or Handlebars.Utils.isEmpty(context) is false then valids++ else invalids++
  if valids then options.fn @ else options.inverse @

# if context is truthy, return first input value, else return secondary input
# {{ternaryIf context "true" "false" }} -->
# context = 1 - would yield "true" being output in the template
Handlebars.registerHelper "ternaryIf", (context, r_true, r_false) ->
  if context and Handlebars.Utils.isEmpty(context) is false then return r_true else r_false

# {{inlineIf context "check if context is equal to me" "if so, output me"}}
Handlebars.registerHelper "inlineIf", (context, check, return_me) ->
  if context is check then return_me
