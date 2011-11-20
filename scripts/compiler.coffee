fs = require "fs"
exec = require("child_process").exec

do compileTmpl = ->
  console.log "compile tmpl"
  exec "handlebars -m #{__dirname}/../js/templates/* -f #{__dirname}/../js/compiled/templates.js", (error, stdout, stderr) ->
    #console.log error, stdout, stderr
    
do compileCoffee = ->
  console.log "compile coffee"
  exec "coffee -c -o #{__dirname}/../js/compiled #{__dirname}/../js/app", (error, stdout, stderr) ->
    #console.log error, stdout, stderr
    
fs.watch "js/templates", (event, filename) ->
  console.log event, " - tmpl"
  if filename
    console.log "filename", filename
  compileTmpl()

fs.watch "js/app", (event, filename) ->
  console.log event, " - coffee"
  if filename
    console.log "filename", filename
  compileCoffee()
