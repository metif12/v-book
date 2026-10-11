# Defining Structs

A struct groups related values under one name. It is V's way of making a new type that carries data, and it is the shape most of a program's data takes.

## Declaring a struct

```v
struct User {
	name  string
	age   int
	tags  []string
	notes Notes
}

struct Notes {
	count int
}

fn main() {
	u := User{
		name:  'Ada'
		age:   36
		tags:  ['math', 'poetry']
		notes: Notes{
			count: 12
		}
	}
	println('${u.name} is ${u.age}')
	assert u.name == 'Ada'
	assert u.tags.len == 2
	assert u.notes.count == 12
}
```

Field names carry no `:` separator in a literal — the key and value sit on one line, and `v fmt` aligns the names.

## Mutable and immutable fields

A field is immutable by default, which is why `u.name = 'x'` fails on a non-`mut` variable. The `mut:` block in a struct declaration marks every field below it as mutable on a `mut` instance:

```v
struct Counter {
mut:
	value int
}

fn (mut c Counter) bump() {
	c.value++
}

fn main() {
	mut c := Counter{
		value: 10
	}
	c.bump()
	assert c.value == 11
}
```

Without the leading `mut:` the method `bump` would not compile — the receiver's field is read-only.

## Default values

A field default is written in the declaration, and it applies to every instance that does not set it:

```v
struct Options {
mut:
	verbose bool = true
	retries int  = 3
	label   string = 'default'
}

fn main() {
	o := Options{}
	println('${o.verbose} ${o.retries} ${o.label}')
	assert o.retries == 3
	custom := Options{
		retries: 0
		label:   'custom'
	}
	assert custom.retries == 0
	assert custom.label == 'custom'
}
```

A struct with a field that has no default is created with all defaults filled in, so `Options{}` is valid even though not every field is listed.

## Printing and comparing

`println` on a struct prints its fields, and two structs of the same type compare with `==`:

```v
struct Point {
	x int
	y int
}

fn main() {
	a := Point{
		x: 1
		y: 2
	}
	b := Point{
		x: 1
		y: 2
	}
	println(a)
	println(a == b)
	assert a == b
}
```

A struct that contains an array field is not comparable with `==` — arrays compare by identity in that context, so the compiler refuses the comparison. Give such a type a method instead.

## Anonymous structs

A one-off shape does not need a name:

```v
fn describe(p struct {
	x int
	y int
}) string {
	return '(${p.x}, ${p.y})'
}

fn main() {
	p := struct {
		x int
		y int
	}{
		x: 3
		y: 4
	}
	println(describe(p))
	assert describe(p) == '(3, 4)'
}
```

## Exercises

1. Model a rectangle with a method `area() int` and a method `is_square() bool`.
2. Write a `Duration` struct holding seconds and milliseconds, and a method that returns the total in milliseconds.
3. Give a struct a field with a default, then create two instances that differ in one field only.
