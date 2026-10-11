# Formatting with v fmt

Formatting is not style any more once a tool enforces it. `v fmt` rewrites a V file to the canonical shape, and the V toolchain expects every file to be in that shape: the compiler, `v vet`, and the standard library all agree on it.

## Running it

```bash
v fmt path/to/file.v
```

Without a path, `v fmt` formats every V file in the current directory and below. `-w`... is not needed: `v fmt` writes by default; `-verify` reports the files that would change without touching them, which is what a CI job wants:

```bash
v fmt -verify .
```

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
- A short function can open its brace on the same line: `fn add(a int, b int) int { return a + b }`.
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

## v vet

`v vet` runs the compiler's own static checks over a file or directory — shadowed variables, unreachable code, and unused results:

```bash
v vet .
```

`v vet` is the check to run before `v test`, because it catches the class of mistake a compiler is allowed to ignore.

## Editor integration

Most editors format on save with a single setting. The rule that matters is the same everywhere: never hand-format, and run `v fmt -verify .` before opening a pull request.

## Exercises

1. Take a file with mixed tabs and spaces and run `v fmt` on it. Read the diff.
2. Run `v fmt -verify .` in your own project and note the output.
3. Run `v vet` on a file with an unused variable and read what it says.
