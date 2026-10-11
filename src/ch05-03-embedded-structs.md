# Embedded Structs

Embedding puts one struct inside another without a field name. The inner struct's fields and methods are promoted to the outer one, which is how V expresses "has a" relationships without inheritance.

## Embedding a value

```v
struct Name {
	first string
	last  string
}

struct Person {
	Name
	age int
}

fn main() {
	p := Person{
		Name: Name{
			first: 'Ada'
			last:  'Lovelace'
		}
		age:   36
	}
	// Promoted fields: they are read as if they were declared on Person.
	println('${p.first} ${p.last}, ${p.age}')
	assert p.first == 'Ada'
	assert p.last == 'Lovelace'
	assert p.age == 36
}
```

A field is promoted only if it is exported — `pub` or the same module. An outer struct also reaches the inner one by name: `p.Name.first`.

## Embedding for methods

The common reason to embed is method promotion. A small reusable type brings its behaviour with it:

```v
struct Timestamp {
	created_at i64
}

fn (t Timestamp) age_seconds(now i64) i64 {
	return now - t.created_at
}

struct Note {
	Timestamp
	text string
}

fn main() {
	note := Note{
		Timestamp: Timestamp{
			created_at: 100
		}
		text:       'buy milk'
	}
	println(note.age_seconds(160))
	assert note.age_seconds(160) == 60
	assert note.text == 'buy milk'
}
```

`Note` now has `text` of its own and `age_seconds` from `Timestamp`, without declaring anything.

## Resolving a name clash

When two embedded types expose the same name, the outer struct's own declaration wins, and the compiler no longer promotes the name implicitly:

```v
struct A {
	value string = 'from A'
}

struct B {
	value string = 'from B'
}

struct Outer {
	A
	B
}

fn main() {
	o := Outer{}
	assert o.A.value == 'from A'
	assert o.B.value == 'from B'
}
```

The fix for a clash is always to be explicit at the point of use: `o.A.value` or `o.B.value`.

## Embedding is not inheritance

An embedded struct is a value inside a struct, not a base class. There is no virtual dispatch: a method call on an embedded value runs that value's own method, and a `Note` cannot be passed where a `Timestamp` is expected unless you pass `note.Timestamp`.

## Exercises

1. Embed a `Rect` into a `Square`-like type and show the promoted method.
2. Write two structs that both embed `Timestamp`, and call `age_seconds` on each.
3. Create a deliberate name clash and fix it by being explicit at the call site.
