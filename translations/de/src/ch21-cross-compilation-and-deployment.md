# Cross-Compilation and Deployment

A compiled language is worth its keep at the end of the pipeline: one command produces a binary with no runtime to install. This chapter covers targeting other operating systems, building a production binary, and packaging the result.

## Building for the host

Without flags, `v file.v` writes an executable next to the source, and `-o` says where:

```bash
v main.v              # ./main next to main.v
v -o build/app main.v # the path is created if needed
v run main.v          # build, run, and delete the binary afterwards
```

## Targeting another OS

The `-os` flag selects the target operating system, and `-arch` the CPU architecture. V cross-compiles pure V programs on its own:

```bash
v -os windows -arch amd64 -o app.exe main.v
v -os linux   -arch arm64 -o app-linux-arm64 main.v
v -os macos   -arch arm64 -o app-macos-arm64 main.v
```

The three targets tested continuously are `windows`, `linux` and `macos`. Others — `freebsd`, `android`, `ios`, `haiku` and more — are supported, but change over time, so check `v help build-c` for the current list.

> **Note**
> Programs that call C through FFI need a cross toolchain for the target, and the platform files of the standard library follow the target, so a program that reads the registry on Windows still compiles to Linux as long as the call is behind `$if windows`.

Platform-specific code is written with the compile-time `$if` blocks, so a program that behaves differently per OS compiles on all of them:

```v
fn data_dir() string {
	$if windows {
		return 'C:/ProgramData/app'
	} $else $if macos {
		return '/Library/Application Support/app'
	} $else {
		return '/var/lib/app'
	}
}

fn main() {
	println(data_dir())
}
```

The block above is the reason a cross build works at all: the branch for the wrong platform is never emitted, so it never has to compile for that target.

## Production builds

`-prod` turns on the optimisations V has: dead code elimination, tighter generated C, and more aggressive inlining. Warnings become errors in `-prod`, so it doubles as a quality gate:

```bash
v -prod -o app main.v
```

Trade-offs worth knowing:

- Compile time goes up.
- Warnings are errors — fix them rather than silencing them.
- Production mode is not meant for `v -prod run`; build first, then run the binary.

## Custom defines

`-d flag=value` sets a compile-time define, read in V with `$d('flag', default)`. This is how a build carries its version, or turns on a debug path:

```v
fn version() string {
	return $d('version', 'dev')
}

fn main() {
	println('app ${version()}')
}
```

```bash
v -d version=1.4.2 -o app main.v
./app   # app 1.4.2
```

`$if prod { }` and `$if debug { }` are the same mechanism with predefined flags, so expensive checks can live in one branch and disappear from the release build.

## A release pipeline

A typical release for a small command-line tool:

```bash
set -e
v fmt -verify .
v vet .
v -prod -o dist/app-linux-amd64 -os linux -arch amd64 main.v
v -prod -o dist/app-linux-arm64 -os linux -arch arm64 main.v
v -prod -o dist/app-windows-amd64.exe -os windows -arch amd64 main.v
```

Archive each binary with a checksum, and give the files names a user can install without a README. The V repository itself is built this way, which is why one `v` binary works on three operating systems.

## Container images

Since a production binary needs nothing else, the runtime stage is trivial. A multi-stage build keeps the compiler out of the final image:

```dockerfile ignore
FROM vlang/v:latest AS build
WORKDIR /src
COPY . .
RUN v -prod -o /out/server main.v

FROM alpine:3.20
COPY --from=build /out/server /usr/local/bin/server
CMD ["server"]
```

A one-file program plus a couple of static files is a common shape for a container, which is why embedding them in the binary is attractive: `v bin2v assets/public/` turns a directory into a V source file, and the resulting binary has no working-directory surprises.

## Exercises

1. Cross-compile a "hello, world" for Windows from your machine, and check the binary type with `file app.exe`.
2. Add a `-d version=` define to a program and print it from `$d`.
3. Write a program that prints the OS it was *compiled* for, and build it for two targets to compare.
