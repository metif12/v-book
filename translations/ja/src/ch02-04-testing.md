# v testによるテスト

Vには組み込みのテストフレームワークがあります。`_test.v`で終わるファイルを作成します：

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

テストの実行：

```bash
v test .
```

## テスト関数

テスト関数は`test_`で始まり、引数を取りません：

```v
fn test_something() {
    assert true
}
```

## アサーション

`assert`を使って条件を確認します：

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## 次へ

[第3章：共通概念](ch03-common-concepts.md)
