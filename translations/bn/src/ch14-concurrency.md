# অধ্যায় 14: কনকারেন্সি

V-তে goroutine, channel এবং শেয়ার্ড স্টেট সহ বিল্ট-ইন কনকারেন্সি সমর্থন আছে।

## goroutine চালু করা

একটি goroutine হল একটি হালকা থ্রেড। `go` কীওয়ার্ড দিয়ে শুরু করুন:

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

`go` কীওয়ার্ড ফাংশনটি একটি নতুন goroutine-এ শুরু করে এবং সঙ্গে সঙ্গে ফিরে আসে। main ফাংশন নিজে থেকে goroutine শেষ হওয়ার জন্য অপেক্ষা করে না।

goroutine-এর জন্য অপেক্ষা করতে, `sync.WaitGroup` ব্যবহার করুন:

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

`wg.add(1)` goroutine শুরুর আগে কাউন্টার বাড়ায়। `wg.done()` goroutine শেষ হলে কাউন্টার কমায়। `wg.wait()` কাউন্টার শূন্য না হওয়া পর্যন্ত ব্লক করে।

## Channel

Channel goroutine-এর মধ্যে মান পাঠায়। `chan T` দিয়ে তৈরি করুন:

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

একটি আনবাফার্ড channel রিসিভার প্রস্তুত না হওয়া পর্যন্ত পাঠানোতে ব্লক করে। একটি বাফার্ড channel-এ একটি ক্যাপাসিটি থাকে এবং পূর্ণ না হওয়া পর্যন্ত ব্লক করে না:

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

Channel দিক channel-এর ব্যবহার সীমাবদ্ধ করে। `chan<- T` শুধুমাত্র পাঠানোর জন্য, `<-chan T` শুধুমাত্র রিসিভ করার জন্য:

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

## শেয়ার্ড স্টেট

যখন goroutine মিউটেবল স্টেট শেয়ার করে, তখন `sync.Mutex` দিয়ে সুরক্ষিত করুন:

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

`lock` mutex পাওয়া না পর্যন্ত ব্লক করে, তারপর ব্লকের স্কোপ পর্যন্ত এটি ধরে রাখে। ক্রিটিক্যাল সেকশন সংক্ষিপ্ত রাখুন।

যখন রিড লেখার চেয়ে বেশি ঘন ঘন হয়, তখন `sync.RwMutex` ব্যবহার করুন। এটি একসাথে একাধিক রিডারের অনুমতি দেয়:

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

একটি একক মানের জন্য, লকের বদলে `sync.stdatomic` থেকে atomics ব্যবহার করুন:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## select স্টেটমেন্ট

`sync.channel_select` একাধিক channel-এ অপেক্ষা করে এবং প্রথম প্রস্তুত channel-এর ইনডেক্স ফেরত দেয়। ঋণাত্মক টাইমআউট অসীমকাল অপেক্ষা করে; ধনাত্মক টাইমআউট টাইমআউট হলে -1 ফেরত দেয়:

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

## সারসংক্ষেপ

এই অধ্যায়ে আপনি goroutine, channel, শেয়ার্ড স্টেট এবং select সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা Veb ওয়েব ফ্রেমওয়ার্ক শিখব।
