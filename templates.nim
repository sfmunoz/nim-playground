#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Mon Sep 18 05:22:35 PM UTC 2023
#
# Compile/run:
#   $ nim c -r templates.nim
#
# Refs:
#   - https://nim-lang.org/docs/manual.html#templates
#   - https://www.youtube.com/watch?v=TPPVfgJvdNo
#     Nimrod: A new approach to meta programming" by Andreas Rumpf (2013)
#

# {{{ imports

import std/envvars

# }}}
# ======== templates ========
# {{{ int12()

template int12(x: untyped) =
  var x: int = 12

# }}}
# {{{ `&&`()

template `&&`(x: untyped) =
  var x: int = 100

# }}}
# {{{ withFile()

template withFile(f, fn, mode, actions: untyped): untyped =
  var f: File
  if open(f, fn, mode):
    try:
      actions
    finally:
      close(f)
  else:
    quit("cannot open: " & fn)

# }}}
# {{{ typedef()

template typedef(name: untyped, typ: typedesc) =
  # defaults:
  #   - gensym: type, var, let and const
  #   - inject: proc, iterator, converter, template and macro
  #   - template parameter: inject (implicit)
  type
    `T name` {.inject.} = typ
    `P name` {.inject.} = ref `T name`

# }}}
# -------- html -------
# {{{ res (var)

var res: string  # FIXME: used temporarily until 'result' binding problem is solved

# }}}
# {{{ html()

template html(name: untyped, matter: typed) =
  proc name(): string =
    res = "<html>\n"
    matter
    if getEnv("TPL_DEBUG","0") == "1":
      echo "==== html() ===="
      echo astToStr(matter)
      echo "---- html() ----"
    res.add("</html>")
    result = res

# }}}
# {{{ nestedTag()

template nestedTag(tag: untyped) =
  template tag(matter: typed) =
    let tag_str = astToStr(tag)
    res.add("<" & tag_str & ">\n")
    matter
    if getEnv("TPL_DEBUG","0") == "1":
      echo "==== nestedTag(",tag_str,") ===="
      echo astToStr(matter)
      echo "---- nestedTag(",tag_str,") ----"
    res.add("</" & tag_str & ">\n")

# }}}
# {{{ simpleTag()

template simpleTag(tag: untyped) =
  template tag(matter: untyped) =
    let tag_str = astToStr(tag)
    res.add("<" & tag_str & ">" & matter & "</" & tag_str & ">\n")

# }}}
# ======== procs ========
# {{{ main()

proc main() =
  #--------
  int12(twelve)
  echo "twelve ........ ",twelve
  #--------
  &&one_hundred
  echo "one_hundred ... ",one_hundred
  #--------
  withFile(fp, "templates.nim", fmRead):  # special colon
    for i in 1..8:
      echo $i,": ",fp.readLine()
  #--------
  typedef(myint, int)
  var my_int: TMyInt = 771  # also available 'PMyInt'
  echo "my_int ........ ",my_int
  #--------
  nestedTag body
  nestedTag head
  nestedTag ul
  simpleTag title
  simpleTag li
  html mainPage:
    head:
      title "this is the title"
    body:
      ul:
        li "one item"
        li "another item"
  echo mainPage()

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
