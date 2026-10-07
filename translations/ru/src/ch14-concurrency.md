# Глава 14: Конкурентность

V имеет встроенную поддержку конкурентности с горутинами, каналами и общим состоянием.

## Запуск горутин

Горутина — это лёгкий поток. Запустите её с помощью ключевого слова `go`:

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

Ключевое слово `go` запускает функцию в новой горутине и немедленно возвращается. Главная функция сама не ждёт завершения горутин.

Чтобы дождаться горутин, используйте `sync.WaitGroup`:

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

`wg.add(1)` увеличивает счётчик перед запуском горутины. `wg.done()` уменьшает его при завершении горутины. `wg.wait()` блокирует выполнение, пока счётчик не достигнет нуля.

## Каналы

Каналы передают значения между горутинами. Создайте канал с помощью `chan T`:

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

Небуферизованный канал блокирует отправку до готовности получателя. Буферизованный канал имеет ёмкость и не блокируется, пока не заполнится:

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

Направление канала ограничивает его использование. `chan<- T` — только отправка, `<-chan T` — только получение:

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

## Общее состояние

Когда горутины разделяют изменяемое состояние, защитите его с помощью `sync.Mutex`:

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

`lock` блокирует выполнение до доступности мьютекса, затем удерживает его в пределах блока. Держите критическую секцию короткой.

Используйте `sync.RwMutex`, когда чтений больше, чем записей. Он позволяет нескольким читателям одновременно:

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

Для одиночного значения используйте атомарные операции из `sync.stdatomic` вместо блокировки:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## Оператор select

`sync.channel_select` ожидает несколько каналов и возвращает индекс первого готового. Отрицательный таймаут означает бесконечное ожидание; положительный таймаут возвращает -1 при истечении времени:

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

## Итоги

В этой главе вы узнали о горутинах, каналах, общем состоянии и select. В следующей главе мы рассмотрим веб-фреймворк Veb.
