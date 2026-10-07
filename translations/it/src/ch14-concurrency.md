# Capitolo 14: Concorrenza

V ha supporto integrato per la concorrenza con goroutine, canali e stato condiviso.

## Avviare goroutine

Una goroutine è un thread leggero. Si avvia con la parola chiave `go`:

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

La parola chiave `go` avvia la funzione in una nuova goroutine e ritorna immediatamente. La funzione main non attende che le goroutine termino da sola.

Per attendere le goroutine, usa un `sync.WaitGroup`:

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

`wg.add(1)` incrementa il contatore prima che la goroutine si avvii. `wg.done()` lo decrementa quando la goroutine termina. `wg.wait()` blocca finché il contatore non raggiunge zero.

## Canali

I canali passano valori tra goroutine. Si creano con `chan T`:

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

Un canale senza buffer blocca l'invio finché un ricevitore non è pronto. Un canale con buffer ha una capacità e non blocca finché non è pieno:

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

La direzione del canale limita come può essere usato. `chan<- T` è solo invio, `<-chan T` è solo ricezione:

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

## Stato condiviso

Quando le goroutine condividono stato mutabile, proteggilo con un `sync.Mutex`:

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

`lock` blocca finché il mutex non è disponibile, poi lo mantiene per lo scope del blocco. Mantieni breve la sezione critica.

Usa `sync.RwMutex` quando le letture sono più frequenti delle scritture. Permette più lettori contemporaneamente:

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

Per un singolo valore, usa le atomiche da `sync.stdatomic` invece di un lock:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## Istruzione select

`sync.channel_select` attende su più canali e ritorna l'indice del primo che è pronto. Un timeout negato attende indefinitamente; un timeout positivo ritorna -1 in caso di timeout:

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

## Riassunto

In questo capitolo, hai imparato le goroutine, i canali, lo stato condiviso e select. Nel prossimo capitolo, esploreremo il framework web Veb.
