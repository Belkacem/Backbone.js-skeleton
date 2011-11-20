fs = require "fs"
exec = require("child_process").exec
coffee = require "coffee-script"
handlebars = require "handlebars"
basename = require("path").basename
uglify = require "uglify-js"

do compileTmpl = ->
  template = "#{__dirname}/../js/templates"
  outputFile = "#{__dirname}/../js/compiled/templates.js"
  
  output = []
  output.push '(function() {\n  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};\n'
  
  processTemplate = ( template ) ->
    path = template
    stat = fs.statSync path
    if stat.isDirectory()
      fs.readdirSync(template).map (file) ->
        path = template + "/" + file
        processTemplate path
    else
      data = fs.readFileSync path, "utf8"
      template = basename template
      name = template.replace(/\.handlebars|.hb$/, "")
      
      try  
        data = handlebars.precompile data
        output.push "templates['" + name + "'] = template(" + data + ");\n"
      catch error
        console.log error, "File: #{template}"
  
  processTemplate template
  
  output.push '})();'
  output = output.join ''
  
  # minify
  ast = uglify.parser.parse output
  ast = uglify.uglify.ast_mangle ast
  ast = uglify.uglify.ast_squeeze ast
  output = uglify.uglify.gen_code ast
  
  # write
  fs.writeFileSync outputFile, output, 'utf8'
  console.log "Compiled handlebars template files"
  
do compileCoffee = ->
  scripts = "#{__dirname}/../js/app"
  outputFolder = "#{__dirname}/../js/compiled/"

  processScripts = ( script ) ->
    path = script
    stat = fs.statSync path
    if stat.isDirectory()
      fs.readdirSync(script).map (file) ->
        path = script + "/" + file
        processScripts path
    else
      data = fs.readFileSync path, "utf8"
      script = basename script
      name = script.replace(/\.coffee$/, ".js")
      
      try
        outputFile = coffee.compile data
        fs.writeFileSync outputFolder + name, outputFile, 'utf8'
      catch error
        console.log error, "File: #{script}"      
  
  processScripts scripts
  console.log "Compiled coffee-script files"

fs.watch "#{__dirname}/../js/templates", (event, filename) ->
  if filename then console.log "filename", filename
  compileTmpl event, filename

fs.watch "#{__dirname}/../js/app", (event, filename) ->
  if filename then console.log "filename", filename
  compileCoffee event, filename
