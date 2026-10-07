# রেফারেন্স

বড় ডেটা কপি এড়াতে রেফারেন্স ব্যবহার করুন:

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

## পরবর্তী

[অধ্যায় 5: struct](ch05-structs.md)
