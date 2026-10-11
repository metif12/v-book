# Chapter 19: Tooling

The `v` command is a toolchain, not just a compiler. This chapter covers the commands you will actually reach for, and what each one prints.

## v fmt

Formats V source code. `v fmt` writes the formatted source to standard output, so `-w` is what changes the file:

```bash
v fmt -w .                  # every V file here and below
v fmt -w main.v             # one file
cat main.v | v fmt          # from stdin, to stdout
v fmt -diff main.v          # show what would change
v fmt -verify .             # check without writing: the CI form
```

`-verify` and `-c` both check, `-c` being the quicker of the two. `-w` is what you want on save. To leave a block of code exactly as written, wrap it in `// vfmt off` and `// vfmt on`.

## v vet

Reports suspicious code constructs: a shadowed variable, an unused result, unreachable code.

```bash
v vet .
```

`v vet` is about correctness, not shape — run it before `v test`.

## v doc

Generates the documentation of a module from its doc comments. A module is named rather than pointed at:

```bash
v doc strings
v doc -o docs/ strings
```

`v vlib-docs` renders the documentation of every standard library module at once.

## v test

Runs the `_test.v` files of a directory or a file:

```bash
v test .
v test mymodule/mymodule_test.v
```

### Running a specific test

`-run-only` takes a glob pattern, and only the `test_` functions that match run. A file with no matching function is skipped:

```bash
v test . -run-only test_parse*
v test . -run-only test_foo,test_bar
```

### More test options

```bash
v -stats test .             # per-test timing and assertion counts
v test . -test-runner tap   # machine readable output
VTEST_ONLY=strings v test . # only test files whose path contains "strings"
```

## Profiling

Profiling is a build flag rather than a command. `v -profile` instruments the program, writes a profile when it exits, and `-prof` is the shorter spelling:

```bash
v -profile profile.txt run main.v   # write the report to profile.txt
v -prof run main.v                  # print the report to standard output
```

The report has five columns: call count, total time, exclusive time, average time, and the function name. The exclusive time column is what shows where the program actually spends its time, and it is the one to sort on:

```bash
sort -n -k3 profile.txt | tail
```

Useful companions:

```bash
v -profile-fns println,main -profile run main.v   # only these functions and what they call
v -profile-no-inline -profile profile.txt run main.v   # leave @[inline] out of the report
v -d no_profile_startup -profile - run main.v     # leave module init out of the report
```

For a quick measurement, a stopwatch inside the program is often enough — [Performance and Benchmarking](ch22-performance-and-benchmarking.md) has the pattern.

## Checking a build

`-check` is a build flag too: it scans, parses and checks every function without producing a binary.

```bash
v -check .          # the whole project
v -check main.v     # one file
```

It is the fast answer to "does this still compile", and it is what an editor runs on save.

## Cross-compilation

V can compile code for other operating systems and architectures from one machine:

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### Specifying architecture

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

[Cross-Compilation and Deployment](ch21-cross-compilation-and-deployment.md) covers production builds and the release pipeline.

## v doctor

Prints the details a bug report needs: the compiler version, the git state, the environment, and the C toolchain it found.

```bash
v doctor
```

`v env` prints the settings the compiler uses, one per line, with the value V would fall back to when a variable is not set — `VEXE`, `VROOT`, `VOS`, `VARCH`, `VMODULES`, `VTMP`. One name gives just its value, which is what a shell substitution wants:

```bash
v env
v env VMODULES
```

## v up

Updates the V compiler to the latest version, and refreshes the bundled TCC binaries. It reuses the existing PATH, so nothing has to be set up again afterwards:

```bash
v up
v up -prod      # build the updated compiler with optimizations
```

## v clean

A build leaves its executable next to the sources, named after them. `v clean` removes exactly that name, and nothing else:

```bash
v clean .                # remove the binary a `v .` build would write
v clean -n .             # show what it would do
```

## v install and friends

Modules are installed from [VPM](https://vpm.url4e.com) into `~/.vmodules`:

```bash
v install mymodule
v install --path ~/.vmodules mymodule   # a different location
v list                                    # what is installed
v outdated                                # what has an update
v update mymodule                         # update one
v upgrade                                 # update everything
v remove mymodule                         # uninstall
v search mymodule                         # search the registry
v show mymodule                           # details of a published module
v mod why mymodule                        # why a module is in the build graph
```

`v link` symlinks the current project into `~/.vmodules`, which is how you develop a module and use it at the same time. `v unlink` undoes it.

## v tool

`v tool NAME` builds and runs a tool module by name, the way an import would resolve it — no path to remember:

```bash
v tool greet        # run ~/.vmodules/greet, or a checkout beside the project
v tool              # list the tool modules V can see
```

## Summary

In this chapter, you learned the toolchain around the compiler: `v fmt` and `v vet` for a clean tree, `v doc` for documentation, `v test` with `-run-only` for a subset, `v -profile` for a profile and `sort -n -k3` to read it, `v -check` for a fast compile, `-os`/`-arch` for cross-compilation, `v doctor` and `v env` for diagnosis, `v up` for updates, and `v clean` for the binaries a build leaves behind. In the next chapter, we'll build a final project.
