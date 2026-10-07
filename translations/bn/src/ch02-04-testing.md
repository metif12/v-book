# v test দিয়ে টেস্টিং

V-তে একটি বিল্ট-ইন টেস্টিং ফ্রেমওয়ার্ক আছে। `_test.v` দিয়ে শেষ হওয়া একটি ফাইল তৈরি করুন:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

টেস্ট চালান:

```bash
v test .
```

## টেস্ট ফাংশন

টেস্ট ফাংশন `test_` দিয়ে শুরু হয় এবং কোনো আর্গুমেন্ট নেয় না:

```v
fn test_something() {
    assert true
}
```

## অ্যাসারশন

শর্ত পরীক্ষা করতে `assert` ব্যবহার করুন:

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## পরবর্তী

[অধ্যায় 3: সাধারণ ধারণা](ch03-common-concepts.md)
