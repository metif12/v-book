# 第14章：並行性

Vにはgoroutine、チャネル、共有状態による組み込みの並行性サポートがあります。

## Goroutineの起動

Goroutineは軽量スレッドです。`go`キーワードで開始します：

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

`go`キーワードは新しいgoroutineで関数を開始し、即座に返ります。main関数はgoroutineの完了を自動的には待ちません。

goroutineを待つには、`sync.WaitGroup`を使用します：

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

`wg.add(1)`はgoroutineが開始する前にカウンターをインクリメントします。`wg.done()`はgoroutineが完了したときにデクリメントします。`wg.wait()`はカウンターがゼロになるまでブロックします。

## チャネル

チャネルはgoroutine間で値を渡します。`chan T`で作成します：

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

バッファなしチャネルは受信者が準備できるまで送信をブロックします。バッファ付きチャネルは容量を持ち、いっぱいになるまでブロックしません：

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

チャネルの方向はチャネルの使用方法を制限します。`chan<- T`は送信専用、`<-chan T`は受信専用です：

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

## 共有状態

goroutineが可変状態を共有する場合は、`sync.Mutex`で保護します：

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

`lock`はミューテックスが利用可能になるまでブロックし、ブロックのスコープで保持します。クリティカルセクションは短く保ちます。

読み取りが書き込みよりも頻繁な場合は、`sync.RwMutex`を使用します。複数の読み取りを同時に許可します：

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

単一の値の場合は、ロックの代わりに`sync.stdatomic`からアトミック操作を使用します：

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## select文

`sync.channel_select`は複数のチャネルを待機し、準備ができた最初のチャネルのインデックスを返します。負のタイムアウトは無期限に待機し、正のタイムアウトはタイムアウト時に-1を返します：

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

## まとめ

この章では、goroutine、チャネル、共有状態、selectについて学びました。次の章では、Veb Webフレームワークを見ていきます。
