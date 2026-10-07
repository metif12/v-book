# 控制流

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

## If 作为表达式

```v
fn main() {
    age := 25
    category := if age >= 18 { 'adult' } else { 'minor' }
    println(category)
}
```

## For 循环

```v
fn main() {
    // 遍历数组
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // 范围
    for i in 0 .. 5 {
        println(i)
    }

    // 带索引
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

## 下一步

[第 4 章：所有权与内存](ch04-ownership-and-memory.md)
