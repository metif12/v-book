# 第2章：プロジェクトの構築

この章では、Vプロジェクトの構造化、`v.mod`の使用、`v fmt`によるコードのフォーマット、`v test`によるテストの書き方を学びます。

## プロジェクト構造

Vプロジェクトは`v.mod`ファイルと1つ以上の`.v`ファイルを持つディレクトリです：

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

すべてのVプロジェクトはプロジェクトを記述する`v.mod`ファイルを持ちます：

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

新しいプロジェクトの作成：

```bash
v init
```

これにより、基本テンプレートを含む`v.mod`と`main.v`が作成されます。

## v fmtによるフォーマット

Vには組み込みのコードフォーマッターがあります。プロジェクトに対して実行します：

```bash
v fmt -w .
```

`-w`フラグはフォーマットされたコードをファイルに書き戻します。

## v testによるテスト

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

## まとめ

この章では、Vプロジェクトの構造化、`v.mod`の使用、コードのフォーマット、テストの書き方を学びました。次の章では、Vの一般的なプログラミング概念を見ていきます。
