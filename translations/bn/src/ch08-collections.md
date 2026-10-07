# অধ্যায় 8: কালেকশন

## অ্যারে

```v
fn main() {
    mut nums := [1, 2, 3]
    nums << 4
    println(nums)
    println(nums.len)
    println(nums[0])
}
```

## ম্যাপ

```v
fn main() {
    mut ages := {
        'Alice': 30
        'Bob':   25
    }
    ages['Charlie'] = 35
    println(ages)
    println(ages['Alice'])
}
```

## স্ট্রিং

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## সারসংক্ষেপ

এই অধ্যায়ে আপনি অ্যারে, ম্যাপ এবং স্ট্রিং সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা এরর হ্যান্ডলিং শিখব।
