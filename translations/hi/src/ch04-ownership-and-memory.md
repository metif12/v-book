# अध्याय 4: ओनरशिप और मेमोरी

V मेमोरी मैनेजमेंट के लिए कई भाषाओं से अलग दृष्टिकोण अपनाता है। मैनुअल मेमोरी मैनेजमेंट या केवल गार्बेज कलेक्शन के बजाय, V कई रणनीतियाँ प्रदान करता है।

## स्टैक और हीप

V स्वचालित रूप से तय करता है कि स्टैक या हीप पर एलोकेट करना है:

```v
fn main() {
    // Stack-allocated (small, fixed size)
    x := 42
    arr := [1, 2, 3]

    // Heap-allocated (large, dynamic)
    mut big := []int{}
    for i in 0 .. 1000 {
        big << i
    }

    println('${x} ${arr} ${big.len}')
}
```

## गार्बेज कलेक्शन

V डिफ़ॉल्ट रूप से गार्बेज कलेक्टर का उपयोग करता है। आपको मेमोरी को मैनुअल रूप से फ्री करने की आवश्यकता नहीं है:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## ऑटोफ्री

V में एक ऑटोफ्री मोड है जो वेरिएबल के स्कोप से बाहर जाने पर स्वचालित रूप से मेमोरी फ्री करता है:

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data is automatically freed here
}

fn main() {
    process()
    println('done')
}
```

## रेफरेंस

बड़े डेटा की प्रतिलिपि से बचने के लिए आप रेफरेंस का उपयोग कर सकते हैं:

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## मेमोरी मैनेजमेंट मोड

| मोड | फ़्लैग | विवरण |
|------|------|-------------|
| GC (default) | `-gc boehm` | Boehm garbage collector |
| Autofree | `-autofree` | Automatic memory freeing |
| None | `-gc none` | Manual memory management |
| Prealloc | `-prealloc` | Arena allocation |

## सारांश

इस अध्याय में, आपने V के मेमोरी मैनेजमेंट विकल्पों के बारे में सीखा। अगले अध्याय में, हम structs का पता लगाएंगे।
