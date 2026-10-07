# الفصل 14: التزامن

V لديه دعم مدمج للتزامن مع goroutines والقنوات والحالة المشتركة.

## تشغيل goroutines

goroutine هو خيط خفيف. ابدأ واحداً بالكلمة المفتاحية `go`:

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

الكلمة المفتاحية `go` تبدأ الدالة في goroutine جديد وتعود فوراً. الدالة main لا تنتظر انتهاء goroutines من تلقاء نفسها.

لانتظار goroutines، استخدم `sync.WaitGroup`:

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

`wg.add(1)` يزيد العداد قبل بدء goroutine. `wg.done()` ينقصه عند انتهاء goroutine. `wg.wait()` يُحظر حتى يصل العداد إلى الصفر.

## القنوات (Channels)

القنوات تمرر القيم بين goroutines. أنشئ واحدة بـ `chan T`:

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

القناة غير المخزنة تُحظر عند الإرسال حتى يصبح المُستقبِل جاهزاً. القناة المخزنة لديها سعة ولا تُحظر حتى تمتلئ:

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

اتجاه القناة يقيد كيفية استخدامها. `chan<- T` للإرسال فقط، `<-chan T` للاستقبال فقط:

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

## الحالة المشتركة

عندما تشترك goroutines في حالة قابلة للتغيير، احمِها بـ `sync.Mutex`:

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

`lock` يُحظر حتى يصبح القفل متاحاً، ثم يحتفظ به لنطاق الكتلة. أبقِ القسم الحرج قصيراً.

استخدم `sync.RwMutex` عندما تكون القراءات أكثر تكراراً من الكتابة. يسمح بقراءين متعددين في وقت واحد:

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

## عبارات select

`sync.channel_select` ينتظر على قنوات متعددة ويعيد فهرس أول قناة جاهزة. مهلة سالبة تنتظر إلى أجل غير مسمى؛ مهلة موجبة تعيد -1 عند انتهاء المهلة:

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

## الملخص

في هذا الفصل، تعلمت عن goroutines، القنوات، الحالة المشتركة، و select. في الفصل التالي، سنستكشف إطار عمل Veb للويب.
