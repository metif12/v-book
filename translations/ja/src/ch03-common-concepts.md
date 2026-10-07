# 第3章：共通概念

この章では、Vの一般的なプログラミング概念（変数、データ型、関数、コメント、制御フロー）を扱います。

## 変数と可変性

Vでは、変数はデフォルトで不変です。可変にするには`mut`を使用します：

```v
fn main() {
    name := 'V'
    // name = 'Go'  // エラー: nameは不変です

    mut count := 0
    count = 1  // OK: countは可変です
    count++
    println(count)
}
```

## データ型

Vには豊富な型システムがあります：

```v
fn main() {
    // 整数
    a := 42        // int
    b := i64(100)  // 64ビット整数
    c := u8(255)   // 符号なし8ビット

    // 浮動小数点
    pi := 3.14     // f64
    e := f32(2.71) // 32ビット浮動小数点

    // その他の型
    name := 'V'    // string
    is_ok := true  // bool
    letter := `A`  // rune（単一文字）

    println('${a} ${b} ${c}')
    println('${pi} ${e}')
    println('${name} ${is_ok} ${letter}')
}
```

## 関数

関数は`fn`で宣言します：

```v
fn add(a int, b int) int {
    return a + b
}

fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    result := add(2, 3)
    println(result)
    greet('World')
}
```

## コメント

```v
// これは行コメントです

/* これは
   ブロックコメントです */
```

## 制御フロー

### If

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

### Forループ

```v
fn main() {
    // 配列のループ
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // 範囲ループ
    for i in 0 .. 5 {
        println(i)
    }
}
```

### Match

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

## まとめ

この章では、Vの変数、データ型、関数、コメント、制御フローについて学びました。次の章では、所有権とメモリ管理を見ていきます。
