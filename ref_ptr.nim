#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Sat Sep 23 06:57:07 AM UTC 2023
#
# Compile/run:
#   $ nim c -r ref_ptr.nim
#

# ======== types ========
# {{{ Class

type
  Class = object
    x: int

# }}}
# {{{ ClassR

type
  ClassR = ref Class

# }}}
# ======== procs ========
# {{{ modif() -- proc

proc modif(o: var Class, v: int) =
  o.x = v

# }}}
# {{{ main() -- proc

proc main() =
  var o1 = Class(x:1)
  var o2 = new Class
  o2.x = 2
  var o3 = ClassR(x:3)
  var o4: ptr Class = addr o1
  echo "o1: ",o1.repr   # o1: Class(x: 1)
  echo "o2: ",o2.repr   # o2: ref Class(x: 2)
  echo "o3: ",o3.repr   # o3: ref Class(x: 3)
  echo "o4: ",o4.repr   # o4: ptr Class(x: 1)
  echo "----"
  modif(o1,11)
  echo "o1: ",o1.repr   # o1: Class(x: 11)
  modif(o2[],22)        # []: dereference
  modif(o3[],33)        # []: dereference
  modif(o4[],44)        # []: dereference
  echo "----"
  echo "o1: ",o1.repr   # o1: Class(x: 44)
  echo "o2: ",o2.repr   # o2: ref Class(x: 22)
  echo "o3: ",o3.repr   # o3: ref Class(x: 33)
  echo "o4: ",o4.repr   # o4: ptr Class(x: 44)

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
