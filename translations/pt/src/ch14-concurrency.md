# Capítulo 14: Concorrência

V tem suporte imbutido a concorrência com goroutines, canais e estado compartilhado.

## Criando goroutines

Uma goroutine é uma thread leve. Inicie uma com a palavra-chave `go`:

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

A palavra-chave `go` inicia a função em uma nova goroutine e retorna imediatamente. A função main não espera as goroutines terminarem por conta própria.

Para esperar as goroutines, use um `sync.WaitGroup`:

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

`wg.add(1)` incrementa o contador antes da goroutine iniciar. `wg.done()` decrementa quando a goroutine termina. `wg.wait()` bloqueia até o contador chegar a zero.

## Canais

Canais passam valores entre goroutines. Crie um com `chan T`:

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

Um canal sem buffer bloqueia no envio até que um receptor esteja pronto. Um canal com buffer tem uma capacidade e não bloqueia até encher:

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

A direção do canal restringe como ele pode ser usado. `chan<- T` é apenas para envio, `<-chan T` é apenas para recebimento:

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

## Estado compartilhado

Quando goroutines compartilham estado mutável, proteja-o com um `sync.Mutex`:

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

`lock` bloqueia até o mutex estar disponível, depois o retém pelo escopo do bloco. Mantenha a seção crítica curta.

Use `sync.RwMutex` quando leituras são mais frequentes que escritas. Ele permite múltiplos leitores ao mesmo tempo:

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

Para um único valor, use atomicos de `sync.stdatomic` em vez de um lock:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## Declaração select

`sync.channel_select` espera em múltiplos canais e retorna o índice do primeiro que estiver pronto. Um timeout negativo espera indefinidamente; um timeout positivo retorna -1 em caso de timeout:

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

## Resumo

Neste capítulo, você aprendeu sobre goroutines, canais, estado compartilhado e select. No próximo capítulo, vamos explorar o framework web Veb.
