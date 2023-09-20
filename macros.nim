#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Wed Sep 20 04:21:49 PM UTC 2023
#
# Compile/run:
#   $ nim c -r macros.nim
#
# Ref:
#   https://nim-lang.org/docs/manual.html#macros
#

# {{{ imports

import std/macros

# }}}
# ======== macros ========
# {{{ debug()

macro debug(args: varargs[untyped]): untyped =
  result = nnkStmtList.newTree()
  for n in args:
    result.add newCall("write", newIdentNode("stdout"), newLit(n.repr))
    result.add newCall("write", newIdentNode("stdout"), newLit(": "))
    result.add newCall("writeLine", newIdentNode("stdout"), n)

# }}}
# ======== procs ========
# {{{ main()

proc main() =
  var
    a: array[0..10, int]
    x = "some string"
  a[0] = 42
  a[1] = 45
  debug(a[0], a[1], x)

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
