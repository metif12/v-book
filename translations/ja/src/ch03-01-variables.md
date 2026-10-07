# 変数と可変性

Vでは、変数はデフォルトで不変です：

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

## 宣言

`:=`を使って宣言と初期化を行います：

```v
x := 42
name := 'V'
is_ready := true
```

## 型推論

Vは初期化子から型を推論します：

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## 明示的な型

型を明示的に指定することもできます：

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## 次へ

[データ型](ch03-02-data-types.md)
