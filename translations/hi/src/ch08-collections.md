# अध्याय 8: कलेक्शन

## ऐरे

```v
fn main() {
    mut nums := [1, 2, 3]
    nums << 4
    println(nums)
    println(nums.len)
    println(nums[0])
}
```

## मैप

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

## स्ट्रिंग

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## सारांश

इस अध्याय में, आपने ऐरे, मैप, और स्ट्रिंग के बारे में सीखा। अगले अध्याय में, हम एरर हैंडलिंग का पता लगाएंगे।
