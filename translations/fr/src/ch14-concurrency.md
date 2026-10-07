# Chapitre 14 : Concurrence

V dispose d'un support intégré de concurrence avec les goroutines, les canaux et l'état partagé.

## Lancer des goroutines

Une goroutine est un thread léger. Démarrez-en une avec le mot-clé `go` :

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

Le mot-clé `go` démarre la fonction dans une nouvelle goroutine et retourne immédiatement. La fonction main n'attend pas que les goroutines se terminent d'elle-même.

Pour attendre les goroutines, utilisez un `sync.WaitGroup` :

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

`wg.add(1)` incrémente le compteur avant le démarrage de la goroutine. `wg.done()` le décrémente lorsque la goroutine se termine. `wg.wait()` bloque jusqu'à ce que le compteur atteigne zéro.

## Canaux

Les canaux transmettent des valeurs entre les goroutines. Créez-en un avec `chan T` :

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

Un canal non tamponné bloque à l'envoi jusqu'à ce qu'un récepteur soit prêt. Un canal tamponné a une capacité et ne bloque pas tant qu'il n'est pas plein :

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

La direction d'un canal restreint son utilisation. `chan<- T` est en écriture seule, `<-chan T` est en lecture seule :

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

## État partagé

Lorsque des goroutines partagent un état mutable, protégez-le avec un `sync.Mutex` :

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

`lock` bloque jusqu'à ce que le mutex soit disponible, puis le conserve pour la portée du bloc. Gardez la section critique courte.

Utilisez `sync.RwMutex` lorsque les lectures sont plus fréquentes que les écritures. Il permet plusieurs lecteurs simultanément :

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

Pour une valeur unique, utilisez les atomiques de `sync.stdatomic` au lieu d'un verrou :

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## Instruction select

`sync.channel_select` attend sur plusieurs canaux et renvoie l'index du premier qui est prêt. Un timeout négatif attend indéfiniment ; un timeout positif renvoie -1 en cas de dépassement :

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

## Résumé

Dans ce chapitre, vous avez appris les goroutines, les canaux, l'état partagé et select. Dans le chapitre suivant, nous explorerons le framework web Veb.
