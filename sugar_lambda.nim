#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Sat Sep 30 06:27:49 AM UTC 2023
#
# Compile/run:
#   $ nim c -r sugar_lambda.nim
#
# Refs:
#   - https://nim-lang.org/docs/sugar.html
#   - https://nim-lang.org/docs/sequtils.html
#

# {{{ imports

import std/[sugar, sequtils, sets, tables]

# }}}
# ======== procs ========
# {{{ applier() -- proc

proc applier(f:(int,int)->int; a,b: int): int = f(a,b)

# }}}
# {{{ main() -- proc

proc main() =
  echo "applier((x,y)=>x+y,8,4) ....... ",applier((x,y)=>x+y,8,4)
  echo "applier((x,y)=>x-y,8,4) ....... ",applier((x,y)=>x-y,8,4)
  echo "applier((x,y)=>x*y,8,4) ....... ",applier((x,y)=>x*y,8,4)
  echo "applier((x,y)=>x div y,8,4) ... ",applier((x,y)=>x div y,8,4)
  let numbers = ["zero","one","two","three","four","five","six"]
  # seq
  let s1 = collect(newSeq):
    for i,x in numbers.pairs:
      if i mod 2 == 0: x
  echo "s1: ",s1," (",type(s1),")"
  doAssert s1 == @["zero","two","four","six"]
  # hash
  let h = collect(initHashSet()):
    for i,x in numbers.pairs:
      if i mod 2 == 0: {x}
  echo " h: ",h," (",type(h),")"
  doAssert h == ["zero","two","four","six"].toHashSet
  # table
  let t = collect(initTable(4)):
    for i,x in numbers.pairs:
      if i mod 2 == 0: {i div 2:x}
  echo " t: ",t," (",type(t),")"
  doAssert t == {0:"zero",1:"two",2:"four",3:"six"}.toTable
  # lambda
  let s2 = toSeq(1..10).map(x => 2*x).filter(x => x mod 6 != 0)
  echo "s2: ",s2," (",type(s2),")"
  doAssert s2 == @[2,4,8,10,14,16,20]
  let s3 = toSeq(1..10).mapIt(2*it).filterIt(it mod 6 != 0)
  echo "s3: ",s3," (",type(s3),")"
  doAssert s3 == @[2,4,8,10,14,16,20]
  let s4 = collect:
    for i in 1..10:
      let j = 2 * i
      if j mod 6 != 0: j
  echo "s4: ",s4," (",type(s4),")"
  doAssert s4 == @[2,4,8,10,14,16,20]
  let s5 = toSeq(1..5).mapIt(3*it)
  echo "s5: ",s5," (",type(s5),")"
  doAssert s5 == @[3,6,9,12,15]
  # folding
  echo "[1,2,3].foldl(a+b) ...... ",[1,2,3].foldl(a+b)
  echo "[1,2,3].foldl(a-b) ...... ",[1,2,3].foldl(a-b)
  echo "[1,2,3].foldl(a+b,10) ... ",[1,2,3].foldl(a+b,10)

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
