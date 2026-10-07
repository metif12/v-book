# 第17章：高度な機能

## アトリビュート

アトリビュートは宣言の前に置かれたメタデータアノテーションです。コンパイラの動作、最適化ヒント、APIのライフサイクルを制御します。

### [deprecated]

関数または型を非推奨としてマークします。項目が使用されるとコンパイラが警告を出力します。

```v
[deprecated]
fn old_add(a int, b int) int {
    return a + b
}

[deprecated: 'Use new_add instead']
fn old_multiply(a int, b int) int {
    return a * b
}
```

### [inline]

コンパイラに関数を呼び出し地点でインライン展開するようヒントを出します。呼び出しオーバーヘッドを排除します。小さくて頻繁に呼び出される関数に最適です。

```v
[inline]
fn square(x int) int {
    return x * x
}

fn main() {
    result := square(5)
    println(result)
}
```

### [unsafe]

関数をunsafeとしてマークし、呼び出し元もunsafeとしてマークすることなく`unsafe`ブロックを使用できるようにします。

```v
[unsafe]
fn read_pointer(ptr voidptr) int {
    return unsafe { *(&int(ptr)) }
}

fn main() {
    x := 42
    val := read_pointer(&x)
    println(val)
}
```

### [if]

コンパイル時の条件付きコンパイルです。条件がtrueの場合にのみブロックが含まれます。

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## コンパイル時コード

Vはコンパイル中に実行されるいくつかのコンパイル時構文を提供し、メタプログラミングとゼロコスト抽象化を可能にします。

### $if

コンパイル時に条件を評価します。プラットフォーム検出、アーキテクチャチェック、カスタムフラグをサポートします。

```v
$if windows {
    const os_name = 'Windows'
} $else $if macos {
    const os_name = 'macOS'
} $else $if linux {
    const os_name = 'Linux'
} $else {
    const os_name = 'Unknown'
}

fn main() {
    println('Running on ${os_name}')
}
```

### $for

コンパイル時に配列、structフィールド、範囲を反復処理します。反復的なコードの生成に便利です。

```v
const platforms = ['windows', 'linux', 'macos']

fn is_platform(name string) bool {
    return name in platforms
}

fn main() {
    println(is_platform('windows'))
    println(is_platform('linux'))
    println(is_platform('macos'))
    println(is_platform('freebsd'))
}
```

### $assert

条件がfalseの場合にコンパイルを中止するコンパイル時アサーションです。

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## 演算子オーバーロード

Vはユーザー定義型に対する演算子のカスタム動作を定義できます。各演算子は特定のシグネチャを持つメソッドにマップされます。

### 算術演算子

```v
struct Vec2 {
    x f64
    y f64
}

fn (a Vec2) + (b Vec2) Vec2 {
    return Vec2{x: a.x + b.x, y: a.y + b.y}
}

fn (a Vec2) - (b Vec2) Vec2 {
    return Vec2{x: a.x - b.x, y: a.y - b.y}
}

fn (a Vec2) * (b Vec2) Vec2 {
    return Vec2{x: a.x * b.x, y: a.y * b.y}
}

fn (a Vec2) / (b Vec2) Vec2 {
    return Vec2{x: a.x / b.x, y: a.y / b.y}
}

fn main() {
    a := Vec2{x: 10, y: 20}
    b := Vec2{x: 2, y: 4}
    sum := a + b
    diff := a - b
    prod := a * b
    quot := a / b
    println('Sum: ${sum.x}, ${sum.y}')
    println('Diff: ${diff.x}, ${diff.y}')
    println('Prod: ${prod.x}, ${prod.y}')
    println('Quot: ${quot.x}, ${quot.y}')
}
```

### 比較演算子

```v
struct Money {
    amount   f64
    currency string
}

fn (a Money) == (b Money) bool {
    return a.amount == b.amount && a.currency == b.currency
}

fn main() {
    a := Money{amount: 10.0, currency: 'USD'}
    b := Money{amount: 10.0, currency: 'USD'}
    c := Money{amount: 20.0, currency: 'USD'}
    println(a == b)
    println(a == c)
}
```

### インデックス演算子

```v
struct Grid {
    data [][]int
}

fn (g Grid) row_count() int {
    return g.data.len
}

fn (g Grid) get(row int, col int) int {
    return g.data[row][col]
}

fn main() {
    g := Grid{
        data: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    }
    println(g.row_count())
    println(g.get(1, 2))
}
```

## コンパイル時リフレクション

Vの`$for`構文はコンパイル時にstructフィールドを反復処理でき、自動シリアライズ、バリデーションなどを可能にします。

### structフィールドの反復処理

```v
struct User {
    id    int
    name  string
    email string
    age   int
}

fn main() {
    u := User{
        id: 1
        name: 'Alice'
        email: 'alice@example.com'
        age: 30
    }
    $for field in User.fields {
        $if field.typ is string {
            println('${field.name} is a string field')
        } $else $if field.typ is int {
            println('${field.name} is an int field')
        }
    }
    println('${u.name} is ${u.age} years old')
}
```

### バリデーションコードの生成

```v
struct Config {
    host    string
    port    int
    timeout f64
}

fn validate_config(c Config) ! {
    $for field in Config.fields {
        $if field.typ is string {
            if c.$(field.name).len == 0 {
                return error('${field.name} must not be empty')
            }
        } $else $if field.typ is int {
            if c.$(field.name) <= 0 {
                return error('${field.name} must be positive')
            }
        }
    }
}

fn main() {
    cfg := Config{
        host: 'localhost'
        port: 8080
        timeout: 30.0
    }
    validate_config(cfg) or {
        println('Config invalid: ${err}')
        return
    }
    println('Config is valid')
}
```

## まとめ

この章では、アトリビュート、コンパイル時コード、演算子オーバーロード、コンパイル時リフレクションについて学びました。これらの機能は強力なメタプログラミングパターンとコンパイルのきめ細かな制御を可能にします。次の章では、メモリ管理を詳しく見ていきます。
