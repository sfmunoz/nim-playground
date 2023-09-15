#
# vim: set foldmethod=marker:
#
# URL:  https://github.com/sfmunoz/nimex
# Date: Fri Sep 15 03:51:37 PM UTC 2023
#
# Compile/run:
#   $ nim c -r git_config.nim
#

# {{{ imports

# Orthodox: use 'std' instead of 'pure'
import pure/[strformat, logging, osproc, os]

var cl = newConsoleLogger(fmtStr="$datetime [$levelid] ",useStderr=true)
setLogFilter(lvlInfo)
addHandler(cl)

# }}}
# ======== procs ========
# {{{ main()

proc main() =
  let bin_path = getAppDir()
  let sh_script = &"""
set -e
set -x
cd "{bin_path}"
pwd
test -d .git
test -f README.md
test -f git_config.nim
test -f popen.nim
git config user.name sfmunoz
git config user.email 46285520+sfmunoz@users.noreply.github.com
git config user.name
git config user.email
cat ./.git/config
git log --format=fuller -n 1
"""
  let res = execCmdEx("bash", {poEchoCmd, poStdErrToStdOut}, nil, "", sh_script)
  echo res.output
  doAssert res.exitCode == 0

# }}}
# ======== main ========
# {{{ main

when isMainModule:
  info("==== BEGIN ====")
  main()
  info("---- END ----")

# }}}
