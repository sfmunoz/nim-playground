#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Wed Sep 20 04:21:49 PM UTC 2023
#
# Compile/run:
#   $ nim c -r macros.nim
#
# Refs:
#   - https://nim-lang.org/docs/manual.html#macros
#   - https://nim-lang.org/docs/tut3.html
#   - https://nim-by-example.github.io/macros/
#

# {{{ imports

import std/[macros, strutils]

# }}}
# ======== macros/procs ========
# {{{ debug() -- macro

macro debug(args: varargs[untyped]): untyped =
  result = nnkStmtList.newTree()
  for n in args:
    result.add newCall("write", newIdentNode("stdout"), newLit(n.repr))
    result.add newCall("write", newIdentNode("stdout"), newLit(": "))
    result.add newCall("writeLine", newIdentNode("stdout"), n)

# }}}
# {{{ html_st() -- proc

proc html_st(n: NimNode, depth: Natural): string =
  #echo "===="
  #echo n.treeRepr
  #echo n.repr," | ",n.kind
  #echo "----"
  result = ""
  if n.kind == nnkIdent:
    result.add spaces(depth) & "<" & n.repr & ">\n"
  for n2 in n.children:
    result.add html_st(n2,depth+1)
  if n.kind == nnkIdent:
    result.add spaces(depth) & "</" & n.repr & ">\n"

# }}}
# {{{ html() -- macro

macro html(head, body: untyped): untyped =
  # dumptree:
  #   html the_page:
  #     head:
  #       title "this is the title"
  #     body:
  #       ul:
  #         li "one item"
  #         li "another item"
  # ----------------------------------------
  # StmtList
  #   Command
  #     Ident "html"
  #     Ident "the_page"
  #     StmtList
  #       Call
  #         Ident "head"
  #         StmtList
  #           Command
  #             Ident "title"
  #             StrLit "this is the title"
  #       Call
  #         Ident "body"
  #         StmtList
  #           Call
  #             Ident "ul"
  #             StmtList
  #               Command
  #                 Ident "li"
  #                 StrLit "one item"
  #               Command
  #                 Ident "li"
  #                 StrLit "another item"

  let buf = "<html>\n" & html_st(body,1) & "</html>"

  # dumptree:
  #   var buf: string = "...html..."
  # ---------------------------------
  # StmtList
  #   VarSection
  #     IdentDefs
  #       Ident "buf"
  #       Ident "string"
  #       StrLit "...html..."

  #result = nnkStmtList.newTree()
  #result.add newNimNode(nnkVarSection).add(
  #  newIdentDefs(ident(head.repr), ident("string"), newLit(buf))
  #)

  result = quote do:
    let `head.repr` = `buf`

  #echo result.treeRepr

# }}}
# {{{ main() -- proc

proc main() =
  echo "--------"
  var
    a: array[0..10, int]
    x = "some string"
  a[0] = 42
  a[1] = 45
  debug(a[0], a[1], x)
  html the_page:
    head:
      title "this is the title"
    body:
      ul:
        li "one item"
        li "another item"
  echo "--------"
  echo the_page
  echo "--------"

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
