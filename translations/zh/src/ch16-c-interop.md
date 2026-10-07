# 第 16 章：C 语言互操作

V 可以调用 C 函数，也可以从 C 调用。

## 从 V 调用 C

V 可以使用 `C` 模块直接调用 C 函数。你需要声明 C 函数签名并包含必要的头文件。

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

`#flag` 指令将标志传递给 C 编译器。例如，`-lm` 链接数学库。`#include` 指令包含 C 头文件，使编译器了解 C 函数。`fn C.function_name` 声明告诉 V 关于 C 函数的签名。

你可以通过声明签名来调用任何 C 函数。例如，调用 `puts`：

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## 从 C 调用 V

将 V 编译为共享库：

```bash
v -shared -o libmylib.so mylib.v
```

然后在 C 中使用共享库：

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V 可以将 C 代码翻译为 V：

```bash
v translate myheader.h
```

## 使用 C 类型

V 提供 C 兼容类型，如 `C.int`、`C.double`、`C.char` 等。

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## 回调

你可以将 V 函数传递给 C 回调：

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

## 小结

在本章中，你学习了 C 语言互操作。在下一章中，我们将探讨高级特性。
