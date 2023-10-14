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
#   $ curl -v http://127.0.0.1:8080
#
# Ref:
#   https://github.com/guzba/mummy
#

# {{{ imports

import mummy, mummy/routers

# }}}
# ======== procs ========
# {{{ HttpVersion.`$`() -- proc

proc `$`(self: HttpVersion): string =
  case self:
    of Http10:
      result = "HTTP/1.0"
    of Http11:
      result = "HTTP/1.1"

# }}}
# {{{ indexHandler() -- proc

proc indexHandler(req: Request) =
  echo req.httpMethod, " ", req.uri, " ", req.httpVersion
  var h: HttpHeaders
  h["Content-Type"] = "text/plain"
  req.respond(200, h, "Hello, World!\n")

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
