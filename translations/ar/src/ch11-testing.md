# Chapter 11: Testing

V's test framework is built in: a `_test.v` file, functions that start with `test_`, and one command. There is no test runner to install, no assertion library to choose, and no test doubles to wire.

## The shape of a test

A test lives in a file whose name ends in `_test.v`, in a function whose name starts with `test_`:

```v ignore
// math_test.v
module main

fn add(a int, b int) int {
	return a + b
}

fn test_add() {
	assert add(2, 3) == 5
	assert add(-1, 1) == 0
}
```

Run the file, or the directory:

```bash
v math_test.v
v test .
```

A `_test.v` file is compiled as its own program, so it does not affect the normal build at all. That is also why every example in this chapter is a plain `main.v` when it can be: the interesting part — what is being asserted — is the same either way.

## What an assert prints

An `assert` checks that its expression is true, and when it fails the program aborts. The values on each side of a comparison are printed, so an unexpected value names itself:

```v
fn parse_size(text string) int {
	assert text.len > 0, 'the size must not be empty'
	return text.int()
}

fn main() {
	println(parse_size('42'))
	println(parse_size('7'))
}
```

That passes, so run it against something that fails and read the report. The extra message is any string expression, so it can interpolate the loop variable:

```v ignore
for i in 0 .. 100 {
	assert i * 2 < 75 + 10, 'assertion failed for i: ${i}'
}
```

## Asserts that keep going

While prototyping, an assert that aborts hides everything after the first failure. Tag the function with `@[assert_continues]` and every failing assert prints and the function carries on:

```v ignore
@[assert_continues]
fn check(values []int) {
	assert values.len > 2
	assert values[0] == 0
}

fn main() {
	check([1, 2])
}
```

```console
FAIL: fn main.check: assert values.len > 2
FAIL: fn main.check: assert values[0] == 0
```

The command line flag `-assert continues` does the same for every assert in the program, which is what you want while chasing a failing invariant.

> **Note**
> Every `assert` is removed when the program is compiled with `-prod`. Asserts document an invariant during development; they are not a validation layer, and production builds leave them out.

## Test files in detail

Two kinds exist, and the difference is what a test can reach:

- **Internal** tests declare the same module as the code they test — `module main` next to a `module main` program — so they can call private functions. Most of your tests are internal.
- **External** tests import the module they test, so they see only the public API. They are what a module ships to prove its public surface.

A test file may also define `testsuite_begin` and `testsuite_end`, which run before and after all the other tests — the place to open a shared fixture and close it again.

## Tests that can fail

A test function may return an error. If the error propagates out of the function, the test fails, which makes it possible to test the failure path without asserting on the error's type:

```v
import strconv

fn parse_pair(text string) !(int, int) {
	parts := text.split('-')
	if parts.len != 2 {
		return error('expected exactly two numbers')
	}
	return strconv.atoi(parts[0])!, strconv.atoi(parts[1])!
}

fn main() {
	a, b := parse_pair('12-34') or { panic(err) }
	println('${a} ${b}')
	parse_pair('1') or { println('rejected: ${err.msg()}') }
}
```

## Test data

A folder named `testdata` next to your `_test.v` files is ignored by the test runner, so it can hold fixtures: text files to parse, V sources that are deliberately broken, and anything else a test needs to read. `@VEXE` holds the path to the compiler, so a test can even start a second test file of its own:

```v ignore
import os

fn test_subtest() {
	res := os.exec([@VEXE, 'bad_input_test.v'])
	assert res.exit_code == 1
	assert res.output.contains('bad input')
}
```

## Running a subset

```bash
v test .                          # everything below this folder
v test mymodule                   # one module
v -stats test .                   # per-test timing and assertion counts
v test . -run-only test_parse*    # only the matching glob pattern
```

`-run-only` takes a comma separated list of glob patterns, and a `_test.v` file with no matching function is skipped entirely.

## Exercises

1. Write a `_test.v` file for a function you wrote earlier, with a test for the failure path.
2. Tag a test function `@[assert_continues]`, give it three asserts that all fail, and read the whole report.
3. Build a program with `-prod` that contains an `assert` and confirm the assert is gone from the binary.
4. Add a `testdata/` folder with a fixture file, and read it from a test.
