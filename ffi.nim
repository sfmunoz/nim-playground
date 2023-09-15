#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Fri Sep 15 04:54:36 PM UTC 2023
#
# Compile/run:
#   $ nim c -r ffi.nim
#   $ valgrind ./ffi
#
# Ref (it's a free chapter; Google 'nim ffi'):
#   https://livebook.manning.com/book/nim-in-action/chapter-8/51
#

# {{{ imports

# The orthodox way:
# import std/strformat, std/logging, std/osproc, std/streams
import pure/logging

var cl = newConsoleLogger(fmtStr="$datetime [$levelid] ",useStderr=true)
setLogFilter(lvlInfo)
addHandler(cl)

# }}}
# ======== types ========
# {{{ CTime

type
  CTime = int64  # time_t is a signed integer

# }}}
# {{{ TM

#[
c declaration:
struct tm {
   int tm_sec;
   int tm_min;
   int tm_hour;
   int tm_mday;
   int tm_mon;
   int tm_year;
   int tm_wday;
   int tm_yday;
   int tm_isdst;
};
]#

# there's not need to wrap everything
type
  TM {.importc: "struct tm", header: "<time.h>".} = object
    tm_min: cint
    the_hour {.importc: "tm_hour".}: cint

# }}}
# ======== procs ========
# {{{ printf()

# c-proto: int printf(const char *format, ...);
proc printf(format: cstring): cint {.importc, varargs, header: "stdio.h".}

# }}}
# {{{ printf2()

# c-proto: int printf(const char *format, ...);
proc printf2(format: cstring): cint {.importc: "printf", varargs, header: "stdio.h", discardable.}

# }}}
# {{{ time()

# c-proto: time_t time(time_t *arg);
proc time(arg: ptr CTime): CTime {.importc, header: "<time.h>".}

# }}}
# {{{ localtime()

# c-proto: struct tm *localtime(const time_t *time);
proc localtime(time: ptr CTime): ptr TM {.importc, header: "<time.h>".}

# }}}
# {{{ main()

proc main() =
  discard printf("printf() ...... string = '%s' and int = '%03d'\n", "the_string", 1)
  printf2("printf2() ..... string = '%s' and int = '%03d'\n", "the_string", 2)
  let secs = time(nil)
  echo "time() ........ ",secs,"s"
  let tm = localtime(addr secs)  # no need to use 'free(tm)': it's static; 'free()' wrapper must be created/used if needed
  echo "localtime() ... ",tm.the_hour,":",tm.tm_min

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  info("==== BEGIN ====")
  main()
  info("---- END ----")

# }}}
