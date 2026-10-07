# Bölüm 8: Koleksiyonlar

## Diziler

```v
fn main() {
    mut nums := [1, 2, 3]
    nums << 4
    println(nums)
    println(nums.len)
    println(nums[0])
}
```

## Haritalar

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

## String'ler

```v
fn main() {
    s := 'Hello, World!'
    println(s.len)
    println(s[0])
    println(s.contains('World'))
    println(s.to_upper())
}
```

## Özet

Bu bölümde diziler, haritalar ve string'ler hakkında bilgi edindiniz. Sonraki bölümde hata yönetimini inceleyeceğiz.
