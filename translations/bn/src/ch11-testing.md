# অধ্যায় 11: টেস্টিং

V-তে একটি বিল্ট-ইন টেস্টিং ফ্রেমওয়ার্ক আছে।

## টেস্ট ফাইল

`_test.v` দিয়ে শেষ হওয়া একটি ফাইল তৈরি করুন:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

## টেস্ট চালানো

```bash
v test .
```

## টেস্ট সংগঠন

```v
fn add(a int, b int) int {
    return a + b
}

fn sub(a int, b int) int {
    return a - b
}

fn mul(a int, b int) int {
    return a * b
}

fn test_add() {
    assert add(2, 3) == 5
}

fn test_sub() {
    assert sub(5, 3) == 2
}

fn test_mul() {
    assert mul(2, 3) == 6
}
```

## টেবল-চালিত টেস্ট

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    tests := [
        [2, 3, 5],
        [-1, 1, 0],
        [0, 0, 0],
    ]
    for t in tests {
        assert add(t[0], t[1]) == t[2]
    }
}
```

## সারসংক্ষেপ

এই অধ্যায়ে আপনি V-এর টেস্টিং ফ্রেমওয়ার্ক সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা একটি কমান্ড-লাইন টুল তৈরি করব।
