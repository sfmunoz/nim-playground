# NimEx: Nim 2.0 Examples

This repository holds [Nim](https://nim-lang.org/) snippets created while I'm learning the language

## Core

- [destroy.nim](https://github.com/sfmunoz/nimex/blob/main/destroy.nim): destructors behaviour (lifetime-tracking hooks)
  - https://nim-lang.org/docs/destructors.html
  - https://nim-lang.org/docs/manual.html#procedures-type-bound-operators
- [except_effect.nim](https://github.com/sfmunoz/nimex/blob/main/except_effect.nim): exceptions and effects
  - https://nim-lang.org/docs/tut2.html#exceptions
  - https://nim-lang.org/docs/manual.html#exception-handling
  - https://nim-lang.org/docs/manual.html#effect-system
  - [<nim-2.0.0>/lib/system/exceptions.nim](https://github.com/nim-lang/Nim/blob/devel/lib/system/exceptions.nim)
- [ffi.nim](https://github.com/sfmunoz/nimex/blob/main/ffi.nim): foreign function interface example
- [git_config.nim](https://github.com/sfmunoz/nimex/blob/main/git_config.nim): **osproc → execCmdEx()** used to run **git config** commands
- [obj_var.nim](https://github.com/sfmunoz/nimex/blob/main/obj_var.nim): object variants example
  - https://nim-lang.org/docs/tut2.html#object-oriented-programming-object-variants
- [popen.nim](https://github.com/sfmunoz/nimex/blob/main/popen.nim): popen() like example
- [ref_ptr.nim](https://github.com/sfmunoz/nimex/blob/main/ref_ptr.nim): references (ref) and pointers (ptr) example

## Collections

- [array_seq.nim](https://github.com/sfmunoz/nimex/blob/main/array_seq.nim): arrays and sequences
  - https://nim-lang.org/docs/manual.html#types-array-and-sequence-types
    ```
    let a = [1,2,3,4,5,6]     # array[0..5,int]
    var a: array[0..5,int]    # array[0..5,int] → [0,0,0,0,0,0]
    let s = newSeq[int]()     # seq[int]        → @[]
    var s1 = @[1,2,3,4,5,6]   # seq[int]
    ```
- [dict.nim](https://github.com/sfmunoz/nimex/blob/main/dict.nim): dictionaries (tables)
  - https://nim-lang.org/docs/tables.html
    ```
    var t = {1: "one", 2: "two"}.toTable    # Table
    var t = {1: "one", 2: "two"}.newTable   # TableRef
    var t = initTable[string,int]()         # Table
    var t = newTable[string,int]()          # TableRef
    ```
- [hash_sets.nim](https://github.com/sfmunoz/nimex/blob/main/hash_sets.nim): hash-sets / ordered-hash-sets
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

## Threading / parallelism / concurrency

- [threads_ll.nim](https://github.com/sfmunoz/nimex/blob/main/threads_ll.nim): thread example (low-level)
  - https://nim-by-example.github.io/parallelism/
  - https://nim-by-example.github.io/channels/
- [threads_p.nim](https://github.com/sfmunoz/nimex/blob/main/threads_p.nim): thread example (threadpool)
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

## Generics / Templates / Macros

- [generics.nim](https://github.com/sfmunoz/nimex/blob/main/generics.nim): generics related example
  - https://nim-lang.org/docs/manual.html#generics
- [templates.nim](https://github.com/sfmunoz/nimex/blob/main/templates.nim): templates related example
  - https://nim-lang.org/docs/manual.html#templates
  - [Nimrod: A new approach to meta programming" by Andreas Rumpf (2013)](https://www.youtube.com/watch?v=TPPVfgJvdNo)
- [macros.nim](https://github.com/sfmunoz/nimex/blob/main/macros.nim): macros related example
  - https://nim-lang.org/docs/manual.html#macros
  - https://nim-lang.org/docs/tut3.html
  - https://nim-by-example.github.io/macros/
