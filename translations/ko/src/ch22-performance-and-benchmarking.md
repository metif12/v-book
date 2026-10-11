# Performance and Benchmarking

Optimise what you have measured, and stop when the measurement says you can stop. This chapter shows how to measure a V program, what the numbers usually point at, and which changes are almost always worth making.

## Measure first

A micro-benchmark is a few lines: run the work enough times to swamp the timer's noise, and report the average.

```v
import time

fn sum_slice(s []int) int {
	mut total := 0
	for v in s {
		total += v
	}
	return total
}

fn bench(iters int) (i64, int) {
	data := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	mut sw := time.new_stopwatch()
	mut last := 0
	for _ in 0 .. iters {
		last = sum_slice(data)
	}
	elapsed := sw.elapsed().nanoseconds()
	return elapsed, last
}

fn main() {
	iters := 200000
	elapsed_ns, last := bench(iters)
	println('${iters} iterations in ${elapsed_ns} ns')
	println('${f64(elapsed_ns) / 200000.0:.1f} ns per call, result ${last}')
}
```

Run it several times and take the best number rather than the average: the best is the closest to the truth, because the noise only ever adds time.

## The build matters more than the code

The single biggest win is usually the release build:

```bash
v -prod -o bench bench.v
```

A second, smaller win is the garbage collector mode, chosen with `-gc`. The default mode is fine for most programs; `-gc none` removes the collector entirely and is right for a batch job that allocates nothing, while a long-running service may prefer the opposite setting.

Compare the numbers you get, in that order, before touching a line of code:

```bash
v run bench.v
v -prod -o bench bench.v && ./bench
```

## Where the time usually goes

Four things account for most slow paths in a V program:

1. **Allocation in a loop.** Every `s += 'x'`, every array literal inside a loop, and every string interpolation reallocates.
2. **A copy passed by mistake.** A large struct passed without `&` is copied on every call.
3. **A search that is linear but could be a lookup.** A map key is a hash lookup; a slice scan is `O(n)`.
4. **A collection rebuilt on every use.** Sorting the same slice twice, re-parsing the same file.

## Fixing an allocation in a loop

Building a string with `+=` allocates a new buffer each time. `strings.Builder` grows one buffer instead:

```v
import strings
import time

fn main() {
	sw := time.new_stopwatch()
	mut slow := ''
	for i in 0 .. 20000 {
		slow += '${i},'
	}
	slow_time := sw.elapsed().nanoseconds()

	sw2 := time.new_stopwatch()
	mut b := strings.new_builder(64)
	for i in 0 .. 20000 {
		b.write_string('${i},')
	}
	fast := b.str()
	fast_time := sw2.elapsed().nanoseconds()

	println('+=      ${slow_time} ns')
	println('builder ${fast_time} ns')
	assert fast.len == slow.len
}
```

The same shape applies to arrays: reserving with `arr := []T{cap: n}` and reusing a buffer both avoid repeated growth.

## Passing without copying

A struct of a few dozen bytes is cheap to copy; a struct holding an array, a map, or a long string is not. Passing a reference keeps the call list flat:

```v
struct Report {
mut:
	lines []string
}

fn (mut r Report) add(line string) {
	r.lines << line
}

fn describe(r &Report) string {
	return '${r.lines.len} lines'
}

fn main() {
	mut r := Report{}
	for i in 0 .. 3 {
		r.add('line ${i}')
	}
	println(describe(&r))
	assert r.lines.len == 3
}
```

`&Report` is a read-only reference: the callee cannot change the caller's value, so the copy disappears without the mutability risk.

## Letting the compiler help

`v -warn-about-allocs` prints a warning wherever a value has to be heap-allocated. Run it before a release and read the list; it names the exact lines that allocate:

```bash
v -warn-about-allocs main.v
```

`v -profile profile.txt main.v` writes a per-function profile with call counts and total nanoseconds. Read it from the top: the functions with the largest *total* time are the ones worth work, not the ones with the slowest average.

## A rule of thumb

- Measure once, change one thing, measure again.
- Prefer the algorithm change to the micro-optimisation: a map beats a sorted array scan, and a cleaner loop beats a hint.
- Keep the assertion. A fast program that computes the wrong answer is not fast.

## Exercises

1. Benchmark a function that searches a slice linearly, then the same job with a map, and compare.
2. Rewrite a `s += part` loop with `strings.Builder` and confirm the result is identical with an `assert`.
3. Run `v -profile out.txt` over a program of yours and name the three functions with the highest total time.
