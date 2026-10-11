# Enums

An enum is a type with a fixed set of named values. It turns a set of constants into a type the compiler can check, so a function that takes a `Color` cannot be handed a weekday.

## Declaring an enum

```v
enum Direction {
	up
	down
	left
	right
}

fn turn(d Direction) Direction {
	return match d {
		.up { .right }
		.right { .down }
		.down { .left }
		.left { .up }
	}
}

fn main() {
	mut steps := Direction.up
	println(steps)
	steps = turn(steps)
	assert steps == .right
	steps = turn(steps)
	assert steps == .down
}
```

Note the shorthand: inside a `match` branch, `.up` means `Direction.up`. The same shorthand works in an assignment when the type is already known (`steps = .left`).

## Values and conversion

By default the first value is `0` and each following one is one more, so an enum converts to and from `int`:

```v
enum HttpStatus {
	ok        = 200
	not_found = 404
	error     = 500
}

fn main() {
	println(int(HttpStatus.ok))
	assert int(HttpStatus.not_found) == 404
	assert int(HttpStatus.error) == 500
}
```

An enum can also carry strings, which is how a value gets a name that differs from its identifier:

```v
enum LogLevel {
	debug
	info
	warn
	error_
}

fn (l LogLevel) label() string {
	return match l {
		.debug { 'DEBUG' }
		.info { 'INFO' }
		.warn { 'WARN' }
		.error_ { 'ERROR' }
	}
}

fn main() {
	level := LogLevel.warn
	println(level.label())
	assert level.label() == 'WARN'
	assert level.str() == 'warn'
}
```

`error_` is spelled with an underscore because `error` is a V keyword. `str()` returns the identifier as a string.

## Enums as map keys

Enums are hashable, so they work well as map keys — a table of states, or an option list:

```v
enum Theme {
	light
	dark
}

fn main() {
	labels := {
		Theme.light: 'Light'
		Theme.dark: 'Dark'
	}
	println(labels[Theme.dark])
	assert labels[Theme.light] == 'Light'
}
```

## Enums with data

An enum variant can carry a value, which makes it a small sum type. That is covered in [Sum Types](ch06-02-sum-types.md).

## Exercises

1. Model a traffic light as an enum, with a method that returns the next state.
2. Write an enum for the days of the week with a method `is_weekend() bool`.
3. Given `enum Suit { spade heart diamond club }`, write a function that returns every value in a slice.
