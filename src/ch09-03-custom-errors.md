# Custom Errors

V's `error` type is an interface, so a library can return a structured error that carries data instead of a sentence. The caller can then decide what a specific failure means without matching on the message.

## What an error is

`error` is an interface with a message. Any type that implements `msg() string` and `code() int` is an error:

```v
struct ValidationError {
	field   string
	message string
}

fn (e ValidationError) msg() string {
	return 'invalid ${e.field}: ${e.message}'
}

fn (e ValidationError) code() int {
	return 100
}

fn validate_age(age int) ! {
	if age < 0 {
		return ValidationError{
			field:   'age'
			message: 'must not be negative'
		}
	}
}

fn main() {
	validate_age(-1) or {
		if err is ValidationError {
			println('${err.code()}: ${err.msg()}')
		}
	}
}
```

Two methods make a struct an error: `msg() string` returns what the caller sees, and `code() int` returns the numeric code. A function that can fail returns a result: `!` for a result with no success value, or `!T` for a result that carries one.

## Propagating with `or`

`or { }` unwraps the success value or runs its block. Two forms matter: the one that returns the failure upward, and the one that handles it:

```v
struct MenuError {
	missing string
}

fn (e MenuError) msg() string {
	return 'no such dish: ${e.missing}'
}

fn (e MenuError) code() int {
	return 200
}

fn order(dish string) !string {
	if dish == 'pizza' {
		return 'one pizza'
	}
	return MenuError{
		missing: dish
	}
}

fn order_for_table(table string, dish string) !string {
	ordered := order(dish) or { return err }
	return 'table ${table}: ${ordered}'
}

fn main() {
	ok := order_for_table('4', 'pizza') or { 'failed' }
	bad := order_for_table('4', 'soup') or { err.msg() }
	println('${ok} / ${bad}')
	assert ok == 'table 4: one pizza'
	assert bad == 'no such dish: soup'
}
```

`or { return err }` is the whole point of the propagation syntax: it forwards the failure unchanged.

## Turning an error into a value

A `?` return values instead of a result. That is the shape when the caller is going to match on the failure:

```v
fn parse_port(text string) ?int {
	port := text.int()
	if port < 1 || port > 65535 {
		return none
	}
	return port
}

fn main() {
	port := parse_port('8080') or { 0 }
	bad := parse_port('99999') or { 0 }
	println('${port} ${bad}')
	assert port == 8080
	assert bad == 0
}
```

`?int` is an option: either a value, or `none`.

## Matching on an error type

Because a custom error is a struct, a caller can switch on its kind:

```v
struct NotFoundError {
	key string
}

fn (e NotFoundError) msg() string {
	return 'missing ${e.key}'
}

fn (e NotFoundError) code() int {
	return 300
}

struct LockedError {
	until i64
}

fn (e LockedError) msg() string {
	return 'locked until ${e.until}'
}

fn (e LockedError) code() int {
	return 301
}

fn lookup(k string) !string {
	return NotFoundError{
		key: k
	}
}

fn main() {
	lookup('cache') or {
		match err {
			NotFoundError {
				println('missing ${err.key}')
			}
			LockedError {
				println('locked until ${err.until}')
			}
			else {
				println(err.msg())
			}
		}
	}
}
```

A `match` on `err` is exhaustive over the error types the function returns, and the compiler checks the arms cover them.

## Errors vs panics

Panic on a programmer error: an index out of range, a `none` that should be impossible. Return an error for everything a caller could reasonably handle: a missing file, a bad input, a failed request. The standard library panics for contract violations and returns errors for I/O.

## Exercises

1. Write a `ConfigError` that carries the path of a missing config file, and return it from a `load_config(path string) !` function.
2. Write `fn safe_div(a int, b int) ?int` and two call sites: one that propagates, one that substitutes a default.
3. Turn a `!string` function into a `?string` one and note what changes at each call site.
