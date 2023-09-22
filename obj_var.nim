#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Fri Sep 22 02:55:53 PM UTC 2023
#
# Compile/run:
#   $ nim c -r obj_var.nim
#
# Ref:
#   https://nim-lang.org/docs/tut2.html#object-oriented-programming-object-variants
#

# ======== types ========
# {{{ NodeKind - enum

type
  NodeKind = enum nkInt, nkFloat, nkString, nkAdd, nkSub, nkIf

# }}}
# {{{ Node - ref object

type
  Node = ref object
    case kind: NodeKind
    of nkInt:
      intVal: int
    of nkFloat:
      floatVal: float
    of nkString:
      strVal: string
    of nkAdd, nkSub:
      leftOp, rightOp: Node
    of nkIf:
      condition, thenPart, elsePart: Node

# }}}
# ======== procs ========
# {{{ Node.`$`

proc `$`(self: Node): string =
  result = $self.kind & ": "
  case self.kind:
  of nkInt:
    result.add $self.intVal
  of nkFloat:
    result.add $self.floatVal
  of nkString:
    result.add self.strVal
  of nkAdd:
    result.add "'" & $self.leftOp & "' + '" & $self.rightOp & "'"
  of nkSub:
    result.add "'" & $self.leftOp & "' - '" & $self.rightOp & "'"
  of nkIf:
    result.add "[" & $self.condition & "] ? [" & $self.thenPart & "] : [" & $self.elsePart & "]"

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  var n1 = Node(kind: nkInt, intVal: 3)
  var n2 = Node(kind: nkFloat, floatVal: 1.0)
  var n3 = Node(kind: nkString, strVal: "third-node")
  var n4 = Node(kind: nkAdd, leftOp: n1, rightOp: n2)
  var n5 = Node(kind: nkSub, leftOp: n2, rightOp: n3)
  var n6 = Node(kind: nkIf, condition: n1, thenPart: n4, elsePart: n5)
  echo "(n1) ",$n1
  echo "(n2) ",$n2
  echo "(n3) ",$n3
  echo "(n4) ",$n4
  echo "(n5) ",$n5
  echo "(n6) ",$n6

# }}}
