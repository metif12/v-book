# Chapter 14: Concurrency

V has built-in concurrency support with goroutines, channels, and shared state.

## Spawning goroutines

A goroutine is a lightweight thread. Start one with the `go` keyword:

```v
fn worker(id int) {
    println('Worker ${id} started')
}

fn main() {
    for i in 0 .. 3 {
        go worker(i)
    }
}
```

The `go` keyword starts the function in a new goroutine and returns immediately. The main function does not wait for goroutines to finish on its own.

To wait for goroutines, use a `sync.WaitGroup`:

```v
import sync

fn worker(id int, mut wg sync.WaitGroup) {
    defer {
        wg.done()
    }
    println('Worker ${id} done')
}

fn main() {
    mut wg := sync.new_waitgroup()
    for i in 0 .. 3 {
        wg.add(1)
        go worker(i, mut wg)
    }
    wg.wait()
    println('All workers finished')
}
```

`wg.add(1)` increments the counter before the goroutine starts. `wg.done()` decrements it when the goroutine finishes. `wg.wait()` blocks until the counter reaches zero.

## Channels

Channels pass values between goroutines. Create one with `chan T`:

```v
fn main() {
    ch := chan int{}
    go fn (ch chan int) {
        ch <- 42
    }(ch)

    result := <-ch
    println(result)
}
```

An unbuffered channel blocks on send until a receiver is ready. A buffered channel has a capacity and does not block until full:

```v
fn main() {
    ch := chan int{cap: 3}
    ch <- 1
    ch <- 2
    ch <- 3
    println(<-ch)
    println(<-ch)
    println(<-ch)
}
```

Channel direction restricts how a channel can be used. `chan<- T` is send-only, `<-chan T` is receive-only:

```v ignore
fn sender(ch chan<- int) {
    ch <- 42
}

fn receiver(ch <-chan int) {
    val := <-ch
    println(val)
}

fn main() {
    ch := chan int{}
    go sender(ch)
    receiver(ch)
}
```

## Shared state

When goroutines share mutable state, protect it with a `sync.Mutex`:

```v
import sync

struct Counter {
mut:
    mu    &sync.Mutex
    count int
}

fn (mut c Counter) add(n int) {
    c.mu.lock()
    c.count += n
    c.mu.unlock()
}

fn (c Counter) get() int {
    c.mu.lock()
    defer {
        c.mu.unlock()
    }
    return c.count
}

fn main() {
    mut c := &Counter{
        mu:    sync.new_mutex()
        count: 0
    }
    c.add(5)
    c.add(3)
    println(c.get())
}
```

`lock` blocks until the mutex is available, then holds it for the scope of the block. Keep the critical section short.

Use `sync.RwMutex` when reads are more frequent than writes. It allows multiple readers at once:

```v
import sync

struct Cache {
mut:
    mu   &sync.RwMutex
    data map[string]int
}

fn (mut c Cache) set(key string, value int) {
    c.mu.lock()
    c.data[key] = value
    c.mu.unlock()
}

fn (c Cache) get(key string) int {
    c.mu.rlock()
    defer {
        c.mu.runlock()
    }
    return c.data[key]
}

fn main() {
    mut c := &Cache{
        mu:   sync.new_rwmutex()
        data: map[string]int{}
    }
    c.set('a', 1)
    c.set('b', 2)
    println(c.get('a'))
    println(c.get('b'))
}
```

For a single value, use atomics from `sync.stdatomic` instead of a lock:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## select statement

`select` waits on multiple channel operations and runs the branch for the first one that is ready:

```v
import time

fn main() {
    ch1 := chan int{}
    ch2 := chan string{}
    go fn [ch1] () {
        time.sleep(200 * time.millisecond)
        ch1 <- 42
    }()
    go fn [ch2] () {
        time.sleep(100 * time.millisecond)
        ch2 <- 'hello'
    }()

    select {
        val := <-ch1 {
            println('Got int ${val}')
        }
        msg := <-ch2 {
            println('Got string ${msg}')
        }
    }
}
```

## Summary

In this chapter, you learned about goroutines, channels, shared state, and select. In the next chapter, we'll explore the Veb web framework.
