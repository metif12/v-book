# Kapitel 14: Nebenläufigkeit

V verfügt über integrierte Unterstützung für Nebenläufigkeit mit Goroutines, Channels und Shared State.

## Goroutines starten

Eine Goroutine ist ein leichtgewichtiger Thread. Starten Sie eine mit dem Schlüsselwort `go`:

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

Das Schlüsselwort `go` startet die Funktion in einer neuen Goroutine und kehrt sofort zurück. Die Hauptfunktion wartet nicht von selbst auf den Abschluss der Goroutines.

Um auf Goroutines zu warten, verwenden Sie eine `sync.WaitGroup`:

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

`wg.add(1)` erhöht den Zähler, bevor die Goroutine startet. `wg.done()` verringert ihn, wenn die Goroutine endet. `wg.wait()` blockiert, bis der Zähler null erreicht.

## Channels

Channels übergeben Werte zwischen Goroutines. Erstellen Sie einen mit `chan T`:

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

Ein ungepufferter Channel blockiert beim Senden, bis ein Empfänger bereit ist. Ein gepufferter Channel hat eine Kapazität und blockiert nicht, bis er voll ist:

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

Die Channel-Richtung beschränkt, wie ein Channel verwendet werden kann. `chan<- T` ist nur zum Senden, `<-chan T` nur zum Empfangen:

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

## Shared State

Wenn Goroutines veränderlichen Zustand teilen, schützen Sie ihn mit einer `sync.Mutex`:

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

`lock` blockiert, bis das Mutex verfügbar ist, und hält es dann für den Gültigkeitsbereich des Blocks. Halten Sie den kritischen Abschnitt kurz.

Verwenden Sie `sync.RwMutex`, wenn Lesevorgänge häufiger sind als Schreibvorgänge. Er ermöglicht mehrere Leser gleichzeitig:

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

Für einen einzelnen Wert verwenden Sie Atomics aus `sync.stdatomic` statt eines Locks:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## select-Anweisung

`sync.channel_select` wartet auf mehrere Channels und gibt den Index des ersten zurück, der bereit ist. Ein negativer Timeout wartet unbegrenzt; ein positiver Timeout gibt bei Überschreitung -1 zurück:

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

## Zusammenfassung

In diesem Kapitel haben Sie Goroutines, Channels, Shared State und select kennengelernt. Im nächsten Kapitel untersuchen wir das Veb-Web-Framework.
