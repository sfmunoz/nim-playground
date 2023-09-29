#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Fri Sep 29 04:17:10 PM UTC 2023
#
# Compile/run:
#   $ nim c -r except_effect.nim
#
# Refs:
#   - https://nim-lang.org/docs/tut2.html#exceptions
#   - https://nim-lang.org/docs/manual.html#exception-handling
#   - https://nim-lang.org/docs/manual.html#effect-system
#   - <nim-2.0.0>/lib/system/exceptions.nim
#

# {{{ types

type
  #MyError = object of Exception  # Warning: inherit from a more precise exception type like
                                  # ValueError, IOError or OSError.
                                  # If these don't suit, inherit from CatchableError or Defect
  MyError = object of CatchableError   # object of Exception -> usually use this
  MyError2 = object of Defect          # object of Exception -> uncatchable, "panic turned into exception"
                                       # Defect: not tracked with the .raises: [] exception tracking mechanism

# }}}
# ======== macros/procs ========
# {{{ main() -- proc

# Alternative to raise an exception:
#
#   var
#     e: ref OSError
#   new(e)
#   e.msg = "the message"
#   raise e
#

proc main() {.raises: [IOError,OSError].} =  # pragma: prevents other exceptions from being raised (by compiler)
  for i in 1..5:
    echo "==== ",i," ===="
    try:
      case i
      of 1:
        raise newException(OSError,"001")  # OSError = object of CatchableError
      of 2:
        raise newException(IOError,"002")  # IOError = object of CatchableError
      of 3:
        raise newException(LibraryError,"003")  # LibraryError = object of OSError = object of CatchableError
        {.effects.}  # It is a statement that makes the compiler output all inferred effects up to the effects's position
      of 4:
        raise newException(MyError,"004")
      else:
        raise newException(MyError2,"010")
    except IOError as e:
      echo e.msg,": ",e.name," (catch-1)"
      #raise    -> throw it again
    except OSError:
      let
        e = getCurrentException()
        msg = getCurrentExceptionMsg()
      echo msg,"|",e.msg,": ",e.name," (catch-2)"
    except MyError as e:
      echo e.msg,": ",e.name," (catch-3)"
    except MyError2 as e:
      echo e.msg,": ",e.name," (catch-4)"
    except CatchableError as e:    # never reached because order matters: specific cases before
      echo e.msg,": ",e.name," (catch-5)"
    finally:
      echo "999: finally"

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  main()

# }}}
