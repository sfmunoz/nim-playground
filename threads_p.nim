#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Sat Sep 23 07:42:26 AM UTC 2023
#
# Compile/run:
#   $ nim c -r threads_p.nim
#
# Refs:
#   - https://nim-by-example.github.io/parallelism/
#   - https://nim-by-example.github.io/channels/
#

# {{{ imports

import threadpool, std/os

# }}}
# {{{ vars

var
  ch: Channel[string]

# }}}
# ======== macros/procs ========
# {{{ m1() -- proc

proc m1(arg: (int,int)) =
  echo "m1: starting"
  for i in 0..arg[0]:
    let msg = "iter-" & $i
    echo "m1: sending '",msg,"'"
    ch.send(msg)
    sleep(arg[1])
  ch.send("quit")
  echo "m1: finishing"

# }}}
# {{{ m2() -- proc

proc m2() =
  echo "m2: starting"
  while true:
    let msg: string = ch.recv()
    echo "m2: '",msg,"' received"
    if msg == "quit":
      echo "m2: time to leave..."
      break
  echo "m2: finishing"

# }}}
# {{{ main() -- proc

proc main() =
  ch.open()
  spawn m1((20,120))
  spawn m2()
  sync()

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
