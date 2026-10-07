# Kapitel 16: C-Interop

V kann C-Funktionen aufrufen und von C aufgerufen werden.

## C aus V aufrufen

V kann C-Funktionen direkt mit dem `C`-Modul aufrufen. Sie müssen die C-Funktionssignatur deklarieren und die erforderlichen Header einbinden.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

Die `#flag`-Direktive übergibt Flags an den C-Compiler. Zum Beispiel verknüpft `-lm` die Mathematikbibliothek. Die `#include`-Direktive bindet C-Header-Dateien ein, damit der Compiler die C-Funktionen kennt. Die Deklaration `fn C.function_name` teilt V die C-Funktionssignatur mit.

Sie können jede C-Funktion aufrufen, indem Sie ihre Signatur deklarieren. Zum Beispiel, um `puts` aufzurufen:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## V aus C aufrufen

Kompilieren Sie V zu einer Shared Library:

```bash
v -shared -o libmylib.so mylib.v
```

Dann verwenden Sie die Shared Library aus C:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V kann C-Code nach V übersetzen:

```bash
v translate myheader.h
```

## Arbeiten mit C-Typen

V stellt C-kompatible Typen wie `C.int`, `C.double`, `C.char` usw. bereit.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## Callbacks

Sie können V-Funktionen an C-Callbacks übergeben:

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

## Zusammenfassung

In diesem Kapitel haben Sie C-Interop kennengelernt. Im nächsten Kapitel untersuchen wir fortgeschrittene Merkmale.
