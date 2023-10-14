#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Sat Oct 14 11:11:06 AM UTC 2023
#
# Install deps (mummy):
#   $ nimble refresh
#   $ nimble install -d
#
# Compile/run:
#   $ nimble run
#
# Client:
#   $ curl http://127.0.0.1:8080
#
# Ref:
#   https://github.com/guzba/mummy
#

# {{{ imports

import mummy, mummy/routers

# }}}
# ======== procs ========
# {{{ indexHandler() -- proc

proc indexHandler(request: Request) =
  var headers: HttpHeaders
  headers["Content-Type"] = "text/plain"
  request.respond(200, headers, "Hello, World!\n")

# }}}
# {{{ main() -- proc

proc main() =
  var router: Router
  router.get("/", indexHandler)
  let server = newServer(router)
  let address = "127.0.0.1"
  let port = 8080
  let url = "http://" & address & ":" & $port
  echo "Serving on ", url, "..."
  server.serve(Port(port), address = address)

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
