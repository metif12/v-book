# অধ্যায় 13: ফাংশনাল ফিচার

V ক্লোজার এবং হায়ার-অর্ডার ফাংশন সমর্থন করে।

## ক্লোজার

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## হায়ার-অর্ডার ফাংশন

```v
fn apply(f fn (int) int, x int) int {
    return f(x)
}

fn main() {
    double := fn (x int) int {
        return x * 2
    }
    println(apply(double, 5))
}
```

## বেনামী ফাংশন

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## সারসংক্ষেপ

এই অধ্যায়ে আপনি ক্লোজার এবং হায়ার-অর্ডার ফাংশন সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা কনকারেন্সি শিখব।
