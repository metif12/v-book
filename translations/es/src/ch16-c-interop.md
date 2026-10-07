# Capítulo 16: Interoperabilidad con C

V puede llamar a funciones C y ser llamado desde C.

## Llamando a C desde V

V puede llamar a funciones C directamente usando el módulo `C`. Necesitas declarar la firma de la función C e incluir los encabezados necesarios.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

La directiva `#flag` pasa opciones al compilador de C. Por ejemplo, `-lm` enlaza la biblioteca matemática. La directiva `#include` incluye archivos de encabezado C para que el compilador conozca las funciones C. La declaración `fn C.function_name` le dice a V sobre la firma de la función C.

Puedes llamar a cualquier función C declarando su firma. Por ejemplo, para llamar a `puts`:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## Llamando a V desde C

Compila V a una biblioteca compartida:

```bash
v -shared -o libmylib.so mylib.v
```

Luego usa la biblioteca compartida desde C:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V puede traducir código C a V:

```bash
v translate myheader.h
```

## Trabajando con tipos C

V proporciona tipos compatibles con C como `C.int`, `C.double`, `C.char`, etc.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## Callbacks

Puedes pasar funciones V a callbacks de C:

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

## Resumen

En este capítulo, aprendiste sobre la interoperabilidad con C. En el siguiente capítulo, exploraremos características avanzadas.
