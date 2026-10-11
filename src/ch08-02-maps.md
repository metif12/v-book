# Maps

A map is an unordered collection of key/value pairs. Keys are unique, values are not, and lookups are fast regardless of the size of the map.

## Creating a map

The type of a map is written `map[K]V`, where `K` is the key type and `V` the value type. Keys have to be hashable: strings, integers, booleans and enums all are, while arrays and maps are not.

```v
fn main() {
	mut ages := map[string]int{}
	ages['Ada'] = 36
	ages['Grace'] = 45
	assert ages['Ada'] == 36
	assert ages.len == 2
	println('${ages.len} people, Ada is ${ages['Ada']}')
}
```

Reading a key that was never set returns the zero value of `V`, so `ages['Nobody']` is `0`. That behaviour is deliberate: it lets a counter be written as `m[k]++` without a check first. When you need to know whether a key was set, use the `in` operator or an indexing expression with a result:

```v
fn main() {
	ages := {
		'Ada':  36
		'Grace': 45
	}
	if 'Ada' in ages {
		println('Ada is in the map')
	}
	assert 'Ada' in ages
	assert 'Alan Turing' !in ages
}
```

A map literal is written `{key: value, ...}` with the keys and values on their own lines when the map is long.

## Writing and reading

Writing to a map needs `mut`, and the value is replaced if the key already exists:

```v
fn main() {
	mut capitals := map[string]string{}
	capitals['france'] = 'paris'
	capitals['japan'] = 'tokyo'
	capitals['france'] = 'PARIS'
	assert capitals['france'] == 'PARIS'
	assert capitals.len == 2
}
```

To read a value only when it exists, index with an optional result:

```v
fn main() {
	capital := {
		'france': 'paris'
	}
	name := capital['france'] or { 'unknown' }
	missing := capital['japan'] or { 'unknown' }
	println('${name} / ${missing}')
	assert name == 'paris'
	assert missing == 'unknown'
}
```

## Values of any type

A map value can itself be a collection, which is how grouping is usually written:

```v
fn group_by_length(words []string) map[int][]string {
	mut out := map[int][]string{}
	for word in words {
		out[word.len] << word
	}
	return out
}

fn main() {
	groups := group_by_length(['a', 'to', 'of', 'go', 'be'])
	println(groups[1])
	assert groups[1] == ['a']
	assert groups[2] == ['to', 'of', 'go', 'be']
}
```

`out[word.len] << word` works because a missing key reads as an empty array, which `<<` then fills. The same shape counts occurrences:

```v
fn count_chars(s string) map[rune]int {
	mut counts := map[rune]int{}
	for c in s.runes() {
		counts[c]++
	}
	return counts
}

fn main() {
	counts := count_chars('aab')
	assert counts[`a`] == 2
	assert counts[`b`] == 1
	println('a: ${counts[`a`]}')
}
```

## Iterating

`for k, v in m` yields pairs, and `for v in m` yields values only. The order of iteration is not defined, so never write code that depends on it — collect the keys and sort them when the output has to be stable:

```v
fn main() {
	prices := {
		'book':   12
		'pencil': 2
	}
	mut keys := prices.keys()
	keys.sort()
	for key in keys {
		println('${key}: ${prices[key]}')
	}
	assert prices.keys().len == 2
	mut total := 0
	for _, price in prices {
		total += price
	}
	assert total == 14
}
```

## Deleting and resizing

`delete(key)` removes an entry, `clear()` empties the map, and both are `mut` methods:

```v
fn main() {
	mut cache := map[string]int{}
	for i in 0 .. 4 {
		cache['k${i}'] = i
	}
	assert cache.len == 4
	cache.delete('k1')
	assert cache.len == 3
	assert 'k1' !in cache
	cache.clear()
	assert cache.len == 0
}
```

## Maps as struct fields

A map field is a reference type, so a struct that holds a map shares the map with whoever else holds it. That is what makes a counter type simple:

```v
struct WordCount {
mut:
	counts map[string]int
}

fn (mut w WordCount) add(word string) {
	w.counts[word]++
}

fn (mut w WordCount) total() int {
	mut n := 0
	for _, c in w.counts {
		n += c
	}
	return n
}

fn main() {
	mut wc := WordCount{}
	wc.add('the')
	wc.add('cat')
	wc.add('the')
	assert wc.counts['the'] == 2
	assert wc.total() == 3
	println('total words: ${wc.total()}')
}
```

## Exercises

1. Write `fn invert(m map[string]int) map[int]string`.
2. Write a function that reports the most common word in a slice of strings.
3. Explain why `map[[]int]bool` is not a valid type.
