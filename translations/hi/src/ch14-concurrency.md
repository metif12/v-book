# अध्याय 14: कॉनकरेंसी

V में goroutines, channels और शेयर्ड स्टेट के साथ बिल्ट-इन कॉनकरेंसी सपोर्ट है।

## Goroutines स्पॉन करना

एक goroutine एक हल्का थ्रेड है। `go` कीवर्ड के साथ शुरू करें:

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

`go` कीवर्ड फ़ंक्शन को एक नए goroutine में शुरू करता है और तुरंत रिटर्न करता है। main फ़ंक्शन स्वयं goroutines के समाप्त होने की प्रतीक्षा नहीं करता।

Goroutines की प्रतीक्षा के लिए, `sync.WaitGroup` का उपयोग करें:

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

`wg.add(1)` goroutine शुरू होने से पहले काउंटर बढ़ाता है। `wg.done()` goroutine समाप्त होने पर इसे घटाता है। `wg.wait()` काउंटर शून्य तक पहुंचने तक ब्लॉक करता है।

## Channels

Channels goroutines के बीच मान पास करते हैं। `chan T` के साथ एक बनाएं:

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

एक unbuffered channel रिसीवर तैयार होने तक सेंड पर ब्लॉक करता है। एक buffered channel की क्षमता होती है और भरने तक ब्लॉक नहीं करता:

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

Channel दिशा channel के उपयोग को प्रतिबंधित करती है। `chan<- T` केवल सेंड के लिए है, `<-chan T` केवल रिसीव के लिए है:

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

## शेयर्ड स्टेट

जब goroutines म्यूटेबल स्टेट साझा करते हैं, उसे `sync.Mutex` के साथ सुरक्षित करें:

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

`lock` mutex उपलब्ध होने तक ब्लॉक करता है, फिर ब्लॉक के स्कोप के लिए इसे धारण करता है। क्रिटिकल सेक्शन को छोटा रखें।

जब रीड्स राइट्स से अधिक बार होते हैं, `sync.RwMutex` का उपयोग करें। यह एक साथ कई रीडर्स की अनुमति देता है:

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

एकल मान के लिए, लॉक के बजाय `sync.stdatomic` से atomics का उपयोग करें:

```v
import sync.stdatomic

fn main() {
    mut counter := stdatomic.new_atomic(u64(0))
    counter.add(1)
    counter.add(1)
    println(counter.load())
}
```

## select स्टेटमेंट

`sync.channel_select` कई channels पर प्रतीक्षा करता है और पहले तैयार channel का इंडेक्स रिटर्न करता है। एक नकारात्मक टाइमआउट अनिश्चित काल तक प्रतीक्षा करता है; एक सकारात्मक टाइमआउट टाइमआउट पर -1 रिटर्न करता है:

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

## सारांश

इस अध्याय में, आपने goroutines, channels, शेयर्ड स्टेट और select के बारे में सीखा। अगले अध्याय में, हम Veb वेब फ्रेमवर्क का पता लगाएंगे।
