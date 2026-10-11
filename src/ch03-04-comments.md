# Comments

Code explains itself once, to the person writing it. Comments explain it again later, to someone reading it cold. V's comment syntax is minimal, and the conventions below are the ones the standard library follows.

## Line comments

`//` starts a comment that runs to the end of the line:

```v
fn main() {
	// The discount applies to orders over the threshold.
	threshold := 100
	order := 120
	if order > threshold {
		println('Discount applies')
	}
}
```

V has no block comment. A comment that would be four lines long is a hint that the code needs renaming, or that the explanation belongs in the README.

## Documentation comments

A `//` comment placed directly above a declaration is its documentation. `v doc` and `v missdoc` read it, and it is what editors show on hover:

```v
// norm returns the Euclidean length of a point.
fn norm(x f64, y f64) f64 {
	return (x * x + y * y) ** 0.5
}

fn main() {
	println(norm(3, 4))
	assert norm(3, 4) == 5.0
}
```

Doc comments start with the name of the thing they document, in third person present tense: "returns", not "Return". They describe what the caller gets, not how the function works inside.

A module has one documentation comment, at the top of the file, after the `module` line:

```v
// Package shapes is this chapter's example, and it computes areas.
module main

// area returns the area of a circle of radius r.
fn area(r f64) f64 {
	return 3.14159 * r * r
}

fn main() {
	println('${area(2):.2f}')
}
```

The module comment sits between the `module` line and the first declaration, and describes the module as a whole rather than any one function.

> **Note**
> In a `module main` file the doc comment above `fn main` is the program's own description, so keep it to one sentence.

## Marking unfinished work

A `TODO` or `FIXME` comment is a note to the next reader, and editors underline it:

```v
fn main() {
	// TODO: move this constant into the config module.
	limit := 50
	// FIXME: overflow for very large batches.
	mut total := 0
	for i in 1 .. limit {
		total += i
	}
	println(total)
}
```

Keep them next to the line they describe, and include a reason — "TODO: support negative widths (#42)" is a task, "TODO" is a decoration.

## Comments that earn their place

The useful comment says why, because the code already says what:

```v
fn main() {
	// A retry delay that grows with the attempt keeps the service from
	// hammering a dependency that is already struggling.
	for attempt in 1 .. 5 {
		delay_ms := 100 * (1 << (attempt - 1))
		println('attempt ${attempt} waits ${delay_ms} ms')
	}
}
```

The next reader can see that the delay doubles. They cannot see that this is deliberate.

## Exercises

1. Take a comment that restates the code (`i++ // increment i`) and delete it. Repeat until nothing restates the code.
2. Write a doc comment for a function you wrote earlier, in the style `v doc` expects.
3. Run `v doc` on a module you own and check that every exported declaration has a comment.
