# فصل ۸: مجموعه‌ها

## آرایه‌ها

```v
fn main() {
    mut nums := [1, 2, 3]
    nums << 4
    println(nums)
    println(nums.len)
    println(nums[0])
}
```

## نقشه‌ها

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

## رشته‌ها

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## خلاصه

در این فصل، درباره آرایه‌ها، نقشه‌ها و رشته‌ها یاد گرفتید. در فصل بعد، به مدیریت خطا می‌پردازیم.
