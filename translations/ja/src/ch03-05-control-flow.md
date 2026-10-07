# 制御フロー

## If

```v
fn main() {
    age := 25
    if age >= 18 {
        println('Adult')
    } else {
        println('Minor')
    }
}
```

## If式

```v
fn main() {
    age := 25
    category := if age >= 18 { 'adult' } else { 'minor' }
    println(category)
}
```

## Forループ

```v
fn main() {
    // 配列のループ
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // 範囲
    for i in 0 .. 5 {
        println(i)
    }

    // インデックス付き
    for i, fruit in fruits {
        println('${i}: ${fruit}')
    }
}
```

## Match

```v
fn main() {
    color := 'blue'
    match color {
        'red' { println('Red!') }
        'blue' { println('Blue!') }
        else { println('Other color') }
    }
}
```

## 次へ

[第4章：所有権とメモリ](ch04-ownership-and-memory.md)
