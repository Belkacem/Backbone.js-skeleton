# https://gist.github.com/906395/d7ad2229a5b3795382989101ae05606876b4e7d5

libpath = require("path")
http = require("http")
fs = require("fs")
url = require("url")
mime = require("mime")
path = "./"
port = 8888

for arg, index in process.argv
  port = process.argv[index + 1] if arg.match(/-p/)

http.createServer((request, response) ->
  uri = url.parse(request.url).pathname
  filename = libpath.join(path, uri)
  
  libpath.exists filename, (exists) ->
    unless exists
      response.writeHead 404,
        "Content-Type": "text/plain"

      response.write "404 Not Found\n"
      response.end()
      return
    filename += "/index.html"  if fs.statSync(filename).isDirectory()
    
    fs.readFile filename, "binary", (err, file) ->
      if err
        response.writeHead 500,
          "Content-Type": "text/plain"

        response.write err + "\n"
        response.end()
        return
      type = mime.lookup(filename)
      response.writeHead 200,
        "Content-Type": type

      response.write file, "binary"
      response.end()
).listen port

console.log "Static server running at:\n  => http://localhost:" + port + "/\n  CTRL + C to shutdown"
