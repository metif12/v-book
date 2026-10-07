# অধ্যায় 18: মেমোরি ম্যানেজমেন্ট গভীরে

## GC মোড

V বিভিন্ন ব্যবহারিক ক্ষেত্রে উপযোগী একাধিক মেমোরি ম্যানেজমেন্ট কৌশল প্রদান করে।

| মোড | ফ্ল্যাগ | ব্যবহারিক ক্ষেত্র |
|------|------|----------|
| Boehm GC | `-gc boehm` | সাধারণ উদ্দেশ্য |
| অটোফ্রি | `-autofree` | স্বয়ংক্রিয় ফ্রি |
| কোনোটি নেই | `-gc none` | ম্যানুয়াল ম্যানেজমেন্ট |
| প্রিঅ্যালোক | `-prealloc` | অ্যারেনা অ্যালোকেশন |

## স্ট্যাক বনাম হিপ

V স্বয়ংক্রিয়ভাবে সিদ্ধান্ত নেয় মেমোরি কোথায় অ্যালোকেট হবে। ছোট, স্বল্পমেয়াদী মান স্ট্যাকে থাকে। বড় বা এস্কেপ করা মান হিপে যায়।

```v
fn stack_example() int {
    x := 42
    y := x * 2
    return y
}

fn heap_example() []int {
    data := []int{len: 100, init: 0}
    return data
}

fn main() {
    a := stack_example()
    b := heap_example()
    println(a)
    println(b.len)
}
```

## অটোফ্রি মোড

অটোফ্রি ভেরিয়েবল স্কোপ থেকে বের হয়ে গেলে স্বয়ংক্রিয়ভাবে মেমোরি ফ্রি করে। এটি হিপ অ্যালোকেশনের জন্য রেফারেন্স কাউন্টিং ব্যবহার করে।

```v
fn create_user(name string) string {
    greeting := 'Hello, ${name}!'
    return greeting
}

fn main() {
    msg := create_user('World')
    println(msg)
}
```

## -gc none এবং ম্যানুয়াল মেমোরি

`-gc none` সহ, V গার্বেজ কালেকশন নিষ্ক্রিয় করে। আপনাকে `free` ব্যবহার করে ম্যানুয়ালি মেমোরি ম্যানেজ করতে হবে।

```v
fn main() {
    mut data := []int{len: 1000, init: 0}
    for i in 0 .. 1000 {
        data[i] = i * 2
    }
    println(data[500])
    unsafe {
        data.free()
    }
}
```

## -prealloc অ্যারেনা অ্যালোকেশন

প্রিঅ্যালোক টাইট লুপে ভালো পারফরম্যান্সের জন্য অ্যারেনা অ্যালোকেশন ব্যবহার করে। অ্যালোকেশন একসাথে ফ্রি হয়।

```v
fn process_items(count int) int {
    mut total := 0
    $if prealloc {
        for i in 0 .. count {
            total += i * i
        }
    } $else {
        for i in 0 .. count {
            total += i * i
        }
    }
    return total
}

fn main() {
    result := process_items(10000)
    println(result)
}
```

## অনিরাপদ কোড

`unsafe` ব্লক V-এর নিরাপত্তা গ্যারান্টি বাইপাস করা অপারেশনের অনুমতি দেয়, যেমন পয়েন্টার পাঙ্কিতিক এবং সরাসরি মেমোরি অ্যাক্সেস।

```v
fn main() {
    x := 42
    p := unsafe { &x }
    println(p)
    unsafe {
        q := p + 1
        println(q)
    }
}
```

### পয়েন্টার পাঙ্কিতিক

```v
fn main() {
    arr := [10, 20, 30, 40, 50]
    unsafe {
        p := &arr[0]
        first := p[0]
        second := p[1]
        third := p[2]
        println('${first} ${second} ${third}')
    }
}
```

## পারফরম্যান্স টিউনিং

সঠিক মেমোরি ম্যানেজমেন্ট মোড নির্বাচন পারফরম্যান্সে উল্লেখযোগ্য প্রভাব ফেলতে পারে।

### বিভিন্ন মোড বেঞ্চমার্কিং

```v
fn benchmark_allocations(iterations int) i64 {
    sw := i64(0)
    $if boehm ? {
        sw = i64(1)
    }
    $if autofree ? {
        sw = i64(2)
    }
    $if prealloc ? {
        sw = i64(3)
    }
    return sw
}

fn main() {
    mode := benchmark_allocations(1000000)
    println('Mode: ${mode}')
}
```

### ডেটা স্ট্রাকচার অপ্টিমাইজ করা

```v
struct Point {
    x f64
    y f64
}

fn sum_points(points []Point) f64 {
    mut total := 0.0
    for p in points {
        total += p.x + p.y
    }
    return total
}

fn main() {
    points := []Point{len: 10000, init: Point{x: 1.0, y: 2.0}}
    result := sum_points(points)
    println(result)
}
```

## সারসংক্ষেপ

এই অধ্যায়ে আপনি মেমোরি ম্যানেজমেন্ট মোড, স্ট্যাক বনাম হিপ অ্যালোকেশন, অটোফ্রি, ম্যানুয়াল মেমোরি ম্যানেজমেন্ট, প্রিঅ্যালোক, অনিরাপদ কোড এবং পারফরম্যান্স টিউনিং সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা টুলিং শিখব।
