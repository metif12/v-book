# Глава 16: Интероперабельность с C

V может вызывать функции C и быть вызванным из C.

## Вызов C из V

V может напрямую вызывать функции C с помощью модуля `C`. Вам нужно объявить сигнатуру функции C и подключить необходимые заголовочные файлы.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

Директива `#flag` передаёт флаги компилятору C. Например, `-lm` подключает математическую библиотеку. Директива `#include` подключает заголовочные файлы C, чтобы компилятор знал о функциях C. Объявление `fn C.function_name` сообщает V о сигнатуре функции C.

Вы можете вызвать любую функцию C, объявив её сигнатуру. Например, чтобы вызвать `puts`:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## Вызов V из C

Скомпилируйте V в разделяемую библиотеку:

```bash
v -shared -o libmylib.so mylib.v
```

Затем используйте разделяемую библиотеку из C:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V может переводить код C на V:

```bash
v translate myheader.h
```

## Работа с типами C

V предоставляет совместимые с C типы, такие как `C.int`, `C.double`, `C.char` и т.д.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## Колбэки

Вы можете передавать функции V в колбэки C:

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

## Итоги

В этой главе вы узнали об интероперабельности с C. В следующей главе мы рассмотрим продвинутые возможности.
