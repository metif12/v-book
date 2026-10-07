# Capitolo 16: Interop con C

V può chiamare funzioni C e può essere chiamato da C.

## Chiamare C da V

V può chiamare direttamente funzioni C usando il modulo `C`. È necessario dichiarare la firma della funzione C e includere gli header necessari.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

La direttiva `#flag` passa flag al compilatore C. Ad esempio, `-lm` collega la libreria matematica. La direttiva `#include` include i file header C affinché il compilatore conosca le funzioni C. La dichiarazione `fn C.function_name` informa V della firma della funzione C.

Puoi chiamare qualsiasi funzione C dichiarando la sua firma. Ad esempio, per chiamare `puts`:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## Chiamare V da C

Compila V in una libreria condivisa:

```bash
v -shared -o libmylib.so mylib.v
```

Poi usa la libreria condivisa da C:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V può tradurre codice C in V:

```bash
v translate myheader.h
```

## Lavorare con i tipi C

V fornisce tipi compatibili con C come `C.int`, `C.double`, `C.char`, ecc.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## Callback

Puoi passare funzioni V a callback C:

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

## Riassunto

In questo capitolo, hai imparato l'interop con C. Nel prossimo capitolo, esploreremo le funzionalità avanzate.
