# Nim Playground

This repository holds [Nim](https://nim-lang.org/) snippets created while I'm learning the language

- [TL;DR](#tldr)
- [Core](#core)
- [HTTP](#http)
- [Collections](#collections)
- [Generics / Templates / Macros](generics-templates-macros)
- [Threading / parallelism / concurrency](threading-parallelism-concurrency)
- [TODO](#todo)

## TL;DR

```
$ git clone https://github.com/sfmunoz/nim-playground.git

$ cd nim-playground

$ nim c -r destroy.nim

$ nim c -r except_effect.nim

(...)
```

## Core

- [destroy.nim](destroy.nim): destructors behaviour (lifetime-tracking hooks)
  - https://nim-lang.org/docs/destructors.html
  - https://nim-lang.org/docs/manual.html#procedures-type-bound-operators
- [except_effect.nim](except_effect.nim): exceptions and effects
  - https://nim-lang.org/docs/tut2.html#exceptions
  - https://nim-lang.org/docs/manual.html#exception-handling
  - https://nim-lang.org/docs/manual.html#effect-system
  - [<nim-2.0.0>/lib/system/exceptions.nim](https://github.com/nim-lang/Nim/blob/devel/lib/system/exceptions.nim)
- [ffi.nim](ffi.nim): foreign function interface example
- [git_config.nim](git_config.nim): **osproc → execCmdEx()** used to run **git config** commands
- [obj_var.nim](obj_var.nim): object variants example
  - https://nim-lang.org/docs/tut2.html#object-oriented-programming-object-variants
- [popen.nim](popen.nim): popen() like example
- [ref_ptr.nim](ref_ptr.nim): references (ref) and pointers (ptr) example

## HTTP

- [httpd_mummy.nim](httpd_mummy/src/httpd_mummy.nim): HTTP server based
  - [Mummy](https://github.com/guzba/mummy): a multi-threaded HTTP 1.1 and WebSocket server written entirely in Nim
  - [httpd_mummy.nimble](httpd_mummy/httpd_mummy.nimble)

## Collections

- [array_seq.nim](array_seq.nim): arrays and sequences
  - https://nim-lang.org/docs/manual.html#types-array-and-sequence-types
    ```
    let a = [1,2,3,4,5,6]     # array[0..5,int]
    var a: array[0..5,int]    # array[0..5,int] → [0,0,0,0,0,0]
    let s = newSeq[int]()     # seq[int]        → @[]
    var s1 = @[1,2,3,4,5,6]   # seq[int]
    ```
- [dict.nim](dict.nim): dictionaries (tables)
  - https://nim-lang.org/docs/tables.html
    ```
    var t = {1: "one", 2: "two"}.toTable    # Table
    var t = {1: "one", 2: "two"}.newTable   # TableRef
    var t = initTable[string,int]()         # Table
    var t = newTable[string,int]()          # TableRef
    ```
- [hash_sets.nim](hash_sets.nim): hash-sets / ordered-hash-sets
  - https://nim-lang.org/docs/sets.html: any value that can be hashed, without duplicate entries
  - https://nim-lang.org/docs/manual.html#types-set-type: int8-int16 / uint8/byte-uint16 / char / enum / ordinal subrange types, i.e. range[-10..10]
    ```
    let a1 = [4,2,8]
    let s1 = toHashSet([9,5,1])
    let s2 = a1.toHashSet
    let s3 = toOrderedSet(["five","six","seven","eight"])
    let s4: HashSet[string]
    let s5: OrderedSet[string]
    ```
- [sugar_lambda.nim](sugar_lambda.nim): lambda, map, filter, folding
  - https://nim-lang.org/docs/sugar.html
  - **https://nim-lang.org/docs/sequtils.html**

## Generics / Templates / Macros

- [generics.nim](generics.nim): generics related example
  - https://nim-lang.org/docs/manual.html#generics
- [templates.nim](templates.nim): templates related example
  - https://nim-lang.org/docs/manual.html#templates
  - [Nimrod: A new approach to meta programming" by Andreas Rumpf (2013)](https://www.youtube.com/watch?v=TPPVfgJvdNo)
- [macros.nim](macros.nim): macros related example
  - https://nim-lang.org/docs/manual.html#macros
  - https://nim-lang.org/docs/tut3.html
  - https://nim-by-example.github.io/macros/

## Threading / parallelism / concurrency

- [threads_ll.nim](threads_ll.nim): thread example (low-level)
  - https://nim-by-example.github.io/parallelism/
  - https://nim-by-example.github.io/channels/
- [threads_p.nim](threads_p.nim): thread example (threadpool)
  - https://nim-by-example.github.io/parallelism/
  - https://nim-by-example.github.io/channels/

```
$ diff -U0 threads_ll.nim threads_p.nim
(...)
@@ -17 +17 @@
-import std/os
+import threadpool, std/os
@@ -24,2 +23,0 @@
-  t1: Thread[(int,int)]
-  t2: Thread[void]
@@ -59,5 +57,3 @@
-  createThread(t1,m1,(20,200))
-  createThread(t2,m2)
-  #joinThreads(t1,t2)  # cannot be used: different types
-  joinThreads(t1)
-  joinThreads(t2)
+  spawn m1((20,120))
+  spawn m2()
+  sync()
```

## TODO

- http client
- http server
- command line parser
- system.nim
- logger
- [Type erasure](https://en.wikipedia.org/wiki/Type_erasure) with Nim → [cgarciae/erasure.nim](https://gist.github.com/cgarciae/9b7f5d456e8aed3181f8b30f13de2f01)
