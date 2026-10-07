# ভেরিয়েবল এবং মিউটেবিলিটি

V-এ ভেরিয়েবল ডিফল্টভাবে অপরিবর্তনীয়:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Error: name is immutable

    mut count := 0
    count = 1  // OK: count is mutable
    count++
    println(count)
}
```

## ঘোষণা

ঘোষণা এবং আরম্ভ করতে `:=` ব্যবহার করুন:

```v
x := 42
name := 'V'
is_ready := true
```

## টাইপ ইনফারেন্স

V আরম্ভকারী থেকে টাইপ ইনফার করে:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## স্পষ্ট টাইপ

আপনি স্পষ্টভাবে টাইপ উল্লেখ করতে পারেন:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## পরবর্তী

[ডেটা টাইপ](ch03-02-data-types.md)
