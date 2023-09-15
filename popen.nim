#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Fri Sep 15 03:01:13 PM UTC 2023
#
# Compile/run:
#   $ nim c -r popen.nim
#

# {{{ imports

# The orthodox way:
# import std/strformat, std/logging, std/osproc, std/streams
import pure/strformat, pure/logging, pure/osproc, pure/streams

var cl = newConsoleLogger(fmtStr="$datetime [$levelid] ",useStderr=true)
setLogFilter(lvlInfo)
addHandler(cl)

# }}}
# ======== procs ========
# {{{ main()

proc main() =
  # ref: <nim-2.0.0>/lib/pure/osproc.nim -> execProcess()
  let p = startProcess("cat", "", ["-n", "popen.nim"], nil, {poUsePath})
  defer:
    info("closing process")
    p.close()
  var outp = outputStream(p)
  var line: string = newStringOfCap(1024)
  var i = 0
  while true:
    if outp.readLine(line):
      i += 1
      info(&"[{i:02d}]" & line)
      continue
    if not p.running:
      break
  discard p.waitForExit(timeout = -1)  # not needed

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  info("==== BEGIN ====")
  main()
  info("---- END ----")

# }}}
