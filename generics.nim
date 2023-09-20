#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Wed Sep 20 04:47:48 PM UTC 2023
#
# Compile/run:
#   $ nim c -r generics.nim
#
# Ref:
#   https://nim-lang.org/docs/manual.html#generics
#

# ======== types ========
# {{{ TypeClass

type TypeClass = int | string

# }}}
# ======== functions ========
# {{{ sum()

func sum[T:int|float](a,b: T): T = a + b

# }}}
# {{{ mult(int)

func mult(a,b: int): int = a * b

# }}}
# {{{ mult(float)

func mult(a,b: float): float = a * b

# }}}
# {{{ tdesc()

func tdesc(a: typedesc, b: a): a = 2 * b

# }}}
# ======== procs ========
# {{{ main()

proc main() =
  echo "sum(3,4) ............ ",sum(3,4)
  echo "sum(3.3,4.4) ........ ",sum(3.3,4.4)
  echo "sum[float](3,4.4) ... ",sum[float](3,4.4)
  echo "mult(2,5) ........... ",mult(2,5)
  echo "mult(2.1,3.1) ....... ",mult(2.1,3.1)
  echo "mult(6,2.2) ......... ",mult(6,2.2)
  var tc1: TypeClass = "the-var"
  var tc2: TypeClass = 44
  echo "TypeClass - tc1 ..... ",tc1," (",type tc1,")"
  echo "TypeClass - tc2 ..... ",tc2," (",type tc2,")"
  echo "tdesc(int,3) ........ ",tdesc(int,3)
  echo "tdesc(float,3) ...... ",tdesc(float,3)

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
