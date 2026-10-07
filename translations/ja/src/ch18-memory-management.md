# 第18章：メモリ管理の詳細

## GCモード

Vはいくつかのメモリ管理戦略を提供し、それぞれが異なるユースケースに適しています。

| モード | フラグ | ユースケース |
|------|------|----------|
| Boehm GC | `-gc boehm` | 汎用 |
| Autofree | `-autofree` | 自動解放 |
| なし | `-gc none` | 手動管理 |
| Prealloc | `-prealloc` | アリーナ割り当て |

## スタックとヒープ

Vはメモリをどこに割り当てるかを自動的に決定します。小さくて短命な値はスタックに残ります。より大きい値やエスケープした値はヒープに行きます。

```v
fn stack_example() int {
    x := 42
    y := x * 2
    return y
}

fn heap_example() []int {
    data := []int{len: 100, init: 0}
    return data
}

fn main() {
    a := stack_example()
    b := heap_example()
    println(a)
    println(b.len)
}
```

## Autofreeモード

Autofreeは変数のスコープが終了したときにメモリを自動的に解放します。ヒープ割り当てに参照カウントを使用します。

```v
fn create_user(name string) string {
    greeting := 'Hello, ${name}!'
    return greeting
}

fn main() {
    msg := create_user('World')
    println(msg)
}
```

## -gc noneと手動メモリ管理

`-gc none`では、Vはガベージコレクションを無効にします。`free`を使用してメモリを手動で管理する必要があります。

```v
fn main() {
    mut data := []int{len: 1000, init: 0}
    for i in 0 .. 1000 {
        data[i] = i * 2
    }
    println(data[500])
    unsafe {
        data.free()
    }
}
```

## -preallocアリーナ割り当て

Preallocはタイトループでのパフォーマンス向上のためにアリーナ割り当てを使用します。割り当ては一括で解放されます。

```v
fn process_items(count int) int {
    mut total := 0
    $if prealloc {
        for i in 0 .. count {
            total += i * i
        }
    } $else {
        for i in 0 .. count {
            total += i * i
        }
    }
    return total
}

fn main() {
    result := process_items(10000)
    println(result)
}
```

## Unsafeコード

`unsafe`ブロックは、ポインタ演算や直接メモリアクセスなど、Vの安全性保証をバイパスする操作を許可します。

```v
fn main() {
    x := 42
    p := unsafe { &x }
    println(p)
    unsafe {
        q := p + 1
        println(q)
    }
}
```

### ポインタ演算

```v
fn main() {
    arr := [10, 20, 30, 40, 50]
    unsafe {
        p := &arr[0]
        first := p[0]
        second := p[1]
        third := p[2]
        println('${first} ${second} ${third}')
    }
}
```

## パフォーマンスチューニング

適切なメモリ管理モードの選択はパフォーマンスに大きく影響する可能性があります。

### 異なるモードのベンチマーク

```v
fn benchmark_allocations(iterations int) i64 {
    sw := i64(0)
    $if boehm ? {
        sw = i64(1)
    }
    $if autofree ? {
        sw = i64(2)
    }
    $if prealloc ? {
        sw = i64(3)
    }
    return sw
}

fn main() {
    mode := benchmark_allocations(1000000)
    println('Mode: ${mode}')
}
```

### データ構造の最適化

```v
struct Point {
    x f64
    y f64
}

fn sum_points(points []Point) f64 {
    mut total := 0.0
    for p in points {
        total += p.x + p.y
    }
    return total
}

fn main() {
    points := []Point{len: 10000, init: Point{x: 1.0, y: 2.0}}
    result := sum_points(points)
    println(result)
}
```

## まとめ

この章では、メモリ管理モード、スタックとヒープの割り当て、autofree、手動メモリ管理、prealloc、unsafeコード、パフォーマンスチューニングについて学びました。次の章では、ツールを見ていきます。
