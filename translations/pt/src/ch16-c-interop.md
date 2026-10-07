# Capítulo 16: Interop com C

V pode chamar funções C e ser chamado a partir de C.

## Chamando C a partir de V

V pode chamar funções C diretamente usando o módulo `C`. Você precisa declarar a assinatura da função C e incluir os cabeçalhos necessários.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

A diretiva `#flag` passa flags para o compilador C. Por exemplo, `-lm` linka a biblioteca matemática. A diretiva `#include` inclui arquivos de cabeçalho C para que o compilador conheça as funções C. A declaração `fn C.function_name` informa V sobre a assinatura da função C.

Você pode chamar qualquer função C declarando sua assinatura. Por exemplo, para chamar `puts`:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## Chamando V a partir de C

Compile V como uma biblioteca compartilhada:

```bash
v -shared -o libmylib.so mylib.v
```

Depois use a biblioteca compartilhada a partir de C:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V pode traduzir código C para V:

```bash
v translate myheader.h
```

## Trabalhando com tipos C

V fornece tipos compatíveis com C como `C.int`, `C.double`, `C.char`, etc.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## Callbacks

Você pode passar funções V para callbacks C:

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

## Resumo

Neste capítulo, você aprendeu sobre interop com C. No próximo capítulo, vamos explorar recursos avançados.
