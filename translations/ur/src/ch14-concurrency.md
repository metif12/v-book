# باب ۱۴: ہم آہنگی

V کے پاس goroutines، چینلز، اور مشترکہ حالت کے ساتھ بلٹ اِن ہم آہنگی کی حمایت ہے۔

## goroutines پیدا کرنا

ایک goroutine ایک ہلکا دھاگہ ہے۔ اسے `go` کی ورڈ سے شروع کریں:

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

`go` کی ورڈ فنکشن کو ایک نئے goroutine میں شروع کرتی ہے اور فوراً واپس آ جاتی ہے۔ main فنکشن خود بخود goroutines کے ختم ہونے کا انتظار نہیں کرتا۔

goroutines کا انتظار کرنے کے لیے، `sync.WaitGroup` استعمال کریں:

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

`wg.add(1)` goroutine کے شروع ہونے سے پہلے کاؤنٹر بڑھاتا ہے۔ `wg.done()` goroutine کے ختم ہونے پر اسے گھٹاتا ہے۔ `wg.wait()` کاؤنٹر کے صفر پر پہنچنے تک روکتا ہے۔

## چینلز

چینلز goroutines کے درمیان قدریں منتقل کرتے ہیں۔ انہیں `chan T` سے بنائیں:

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

ایک بغیر بفر چینل ریسیور تیار ہونے تک بھیجنے پر روکتا ہے۔ ایک بفر چینل کی گنجائش ہوتی ہے اور بھرنے تک نہیں رکتا:

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

چینل کی سمت چینل کے استعمال کو محدود کرتی ہے۔ `chan<- T` صرف بھیجنے والا ہے، `<-chan T` صرف وصول کرنے والا ہے:

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

## مشترکہ حالت

جب goroutines تبدیل پذیر حالت کا اشتراک کرتے ہیں، تو اسے `sync.Mutex` کے ساتھ محفوظ بنائیں:

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

`lock` mutex کی دستیابی تک روکتا ہے، پھر بلاک کے اسکوپ تک اسے تھامتا ہے۔ کریٹیکل سیکشن کو مختصر رکھیں۔

جب پڑھنے کے عمل لکھنے کے عمل سے زیادہ ہوں، تو `sync.RwMutex` استعمال کریں۔ یہ ایک ساتھ متعدد پڑھنے والوں کی اجازت دیتا ہے:

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

ایک واحد قدر کے لیے، لاک کے بجائے `sync.stdatomic` سے ایٹومکس استعمال کریں:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## select بیان

`sync.channel_select` متعدد ڈیٹا ستونوں پر انتظار کرتا ہے اور پہلے تیار ہونے والے کا اشارہ دیتا ہے۔ منفی ٹائم آؤٹ غیر محدود انتظار کرتا ہے؛ مثبت ٹائم آؤٹ ٹائم آؤٹ پر -1 واپس کرتا ہے:

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

## خلاصہ

اس باب میں، آپ نے goroutines، چینلز، مشترکہ حالت، اور select کے بارے میں سیکھا۔ اگلے باب میں، ہم Veb ویب فریم ورک کو دریافت کریں گے۔
