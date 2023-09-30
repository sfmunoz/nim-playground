#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Sat Sep 30 06:04:14 AM UTC 2023
#
# Compile/run:
#   $ nim c -r hash_sets.nim
#
# Refs:
#   - https://nim-lang.org/docs/sets.html
#     any value that can be hashed, without duplicate entries
#   - https://nim-lang.org/docs/manual.html#types-set-type
#     int8-int16 / uint8/byte-uint16 / char / enum / ordinal subrange types, i.e. range[-10..10]
#

# {{{ imports

import std/sets

# }}}
# ======== procs ========
# {{{ main() -- proc

proc main() =
  let a1 = [4,2,8]
  let s1 = toHashSet([9,5,1])
  let s2 = a1.toHashSet
  var s3 = toOrderedSet(["five","six","seven","eight"])
  var s4: HashSet[string]
  var s5: OrderedSet[string]
  s3.excl("6")
  s3.excl("six")
  echo "a1: ",a1," (",type(a1),")"
  echo "s1: ",s1," (",type(s1),") -> hash=",s1.hash
  echo "s2: ",s2," (",type(s2),") -> hash=",s2.hash
  echo "s3: ",s3," (",type(s3),") contains seven? ",s3.contains("seven")
  s3.clear()
  echo "s3: ",s3," (",type(s3),") contains seven? ",s3.contains("seven")
  echo "s4: ",s4," (",type(s4),") -> hash=",s4.hash
  echo "s5: ",s5," (",type(s5),") -> hash=",s5.hash

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
