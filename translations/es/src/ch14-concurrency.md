# Capítulo 14: Concurrencia

V tiene soporte de concurrencia integrado con goroutines, canales y estado compartido.

## Lanzando goroutines

Una goroutine es un hilo ligero. Iníciala con la palabra clave `go`:

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

La palabra clave `go` inicia la función en una nueva goroutine y retorna inmediatamente. La función main no espera a que las goroutines terminen por sí sola.

Para esperar a las goroutines, usa un `sync.WaitGroup`:

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

`wg.add(1)` incrementa el contador antes de que la goroutine comience. `wg.done()` lo decrementa cuando la goroutine termina. `wg.wait()` bloquea hasta que el contador llega a cero.

## Canales

Los canales pasan valores entre goroutines. Crea uno con `chan T`:

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

Un canal sin buffer bloquea el envío hasta que un receptor esté listo. Un canal con buffer tiene una capacidad y no bloquea hasta que se llena:

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

La dirección del canal restringe cómo se puede usar. `chan<- T` es solo envío, `<-chan T` es solo recepción:

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

## Estado compartido

Cuando las goroutines comparten estado mutable, protégelo con un `sync.Mutex`:

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

`lock` bloquea hasta que el mutex esté disponible, luego lo mantiene durante el ámbito del bloque. Mantén la sección crítica corta.

Usa `sync.RwMutex` cuando las lecturas son más frecuentes que las escrituras. Permite múltiples lectores a la vez:

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

Para un solo valor, usa atomicos de `sync.stdatomic` en lugar de un lock:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## Sentencia select

`sync.channel_select` espera en múltiples canales y devuelve el índice del primero que esté listo. Un timeout negativo espera indefinidamente; un timeout positivo devuelve -1 al agotar el tiempo:

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

## Resumen

En este capítulo, aprendiste sobre goroutines, canales, estado compartido y select. En el siguiente capítulo, exploraremos el framework web Veb.
