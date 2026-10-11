# Exercises

Each exercise names the chapter it belongs to. Try the problem before reading the solution — the solution is written the way it would be written in that chapter, and comparing the two is the point.

## Getting started

**1. Hello with a twist.** Write a program that prints the first command-line argument, or `hello` when there is none. *(Chapter 1)*

```v
import os

fn main() {
	name := if os.args.len > 1 { os.args[1] } else { 'hello' }
	println(name)
	assert name in ['hello', 'world']
}
```

**2. A rectangle.** Write a `Rect` struct with `w` and `h`, and methods `area() int` and `is_square() bool`. *(Chapter 5)*

```v
struct Rect {
	w int
	h int
}

fn (r Rect) area() int {
	return r.w * r.h
}

fn (r Rect) is_square() bool {
	return r.w == r.h
}

fn main() {
	square := Rect{
		w: 3
		h: 3
	}
	wide := Rect{
		w: 4
		h: 2
	}
	assert square.is_square()
	assert !wide.is_square()
	assert wide.area() == 8
}
```

## Common concepts

**3. FizzBuzz, once.** Print the numbers 1 to 15, replacing multiples of 3 with `fizz`, multiples of 5 with `buzz`, and multiples of both with `fizzbuzz`. *(Chapter 3)*

```v
fn main() {
	mut out := []string{}
	for i in 1 .. 16 {
		out << if i % 15 == 0 {
			'fizzbuzz'
		} else if i % 3 == 0 {
			'fizz'
		} else if i % 5 == 0 {
			'buzz'
		} else {
			i.str()
		}
	}
	println(out.join(' '))
	assert out[2] == 'fizz'
	assert out[14] == 'fizzbuzz'
}
```

**4. Count words.** Write a function that takes a sentence and returns a map of word to count, ignoring case. *(Chapter 8)*

```v
import strings

fn word_counts(sentence string) map[string]int {
	mut counts := map[string]int{}
	for word in sentence.split(' ') {
		key := word.trim_string_right('!').to_lower()
		if key != '' {
			counts[key]++
		}
	}
	return counts
}

fn main() {
	counts := word_counts('The cat the Cat!')
	assert counts['the'] == 2
	assert counts['cat'] == 2
	assert counts.len == 2
}
```

## Modules and types

**5. A traffic light.** Model a traffic light as an enum with a method that returns the next state, and a method that says whether it is safe to cross. *(Chapter 6)*

```v
enum Light {
	red
	green
	amber
}

fn (l Light) next() Light {
	return match l {
		.red   { .green }
		.green { .amber }
		.amber { .red }
	}
}

fn (l Light) safe() bool {
	return l == .green
}

fn main() {
	mut l := Light.red
	assert !l.safe()
	l = l.next()
	assert l.safe()
	assert l.next() == .amber
}
```

**6. A linked option.** Write a `?int` function that returns `none` for a non-numeric string, and call it with a default. *(Chapter 9)*

```v
fn parse(text string) ?int {
	if text.len == 0 {
		return none
	}
	for c in text {
		if c < `0` || c > `9` {
			return none
		}
	}
	return text.int()
}

fn main() {
	ok := parse('42') or { -1 }
	bad := parse('4x') or { -1 }
	empty := parse('') or { -1 }
	println('${ok} ${bad} ${empty}')
	assert ok == 42
	assert bad == -1
	assert empty == -1
}
```

## Concurrency

**7. Parallel sum.** Use a `sync.WaitGroup` to sum the elements of an array on two threads, then combine the results. *(Chapter 14)*

```v
import sync

fn worker(wg &sync.WaitGroup, data []int, mut result []int) {
	mut total := 0
	for v in data {
		total += v
	}
	result << total
	wg.done()
}

fn main() {
	wg := sync.new_waitgroup()
	wg.add(2)
	data := [1, 2, 3, 4, 5, 6]
	mut halves := []int{}
	spawn worker(wg, data[..3], mut halves)
	spawn worker(wg, data[3..], mut halves)
	wg.wait()
	total := halves[0] + halves[1]
	println('total ${total}')
	assert total == 21
}
```

## A whole program

**8. The command-line word counter.** Write a tool that takes a file name, counts the lines, words and characters in it, and prints a table. It has to handle a missing file without panicking. *(Chapters 12 and 20)*

```v
import os

struct Stats {
mut:
	lines int
	words int
	chars int
}

fn stats_of(text string) Stats {
	mut s := Stats{}
	for line in text.split_into_lines() {
		s.lines++
		s.words += line.split(' ').filter(it != '').len
		s.chars += line.len + 1
	}
	return s
}

fn main() {
	path := 'stats.txt'
	os.write_file(path, 'one two\nthree\n') or { panic(err) }
	text := os.read_file(path) or { panic(err) }
	s := stats_of(text)
	println('lines ${s.lines} words ${s.words} chars ${s.chars}')
	assert s.lines == 2
	assert s.words == 3
	assert s.chars == 14
}
```

## Where to go next

The exercises above are deliberately small; a chapter of the book ends with three more, sized to the topic. When they are easy, the next step is a project of your own: a tool you want to exist, a server that answers a question, or a port of a small program from another language.
