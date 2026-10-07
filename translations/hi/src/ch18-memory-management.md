# अध्याय 18: मेमोरी मैनेजमेंट डीप डाइव

## GC मोड

V कई मेमोरी मैनेजमेंट रणनीतियाँ प्रदान करता है, प्रत्येक अलग-अलग उपयोग के लिए उपयुक्त।

| मोड | फ़्लैग | उपयोग |
|------|------|----------|
| Boehm GC | `-gc boehm` | सामान्य उद्देश्य |
| Autofree | `-autofree` | स्वचालित फ्रीइंग |
| None | `-gc none` | मैनुअल मैनेजमेंट |
| Prealloc | `-prealloc` | एरेना एलोकेशन |

## स्टैक बनाम हीप

V स्वचालित रूप से तय करता है कि मेमोरी कहाँ एलोकेट करनी है। छोटे, अल्पकालिक मान स्टैक पर रहते हैं। बड़े या एस्केप किए गए मान हीप पर जाते हैं।

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

## ऑटोफ्री मोड

ऑटोफ्री वेरिएबल के स्कोप से बाहर जाने पर स्वचालित रूप से मेमोरी फ्री करता है। यह हीप एलोकेशन के लिए रेफरेंस काउंटिंग का उपयोग करता है।

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

## -gc none और मैनुअल मेमोरी

`-gc none` के साथ, V गार्बेज कलेक्शन को अक्षम करता है। आपको `free` का उपयोग करके मेमोरी को मैनुअल रूप से प्रबंधित करना होगा।

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

## -prealloc एरेना एलोकेशन

Prealloc टाइट लूप में बेहतर परफ़ॉर्मेंस के लिए एरेना एलोकेशन का उपयोग करता है। एलोकेशन को थोक में फ्री किया जाता है।

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

## असुरक्षित कोड

`unsafe` ब्लॉक ऐसे ऑपरेशन की अनुमति देता है जो V की सुरक्षा गारंटी को बायपास करते हैं, जैसे पॉइंटर अंकगणित और सीधी मेमोरी एक्सेस।

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

### पॉइंटर अंकगणित

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

## परफ़ॉर्मेंस ट्यूनिंग

सही मेमोरी मैनेजमेंट मोड चुनना परफ़ॉर्मेंस को काफी प्रभावित कर सकता है।

### विभिन्न मोड की बेंचमार्किंग

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

### डेटा स्ट्रक्चर का ऑप्टिमाइज़ेशन

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

## सारांश

इस अध्याय में, आपने मेमोरी मैनेजमेंट मोड, स्टैक बनाम हीप एलोकेशन, ऑटोफ्री, मैनुअल मेमोरी मैनेजमेंट, prealloc, असुरक्षित कोड और परफ़ॉर्मेंस ट्यूनिंग के बारे में सीखा। अगले अध्याय में, हम टूलिंग का पता लगाएंगे।
