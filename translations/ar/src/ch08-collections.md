# الفصل 8: المجموعات

## المصفوفات

```v
fn main() {
    mut nums := [1, 2, 3]
    nums << 4
    println(nums)
    println(nums.len)
    println(nums[0])
}
```

## الخرائط

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

## النصوص

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## الملخص

في هذا الفصل، تعلمت عن المصفوفات، الخرائط، والنصوص. في الفصل التالي، سنستكشف معالجة الأخطاء.
