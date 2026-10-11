# Installation

V is installed by building it from source. The V repository ships the build script that does it, and the result is a single executable with no runtime to install. This chapter follows the official instructions in [the V repository](https://github.com/vlang/v#installing-v-from-source).

## What you need

- A C toolchain: `make` downloads the Tiny C Compiler for you, so a working `git` and a shell are usually enough. On Ubuntu and Debian you may need the build tools first:

```bash
sudo apt install git build-essential make
```

- On Windows, run `makev.bat` instead of `make` — in CMD, or `./makev.bat` in PowerShell. `makev.bat -msvc` builds with Visual Studio instead.
- On FreeBSD, OpenBSD, NetBSD, DragonFly and Solaris, install GNU `make` and run it as `gmake`.

## Installing V

The preferred method, on Linux, macOS, Windows, the BSDs and WSL alike:

```bash
git clone --depth=1 https://github.com/vlang/v
cd v
make
```

That takes a few seconds. When it finishes, the compiler is the `v` executable in that directory, and `[path to V repo]` can be anywhere.

Run the first example, and the compiler has proven itself:

```bash
./v run examples/hello_world.v
```

On Windows, `v run examples/hello_world.v` in a CMD shell, or `.\v run examples/hello_world.v` in PowerShell.

> **Note**
> Building from source is the method the V documentation recommends, and the one that always produces a working compiler. A distribution's package — `pkg`, `gmake` aside — may lag behind, and the issues people hit are almost always with a stale package rather than with the source build.

## Putting V on your PATH

Typing the full path every time gets old, so put V on the PATH. V ships a command for it: `v symlink`.

On Unix it creates a `v` symlink in `/usr/local/bin`:

```bash
sudo ./v symlink
```

Another directory works too: `./v symlink ~/.local/bin`.

On Windows, open a shell as administrator, `cd` to the V directory, and run:

```bat
v symlink
```

Restart your shell and your editor afterwards, so both pick up the new PATH. There is no need to run `v symlink` again — V stays on the PATH through `v up` and reboots. Only run it again if you move the V repository.

## Checking that it worked

```bash
v version
```

```console
V 0.5.2
```

`v version` prints the version and exits. If it prints a version, the compiler and the C toolchain are both working.

For a stronger check, `v self` compiles the compiler with the compiler it just built:

```bash
v self
```

## Updating V

V is updated often. `v up` pulls the latest sources and rebuilds in place, and it also refreshes the bundled TCC binaries:

```bash
v up
```

No PATH change is needed afterwards — the symlink still points at the same executable.

## When something goes wrong

The V team keeps an [Installation Issues](https://github.com/vlang/v/discussions/categories/installation-issues) discussion board. Search it for your operating system before opening a thread, and include the output of `v doctor`, which prints the compiler version, the git state and the C toolchain details a maintainer needs.

## Exercises

1. Install V from source, run `v version`, then run `v up` and run it again.
2. Run `sudo ./v symlink` (or `v symlink` on Windows), restart your shell, and check that `v` works from your home directory.
3. Build one of the examples, `v examples/word_counter/word_counter.v`, and run it against its sample file.
