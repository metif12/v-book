# Chapter 14: 동시성

V는 고루틴, 채널, 공유 상태를 통해 내장 동시성 지원을 제공합니다.

## 고루틴 생성

고루틴은 경량 스레드입니다. `go` 키워드로 시작합니다:

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

`go` 키워드는 새 고루틴에서 함수를 시작하고 즉시 반환합니다. main 함수는 고루틴이 끝날 때까지 자동으로 기다리지 않습니다.

고루틴을 기다리려면 `sync.WaitGroup`을 사용하세요:

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

`wg.add(1)`는 고루틴이 시작되기 전에 카운터를 증가시킵니다. `wg.done()`은 고루틴이 완료될 때 카운터를 감소시킵니다. `wg.wait()`는 카운터가 0이 될 때까지 블로킹합니다.

## 채널

채널은 고루틴 간에 값을 전달합니다. `chan T`로 생성합니다:

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

버퍼 없는 채널은 수신자가 준비될 때까지 전송을 블로킹합니다. 버퍼 있는 채널은 용량을 가지며 가득 차기 전까지 블로킹하지 않습니다:

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

채널 방향은 채널 사용 방식을 제한합니다. `chan<- T`는 전송 전용, `<-chan T`는 수신 전용입니다:

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

## 공유 상태

고루틴이 가변 상태를 공유할 때는 `sync.Mutex`로 보호하세요:

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

`lock`은 뮤텍스를 사용할 수 있을 때까지 블로킹한 후 블록 스코프 동안 유지합니다. 임계 영역을 짧게 유지하세요.

읽기가 쓰기보다 빈번할 때는 `sync.RwMutex`를 사용하세요. 여러 읽기를 동시에 허용합니다:

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

단일 값의 경우 잠금 대신 `sync.stdatomic`의 아톱을 사용하세요:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## select 문

`sync.channel_select`는 여러 채널을 기다리며 준비된 첫 번째 채널의 인덱스를 반환합니다. 음수 타임아웃은 무한히 기다리고, 양수 타임아웃은 시간 초과 시 -1을 반환합니다:

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

## 요약

이 장에서는 고루틴, 채널, 공유 상태, select에 대해 배웠습니다. 다음 장에서는 Veb 웹 프레임워크를 살펴보겠습니다.
