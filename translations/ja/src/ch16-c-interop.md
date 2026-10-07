# 第16章：C相互運用

VはC関数を呼び出すことができ、Cから呼び出すこともできます。

## VからCを呼び出す

Vは`C`モジュールを使用してC関数を直接呼び出すことができます。C関数のシグネチャを宣言し、必要なヘッダーを含める必要があります。

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

`#flag`ディレクティブはフラグをCコンパイラに渡します。例えば、`-lm`は数学ライブラリをリンクします。`#include`ディレクティブはCヘッダーファイルを含め、コンパイラがC関数を認識できるようにします。`fn C.function_name`宣言はVに関数のシグネチャを伝えます。

シグネチャを宣言することで、任意のC関数を呼び出すことができます。例えば、`puts`を呼び出すには：

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## CからVを呼び出す

Vを共有ライブラリにコンパイルします：

```bash
v -shared -o libmylib.so mylib.v
```

Cから共有ライブラリを使用します：

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

VはCコードをVに翻訳できます：

```bash
v translate myheader.h
```

## C型の操作

Vは`C.int`、`C.double`、`C.char`などのC互換型を提供しています。

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## コールバック

V関数をCコールバックに渡すことができます：

```v ignore
#flag -lm
#include "stdlib.h"

fn C.atexit(fn ())

fn my_callback() {
    println('done')
}

fn main() {
    C.atexit(my_callback)
}
```

## まとめ

この章では、C相互運用について学びました。次の章では、高度な機能を見ていきます。
