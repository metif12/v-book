# অধ্যায় 7: module এবং প্যাকেজ

## module সিস্টেম

V কোডকে module-এ সাজায়। একটি module হল একটি ডিরেক্টরি যাতে `.v` ফাইল থাকে:

```
my_project/
├── v.mod
├── main.v
└── math/
    └── math.v
```

`math/math.v`:

```v ignore
module math

pub fn add(a int, b int) int {
    return a + b
}
```

`main.v`:

```v ignore
import math

fn main() {
    println(math.add(2, 3))
}
```

## ভিজিবিলিটি

- `pub` — পাবলিক, অন্য module থেকে অ্যাক্সেসযোগ্য
- (কোনো মডিফায়ার নেই) — প্রাইভেট, শুধুমাত্র module

## VPM

V Package Manager (VPM) কমিউনিটি প্যাকেজ হোস্ট করে:

```bash
v install vsl
```

## সারসংক্ষেপ

এই অধ্যায়ে আপনি module, ভিজিবিলিটি এবং VPM সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা কালেকশন শিখব।
