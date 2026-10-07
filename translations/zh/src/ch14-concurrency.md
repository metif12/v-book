# 第 14 章：并发

V 内置并发支持，包括 goroutine、channel 和共享状态。

## 启动 goroutine

goroutine 是轻量级线程。使用 `go` 关键字启动：

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

`go` 关键字在新 goroutine 中启动函数并立即返回。主函数本身不会等待 goroutine 完成。

要等待 goroutine，使用 `sync.WaitGroup`：

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

`wg.add(1)` 在 goroutine 启动前递增计数器。`wg.done()` 在 goroutine 完成时递减计数器。`wg.wait()` 阻塞直到计数器归零。

## Channel

Channel 在 goroutine 之间传递值。使用 `chan T` 创建：

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

无缓冲 channel 在发送时阻塞，直到接收方就绪。有缓冲 channel 有容量，在满之前不会阻塞：

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

Channel 方向限制 channel 的使用方式。`chan<- T` 仅发送，`<-chan T` 仅接收：

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

## 共享状态

当 goroutine 共享可变状态时，使用 `sync.Mutex` 保护它：

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

`lock` 阻塞直到互斥锁可用，然后在代码块作用域内持有它。保持临界区简短。

当读操作比写操作更频繁时，使用 `sync.RwMutex`。它允许多个读者同时访问：

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

对于单个值，使用 `sync.stdatomic` 中的原子操作代替锁：

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## select 语句

`sync.channel_select` 等待多个 channel，返回第一个就绪的 channel 的索引。负超时无限等待；正超时返回 -1 表示超时：

```v
import sync
import time

fn main() {
    ch := chan int{}
    go fn [ch] () {
        time.sleep(200 * time.millisecond)
        ch <- 42
    }()

    mut chans := [voidptr(ch)]
    mut dirs := [sync.Direction.pop]
    mut objs := [voidptr(&ch)]
    ready := sync.channel_select(mut chans, dirs, mut objs, 100)
    if ready < 0 {
        println('Timed out')
    } else {
        val := <-ch
        println('Got ${val}')
    }
}
```

## 小结

在本章中，你学习了 goroutine、channel、共享状态和 select。在下一章中，我们将探讨 Veb Web 框架。
