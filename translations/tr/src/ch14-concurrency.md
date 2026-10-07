# Bölüm 14: Eşzamanlılık

V'nin goroutine'ler, kanallar ve paylaşılan durum ile yerleşik eşzamanlılık desteği vardır.

## Goroutine başlatma

Goroutine, hafif bir iş parçacığıdır. `go` anahtar kelimesiyle başlatın:

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

`go` anahtar kelimesi fonksiyonu yeni bir goroutine'de başlatır ve hemen döner. main fonksiyonu kendi başına goroutine'lerin bitmesini beklemez.

Goroutine'leri beklemek için bir `sync.WaitGroup` kullanın:

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

`wg.add(1)`, goroutine başlamadan önce sayacı artırır. `wg.done()`, goroutine bitince sayacı azaltır. `wg.wait()`, sıfıra ulaşana kadar engeller.

## Kanallar

Kanallar, goroutine'ler arasında değer geçirir. `chan T` ile oluşturun:

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

Araçsız bir kanal, alıcı hazır olana kadar gönderimde engeller. Tamponlu bir kanalın kapasitesi vardır ve dolana kadar engellemez:

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

Kanal yönü, kanalın nasıl kullanılabileceğini kısıtlar. `chan<- T` yalnızca gönderme, `<-chan T` yalnızca alım içindir:

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

## Paylaşılan durum

Goroutine'ler değişken durumu paylaştığında, bunu bir `sync.Mutex` ile koruyun:

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

`lock`, mutex kullanılabilir olana kadar engeller, ardından bloğun kapsamı için onu tutar. Kritik bölümü kısa tutun.

Okumalar yazmalardan daha sık olduğunda `sync.RwMutex` kullanın. Aynı anda birden fazla okuyucuya izin verir:

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

Tek bir değer için kilit yerine `sync.stdatomic` atomiklerini kullanın:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## select ifadesi

`sync.channel_select`, birden fazla kanalı bekler ve hazır olan ilk kanalın indeksini döür. Negatif zaman aşımı süresiz bekler; pozitif zaman aşımı zaman aşımında -1 döner:

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

## Özet

Bu bölümde goroutine'ler, kanallar, paylaşılan durum ve select hakkında bilgi edindiniz. Sonraki bölümde Veb web framework'ü inceleyeceğiz.
