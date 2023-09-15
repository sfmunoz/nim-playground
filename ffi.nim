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
# Refs:
#   https://livebook.manning.com/book/nim-in-action/chapter-8/51 (it's a free chapter; Google 'nim ffi')
#   <nim-2.0.0>/lib/std/private/syslocks.nim -> c_malloc()/c_free()
#

# {{{ imports

# The orthodox way:
# import std/logging
import pure/logging, pure/strformat
import std/envvars

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
# {{{ c_malloc()

# ref: lib/std/private/syslocks.nim -> c_malloc()
# c-proto: void *malloc(size_t size);
proc c_malloc(size: csize_t): pointer {.importc: "malloc", header: "<stdlib.h>".}

# }}}
# {{{ c_free()

# ref: lib/std/private/syslocks.nim -> c_free()
# c-proto: void free(void *ptr);
proc c_free(p: pointer) {.importc: "free", header: "<stdlib.h>".}

# }}}
# {{{ main()

proc main() =
  discard printf("printf() .... string = '%s' and int = '%03d'\n", "the_string", 1)
  printf2("printf2() ... string = '%s' and int = '%03d'\n", "the_string", 2)
  let secs = time(nil)
  info("time() ........ ",secs,"s")
  let tm = localtime(addr secs)  # no need to use 'free(tm)': it's static; 'free()' wrapper must be created/used if needed
  info("localtime() ... ",tm.the_hour,":",tm.tm_min)
  let bsize: csize_t = 1024
  let p = c_malloc(bsize)
  let pa = addr p
  info("c_malloc() .... ",p.repr," (",pa.repr,") -> ",bsize," bytes")
  if getEnv("FFI_LEAK","0") == "1":
    warn(&"c_free() ...... leaking '{bsize}' bytes (FFI_LEAK=1): use 'FFI_LEAK=1 valgrind ./ffi' to check the problem")
  else:
    info(&"c_free() ...... freeing '{bsize}' bytes (FFI_LEAK!=1): use 'valgrind ./ffi' to check everything is OK")
    c_free(p)

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  info("==== BEGIN ====")
  main()
  info("---- END ----")

# }}}
