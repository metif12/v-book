# Chapter 8: 컬렉션

## 배열

```v
fn main() {
    mut nums := [1, 2, 3]
    nums << 4
    println(nums)
    println(nums.len)
    println(nums[0])
}
```

## 맵

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

## 문자열

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## 요약

이 장에서는 배열, 맵, 문자열에 대해 배웠습니다. 다음 장에서는 에러 처리를 살펴보겠습니다.
