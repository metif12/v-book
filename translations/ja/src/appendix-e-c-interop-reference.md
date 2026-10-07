# 付録E：VとCの相互運用リファレンス

## Cコードのインクルード

```v ignore
#include "myheader.h"
```

## Cフラグ

```v
#flag -lm
#flag -I/path/to/include
```

## C関数の呼び出し

```v
fn C.my_c_function(int) int
```

## V関数のエクスポート

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## 共有ライブラリ

```bash
v -shared -o libmylib.so mylib.v
```
