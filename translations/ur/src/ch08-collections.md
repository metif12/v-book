# باب ۸: کلکشنز

## ارےز

```v
fn main() {
    mut nums := [1, 2, 3]
    nums << 4
    println(nums)
    println(nums.len)
    println(nums[0])
}
```

## میپس

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

## اسٹرنگز

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## خلاصہ

اس باب میں، آپ نے ارےز، میپس، اور اسٹرنگز کے بارے میں سیکھا۔ اگلے باب میں، ہم خرابی کی عاملہ کاری کو دریافت کریں گے۔
