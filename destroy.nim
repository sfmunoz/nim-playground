#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Sun Sep 17 12:42:25 PM UTC 2023
#
# Compile/run:
#   $ nim c -r destroy.nim
#
# Refs:
#   - https://nim-lang.org/docs/destructors.html
#   - https://nim-lang.org/docs/manual.html#procedures-type-bound-operators
#

# {{{ imports

# The orthodox way:
# import std/logging
import pure/logging

var cl = newConsoleLogger(fmtStr="$datetime [$levelid] ",useStderr=true)
setLogFilter(lvlInfo)
addHandler(cl)

# }}}
# ======== types ========
# {{{ MyClass

type
  MyClassR = ref MyClass
  MyClass = object
    id: string
    val: int

# }}}
# ======== procs ========
# {{{ =destroy()

proc `=destroy`(self: MyClass) =
  info("=destroy",self)

# }}}
# {{{ main()

proc main() =
  let os = MyClass(id:"stack",val:0)
  let oh = MyClassR(id:"heap",val:1)
  info("same id? ",os.id == oh.id)  # force dummy use

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  info("==== BEGIN ====")
  main()
  info("---- END ----")

# }}}
