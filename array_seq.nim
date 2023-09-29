#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Fri Sep 29 06:01:38 PM UTC 2023
#
# Compile/run:
#   $ nim c -r array_seq.nim
#
# Ref:
#   https://nim-lang.org/docs/manual.html#types-array-and-sequence-types
#

# {{{ types

type
  IntArray = array[0..5, int] # an array that is indexed with 0..5
  IntSeq = seq[int] # a sequence of integers

# }}}
# ======== procs ========
# {{{ main() -- proc

proc main() =
  var
    a1: IntArray
    s1: IntSeq
  a1 = [1, 2, 3, 4, 5, 6]
  s1 = @[1, 2, 3, 4, 5, 6]
  let a2 = [1.0, 2, 3, 4]
  echo "a1: ",a1," (",type a1,")"   # IntArray
  echo "s1: ",s1," (",type s1,")"   # IntSeq
  echo "a2: ",a2," (",type a2,")"   # array[0..3, float64]
  let s2 = newSeq[int]()
  echo "s2: ",s2," (",type s2,")"   # seq[int]
  var a3: array[0..5,int]
  echo "a3: ",a3," (",type a3,")"   # array[0..5, int]
  let a4 = [1,1,1,1,1]
  echo "a4: ",a4," (",type a4,")"   # array[0..4, int]

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
