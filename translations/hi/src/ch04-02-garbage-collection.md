# गार्बेज कलेक्शन

V डिफ़ॉल्ट रूप से गार्बेज कलेक्टर का उपयोग करता है:

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

## GC अक्षम करना

परफ़ॉर्मेंस-क्रिटिकल कोड के लिए, आप GC को अक्षम कर सकते हैं:

```bash
v -gc none main.v
```

## अगला

[ऑटोफ्री](ch04-03-autofree.md)
