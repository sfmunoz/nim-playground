#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Fri Sep 29 05:35:06 PM UTC 2023
#
# Compile/run:
#   $ nim c -r dict.nim
#
# Ref:
#   https://nim-lang.org/docs/tables.html
#

# {{{ imports

import std/tables
from std/sequtils import zip

# }}}
# ======== procs ========
# {{{ main() -- proc

proc main() =
  var
    t1 = {1: "one", 2: "two"}.toTable     # Table
    t2 = t1  # object copy
    t3 = {1: "one", 2: "two"}.newTable    # TableRef
    t4 = t3  # reference copy
  t2[5] = "five"
  t4[5] = "five"
  echo "t1: ",t1," (",type t1,")"
  echo "t2: ",t2," (",type t2,")"
  doAssert t1 != t2
  echo "t3: ",t3," (",type t3,")"
  echo "t4: ",t4," (",type t4,")"
  doAssert t3 == t4
  #========
  let
    names = ["aaa","bbb","ccc"]
    count = [100,200,300]
  var recap = initTable[string,int]()     # Table
  for x in zip(names,count):
    let (n,c) = x
    recap[n] = c
  echo "recap: ",recap," (",type recap,")"
  #========
  var chars = newTable[string,int]()      # TableRef
  chars["z"] = 26
  chars["a"] = 22
  echo "chars: ",chars," (",type chars,")"

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
