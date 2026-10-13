# The V Roadmap

A path through this book, from a first `println` to a program you would put in
front of someone else. Every step names the chapter that teaches it, so the
roadmap and the book can be read together.

## What a V developer builds

V is a statically typed compiled language for maintainable software, with a
standard library that covers most of what a program needs. It compiles to C, so
the binaries are as fast as C and have no runtime to install. Developers use it
for command-line tools, web services, cross-platform utilities, and software
that has to talk to C — drivers, kernels, graphics, embedded.

The role is mostly the work of any compiled language: write the code, keep the
structure simple, test it, profile it, ship one binary. What changes in V is how
little sits between the intent and the machine code.

## The path

Work through the stages in order. Each one ends with something you can run.


```roadmap
Stage 1 — The language
  Install V and run your first program | ch01-01-installation
  Read a program out loud | ch01-02-hello-world
  Set up the workflow: v fmt and v test | ch02-building-a-project
  Learn the core concepts | ch03-common-concepts
  Model data with structs, enums and match | ch05-structs
  Split a program into modules | ch07-modules-and-packages
Stage 2 — Data and errors
  Arrays, maps and the methods that replace loops | ch08-collections
  ?T for a value that may not exist, !T for one that can fail | ch09-error-handling
  Stack, heap and the GC modes | ch04-ownership-and-memory
Stage 3 — Build something a stranger can use
  Tests first: _test.v and assert | ch11-testing
  Ship a command-line tool | ch12-io-project
  Closures, map, filter and sort with a comparator | ch13-functional-features
  Goroutines, channels and shared state | ch14-concurrency
  Routes, JSON, templates, middleware, static files | ch15-veb-web-framework
  Call C, and let C call you | ch16-c-interop
Stage 4 — Go deeper
  Generics and comptime | ch17-advanced-features
  GC modes, autofree and what a profile says | ch18-memory-management
  Measure: stopwatches and v -profile | ch22-performance-and-benchmarking
  The toolchain: v -check, v clean, v doctor | ch19-tooling
  Cross-compile and ship one binary | ch21-cross-compilation-and-deployment
  A whole application | ch20-final-project
```


## Choose a track

The stages above are common to every V program. What you build next depends on
what you want to use V for, and each track reuses different parts of the book.

| Track | What it needs | Where in this book |
|-------|---------------|--------------------|
| CLI tools | `os` module, arguments, exit codes, tests | [I/O Project](ch12-io-project.md), [Testing](ch11-testing.md) |
| Web services | veb, JSON, SQL | [Veb](ch15-veb-web-framework.md) |
| Systems and low level | memory, unsafe, C interop | [C Interop](ch16-c-interop.md), [Memory Management](ch18-memory-management.md) |
| Graphics and games | `gg`, `sokol`, the UI module | [Advanced Features](ch17-advanced-features.md) |
| Scripts and automation | `.vsh`, `os.exec`, `os.system` | [Tooling](ch19-tooling.md) |
| Compilers and metaprogramming | comptime `$for`, `$if`, reflection | [Advanced Features](ch17-advanced-features.md), [Generics](ch10-generics.md) |

## Projects, in order of difficulty

1. **A word counter** — a file in, a table out. Stage 3.
2. **A JSON API with veb and SQLite** — routes, persistence, error handling.
   Stage 3.
3. **A static site generator** — Markdown in, HTML out, a CLI around it. This
   book is one.
4. **A chat server** — goroutines, channels, one port.
5. **A benchmark harness** — stopwatches, `v -profile`, and a report you would
   show someone. Stage 4.

## Frequently asked questions

**Is V used in production?** V is pre-1.0 and the language is stable, but
breaking changes still happen before the 1.0 freeze, and the standard library
grows after it without breaking. Pin a version if you depend on one, and expect
to read a changelog.

**What is V actually good at?** Fast programs with small binaries, code that
stays readable, and calling C. If a project is a command-line tool, a service,
or a piece of machinery that has to talk to an existing C library, V is at its
best there.

**Can I use V for <thing>?** There are veb apps, terminal UIs, graphics
programs, and operating system components written in V. What there is not yet
is a deep package ecosystem: the standard library covers a lot, and VPM is
small, so budget time for the code you would otherwise install.

**How long does this book take?** The documentation for V is designed to be
read in a weekend; this book goes further, with more examples and the reasoning
behind them. Reading and running every chapter is a few evenings of work, not a
few hours.