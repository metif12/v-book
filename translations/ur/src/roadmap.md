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

### Stage 1 — The language

- **Install V and run your first program** — the source build, `v run`, what the
  compiler accepts. ([Getting Started](ch01-getting-started.md),
  [Installation](ch01-01-installation.md), [Hello, World!](ch01-02-hello-world.md))
- **Read a program out loud** — the parts of "Hello, V!": string interpolation,
  functions, the shape of a `main.v`. ([Hello, V!](ch01-03-hello-v.md))
- **Set up the workflow** — a project, a `v.mod`, `v fmt -w` on save,
  `v test .`, `v vet .`. ([Building a Project](ch02-building-a-project.md),
  [Testing with v test](ch02-04-testing.md))
- **Learn the core concepts** — variables and mutability, types, functions,
  comments, control flow. This is the chapter to reread, not skim.
  ([Common Concepts](ch03-common-concepts.md))
- **Model data** — structs, methods, embedded structs, enums, sum types, and
  the `match` that ties them together. ([Structs](ch05-structs.md),
  [Enums and Sum Types](ch06-enums-and-sum-types.md))
- **Split a program into modules** — what is public, what a module is, and how
  to import one. ([Modules and Packages](ch07-modules-and-packages.md))

### Stage 2 — Data and errors

- **Work with collections** — arrays and the methods that replace loops, maps
  for lookups, strings without surprises. ([Collections](ch08-collections.md))
- **Fail well** — `?T` for a value that may not exist, `!T` for an operation that
  may fail, and how to write a custom error the caller can match.
  ([Error Handling](ch09-error-handling.md))
- **Understand where your data lives** — stack and heap, the GC modes,
  references. Not needed to write code; needed to write code that stays fast.
  ([Ownership and Memory](ch04-ownership-and-memory.md))

### Stage 3 — Build something a stranger can use

- **Write tests first** — `_test.v`, `test_` functions, and the assert that
  prints both sides. ([Testing](ch11-testing.md))
- **Ship a command-line tool** — arguments, files, stdin and stdout, and the
  shape of a real `main.v`. ([I/O Project](ch12-io-project.md))
- **Use the higher-order tools** — closures, `map`, `filter`, `sort` with a
  comparator. ([Functional Features](ch13-functional-features.md))
- **Use the concurrency model** — goroutines, channels, shared state, and the
  race detector. ([Concurrency](ch14-concurrency.md))
- **Serve HTTP** — routes, JSON, templates, middleware, static files.
  ([Veb Web Framework](ch15-veb-web-framework.md))
- **Call C, and let C call you** — declaring a C function, `#flag`, `#include`,
  shared libraries. ([C Interop](ch16-c-interop.md))

### Stage 4 — Go deeper

- **Generics and comptime** — when a generic earns its keep, and how much code
  moves to compile time. ([Generics](ch10-generics.md),
  [Advanced Features](ch17-advanced-features.md))
- **Memory management in detail** — GC modes, autofree, `-gc none`, and what
  profiling says. ([Memory Management](ch18-memory-management.md),
  [Performance and Benchmarking](ch22-performance-and-benchmarking.md))
- **The toolchain** — `v -check`, `v -profile`, `v doctor`, `v clean`, and VPM.
  ([Tooling](ch19-tooling.md))
- **Ship it** — production builds, cross-compilation, container images.
  ([Cross-Compilation and Deployment](ch21-cross-compilation-and-deployment.md))
- **A whole application** — the capstone. ([Final Project](ch20-final-project.md))

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
