# Arrays

Arrays are the workhorse collection of V. This chapter covers the array type, the fixed-size array, how arrays are passed around, and the methods that make them pleasant to work with.

## What an array is

An array is a contiguous growable sequence of values of one type. Its type is written `[]T`, where `T` is the element type:

```v
fn main() {
	mut names := []string{}
	names << 'Ada'
	names << 'Grace'
	names << 'Alan'
	println('${names.len} names, first is ${names[0]}')
	assert names.len == 3
	assert names[0] == 'Ada'
	assert names[2] == 'Alan'
}
```

The `<<` operator appends an element. Appending reallocates when the backing store is full, which is why the array has to be `mut` to append to it.

> **Note**
> Reading `names[0]` is a bounds-checked index. A program that reads past the end panics rather than reading whatever is in memory, so an out-of-range index is a loud bug instead of a silent one.

## Literals

An array literal lists its elements in square brackets. The element type is inferred, or written before the braces:

```v
fn main() {
	scores := [10, 20, 30, 40]
	grades := ['a', 'b', 'c']
	mut grid := [][]int{len: 3, init: []int{len: 3, init: 0}}
	grid[1][1] = 5
	println('${scores.len} ${grades[2]} ${grid[1][1]}')
	assert scores == [10, 20, 30, 40]
	assert grid[1][1] == 5
}
```

`[]T{len: n}` creates an array of `n` zero values, and `[]T{len: n, init: expr}` fills it with the result of the expression. The two-dimensional array above is a nested array, where each row is an array of its own.

## Arrays are values

Copying an array copies its contents, and passing an array to a function passes a copy. A function that wants to change the caller's array takes it as `mut`:

```v
fn push(mut list []int, value int) {
	list << value
}

fn main() {
	mut numbers := [1, 2]
	push(mut numbers, 3)
	println(numbers)
	assert numbers == [1, 2, 3]
}
```

Without `mut` the argument is immutable, and the compiler refuses to compile `list << value` — that error is the language telling you the caller would never see the change.

## Fixed size arrays

A fixed size array has a length known at compile time, lives on the stack when it can, and does not grow. Its type is `[N]T`:

```v
fn main() {
	mut buf := [4]int{}
	buf[0] = 7
	buf[1] = 8
	println(buf[0] + buf[1] + buf[2] + buf[3])
	assert buf[0] == 7
	assert buf[3] == 0
}
```

Use a fixed array for a buffer whose size is part of the specification — a 4-byte header, a 3-component colour, a stack of fixed depth. Use `[]T` for everything that grows.

## Slices

A slice is a view onto the elements of an existing array. It shares the backing store with the original, so writing through a slice writes into the array, but appending to a slice reallocates and leaves the original alone:

```v
fn main() {
	data := [1, 2, 3, 4, 5]
	middle := data[1..4]
	println(middle)
	assert middle == [2, 3, 4]
	assert data[1] == 2
	all := data[..]
	assert all.len == 5
	head := data[..2]
	tail := data[3..]
	assert head == [1, 2]
	assert tail == [4, 5]
}
```

The `all[n]` form drops the first `n` elements, and `..all` means "from `n` to the end".

## Methods worth memorising

The array methods cover most of what a program does to a list:

```v
fn main() {
	mut nums := [5, 3, 9, 1]
	nums.sort()
	assert nums == [1, 3, 5, 9]
	nums.sort(a > b)
	assert nums == [9, 5, 3, 1]
	// reverse returns a copy; reverse_in_place mutates the array.
	flipped := nums.reverse()
	assert flipped == [1, 3, 5, 9]
	nums.reverse_in_place()
	assert nums == flipped
	assert nums == [1, 3, 5, 9]
	evens := nums.filter(it % 2 == 0)
	assert evens == []
	doubled := nums.map(it * 2)
	assert doubled == [2, 6, 10, 18]

	mut total := 0
	for n in nums {
		total += n
	}
	println('${nums.len} elements, sum ${total}')
	assert total == 18

	assert nums.contains(9)
	assert nums.any(it == 3)
	assert nums.all(it > 0)
	assert nums.first() == 1
	assert nums.last() == 9
}
```

`it` is the current element in `filter`, `map` and `any`. `sort` takes an optional comparator, and `sort(a > b)` sorts descending.

## Indexing inside a structure

Because an array is a value, storing one in a struct means storing a copy. To let a method add to a struct's array, the receiver is `mut`, as always:

```v
struct Cart {
mut:
	items []string
}

fn (mut c Cart) add(item string) {
	c.items << item
}

fn main() {
	mut cart := Cart{}
	cart.add('book')
	cart.add('pencil')
	assert cart.items.len == 2
	println(cart.items)
}
```

## Exercises

Try these on your own, then compare with the chapter:

1. Write a function that returns the largest element of an array of `int`, without using `sort`.
2. Build a `[][]int` matrix and write a function that transposes it.
3. Using `filter` and `map` only, turn `[1, 2, 3, 4, 5]` into `[4, 8]`.
