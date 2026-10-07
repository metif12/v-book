# Bab 14: Konkurensi

V memiliki dukungan konkurensi bawaan dengan goroutine, channel, dan shared state.

## Membuat goroutine

Goroutine adalah thread ringan. Mulai dengan kata kunci `go`:

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

Kata kunci `go` memulai fungsi di goroutine baru dan langsung kembali. Fungsi main tidak menunggu goroutine selesai dengan sendirinya.

Untuk menunggu goroutine, gunakan `sync.WaitGroup`:

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

`wg.add(1)` menaikkan penghitung sebelum goroutine dimulai. `wg.done()` menurunkannya ketika goroutine selesai. `wg.wait()` memblokir sampai penghitung mencapai nol.

## Channel

Channel mengirim nilai antar goroutine. Buat dengan `chan T`:

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

Channel tanpa buffer memblokir pada pengiriman sampai receiver siap. Channel berkapasitas memiliki kapasitas dan tidak memblokir sampai penuh:

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

Arah channel membatasi bagaimana channel dapat digunakan. `chan<- T` hanya untuk mengirim, `<-chan T` hanya untuk menerima:

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

Ketika goroutine berbagi mutable state, lindungi dengan `sync.Mutex`:

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

`lock` memblokir sampai mutex tersedia, lalu memegangnya untuk scope blok tersebut. Jaga critical section tetap pendek.

Gunakan `sync.RwMutex` ketika pembacaan lebih sering daripada penulisan. Ini memungkinkan beberapa pembaca sekaligus:

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

Untuk nilai tunggal, gunakan atomics dari `sync.stdatomic` sebagai ganti lock:

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

`sync.channel_select` menunggu beberapa channel dan mengembalikan index channel pertama yang siap. Timeout negatif menunggu tanpa batas; timeout positif mengembalikan -1 jika timeout:

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

## Ringkasan

Dalam bab ini, Anda telah belajar tentang goroutine, channel, shared state, dan select. Di bab berikutnya, kita akan menjelajahi web framework Veb.
