# रेफरेंस

बड़े डेटा की प्रतिलिपि से बचने के लिए रेफरेंस का उपयोग करें:

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

## अगला

[अध्याय 5: Structs](ch05-structs.md)
