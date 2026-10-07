# 第7章：モジュールとパッケージ

## モジュールシステム

Vはコードをモジュールに整理します。モジュールは`.v`ファイルを持つディレクトリです：

```
my_project/
├── v.mod
├── main.v
└── math/
    └── math.v
```

`math/math.v`:

```v ignore
module math

pub fn add(a int, b int) int {
    return a + b
}
```

`main.v`:

```v ignore
import math

fn main() {
    println(math.add(2, 3))
}
```

## 可視性

- `pub` — パブリック、他のモジュールからアクセス可能
- （修飾子なし） — プライベート、モジュール内のみ

## VPM

Vパッケージマネージャー（VPM）はコミュニティパッケージをホストしています：

```bash
v install vsl
```

## まとめ

この章では、モジュール、可視性、VPMについて学びました。次の章では、コレクションを見ていきます。
