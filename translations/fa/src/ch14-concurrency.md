# فصل ۱۴: همزمانی

V از همزمانی داخلی با goroutine ها، کانال‌ها و حالت مشترک پشتیبانی می‌کند.

## ایجاد goroutine ها

یک goroutine یک نسبک سبک است. آن را با کلمه کلیدی `go` شروع کنید:

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

کلمه کلیدی `go` تابع را در یک goroutine جدید شروع می‌کند و بلافاصله برمی‌گردد. تابع main به خودی خود منتظر نمی‌ماند تا goroutine ها تمام شوند.

برای منتظر ماندن از goroutine ها، از `sync.WaitGroup` استفاده کنید:

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

`wg.add(1)` شمارنده را قبل از شروع goroutine افزایش می‌دهد. `wg.done()` آن را وقتی goroutine تمام می‌شود کاهش می‌دهد. `wg.wait()` تا رسیدن شمارنده به صفر مسدود می‌کند.

## کانال‌ها

کانال‌ها مقادیر را بین goroutine ها منتقل می‌کنند. یکی با `chan T` ایجاد کنید:

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

یک کانال بدون بافر در ارسال تا آماده شدن گیرنده مسدود می‌کند. یک کانال بافر دار ظرفیت دارد  และ تا پر شدن مسدود نمی‌کند:

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

جهت کانال نحوه استفاده از کانال را محدود می‌کند. `chan<- T` فقط ارسال، `<-chan T` فقط دریافت:

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

## حالت مشترک

وقتی goroutine ها حالت قابل تغییر مشترک دارند، آن را با `sync.Mutex` محافظت کنید:

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

`lock` تا در دسترس بودن mutex مسدود می‌کند، سپس آن را برای محدوده بلوک نگه می‌دارد. بخش بحرانی را کوتاه نگه دارید.

از `sync.RwMutex` وقتی خواندن بیشتر از نوشتن استفاده کنید. اجازه می‌دهد چندین خواننده همزمان داشته باشید:

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

برای یک مقدار واحد، به جای قفل از اتمیک‌های `sync.stdatomic` استفاده کنید:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## دستور select

`sync.channel_select` روی چندین کانال منتظر می‌ماند و شاخص اولین کانال آماده را برمی‌گرداند. یک timeout منفی به طور نامحدود منتظر می‌ماند؛ یک timeout مثبت در صورت timeout برمی‌گرداند -1:

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

## خلاصه

در این فصل، درباره goroutine ها، کانال‌ها، حالت مشترک و select یاد گرفتید. در فصل بعد، به فریم‌ورک وب Veb می‌پردازیم.
