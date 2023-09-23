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
  #echo spaces(depth),n.kind
  #echo "----"
  result = ""
  let cc = n.kind == nnkCall or n.kind == nnkCommand
  let lit = cc and n.len > 1 and n[1].kind == nnkStrLit
  if cc:
    assert n[0].kind == nnkIdent
    let extra = if lit: n[1].strVal else: "\n"
    result.add spaces(depth) & "<" & n[0].repr & ">" & extra
  for n2 in n.children:
    result.add html_st(n2,depth+1)
  if cc:
    let extra = if lit: "" else: spaces(depth)
    result.add extra & "</" & n[0].repr & ">\n"

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

  let res = "<html>\n" & html_st(body,1) & "</html>"

  # dumptree:
  #   let buf: string = "...html..."
  # ---------------------------------
  # StmtList
  #   LetSection
  #     IdentDefs
  #       Ident "buf"
  #       Ident "string"
  #       StrLit "...html..."

  # Option 1:
  #result = nnkStmtList.newTree()
  #result.add newNimNode(nnkLetSection).add(
  #  newIdentDefs(ident(head.repr), ident("string"), newLit(buf))
  #)

  # Option 2:
  result = quote do:
    let `head.repr` = `res`

  echo result.treeRepr

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
