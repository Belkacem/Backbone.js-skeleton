for arg in process.argv
  switch arg
    when "-s"
      require("./server.coffee")
    when "-h"
      help = '''
              Arguments:
                -s /= run static server
                -p /= to specify port on server, followed by port
              
              Example: "backplate -s -p 1111"
             '''
      console.log help
      process.exit 0