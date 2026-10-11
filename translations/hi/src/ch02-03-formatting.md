# Formatting with v fmt

Formatting is not style any more once a tool enforces it. `v fmt` rewrites a V file to the canonical shape, and the V toolchain expects every file to be in that shape: the compiler, `v vet`, and the standard library all agree on it.

## Running it

`v fmt` reads a file or a directory and writes the formatted source to standard output. To change the files, pass `-w`:

```bash
cat main.v | v fmt          # from stdin, to stdout
v fmt main.v                # the formatted source on stdout
v fmt -w main.v             # rewrite the file
v fmt -w .                  # every V file in this directory and below
v fmt -diff main.v          # show what would change
```

To check without touching anything — the form a CI job wants — use `-verify`, or the quicker `-c`:

```bash
v fmt -verify .
```

The documentation recommends setting your editor up so that `v fmt -w` runs on every save. A run is cheap, usually under 30 milliseconds, so there is nothing to wait for.

## What it fixes

Tabs for indentation, spaces around binary operators, one space after a comma, and a blank line between declarations. A file that fails the check is a file somebody else cannot read:

```v
struct Config {
mut:
	debug bool
	path  string
}

fn describe(c Config) string {
	return 'debug=${c.debug} path=${c.path}'
}

fn main() {
	c := Config{
		debug: true
		path:  '/tmp/app'
	}
	println(describe(c))
	assert describe(c) == 'debug=true path=/tmp/app'
}
```

## The style V enforces

- Indentation is a tab.
- Field alignment is left to `v fmt`: consecutive lines of the same struct line up.
- A short function can keep its brace on the same line, as long as the whole body is one statement that fits in 100 columns:
  `fn add(a int, b int) int { return a + b }`.
- String literals may use single or double quotes; a string with a single quote inside uses double quotes.
- Imports are grouped: standard library first, then third-party.

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```

A block that should never be touched — a table laid out by hand, a string with deliberate whitespace — is wrapped in comments:

```v ignore
// vfmt off

some code   that keeps   its shape

// vfmt on
```

`v vet` is a separate command: it reports suspicious constructs — a shadowed variable, an unused result — and it is about correctness rather than shape.

## v vet

`v vet` runs the compiler's own static checks over a file or directory:

```bash
v vet .
```

`v vet` is the check to run before `v test`, because it catches the class of mistake a compiler is allowed to ignore.

## Editor integration

Most editors format on save with a single setting; the setting to look for is `v fmt -w`. The rule that matters is the same everywhere: never hand-format, and run `v fmt -verify .` before opening a pull request.

## Exercises

1. Take a file with mixed tabs and spaces and run `v fmt -w` on it, then `git diff` the result.
2. Run `v fmt -verify .` in your own project and note the output.
3. Wrap a block in `// vfmt off` and `// vfmt on`, run `v fmt -w`, and confirm the block kept its shape.
4. Run `v vet` on a file with an unused variable and read what it says.
