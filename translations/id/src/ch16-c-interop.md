# Bab 16: C Interop

V dapat memanggil fungsi C dan dapat dipanggil dari C.

## Memanggil C dari V

V dapat langsung memanggil fungsi C menggunakan modul `C`. Anda perlu mendeklarasikan signature fungsi C dan menyertakan header yang diperlukan.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

Direktif `#flag` meneruskan flag ke kompiler C. Misalnya, `-lm` menghubungkan library math. Direktif `#include` menyertakan file header C agar kompiler mengetahui fungsi C. Deklarasi `fn C.function_name` memberi tahu V tentang signature fungsi C.

Anda dapat memanggil fungsi apa pun dengan mendeklarasikan signature-nya. Misalnya, untuk memanggil `puts`:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## Memanggil V dari C

Kompilasi V menjadi shared library:

```bash
v -shared -o libmylib.so mylib.v
```

Kemudian gunakan shared library dari C:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V dapat menerjemahkan kode C ke V:

```bash
v translate myheader.h
```

## Bekerja dengan tipe C

V menyediakan tipe yang kompatibel dengan C seperti `C.int`, `C.double`, `C.char`, dll.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## Callback

Anda dapat meneruskan fungsi V ke callback C:

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

## Ringkasan

Dalam bab ini, Anda telah belajar tentang C interop. Di bab berikutnya, kita akan menjelajahi fitur lanjutan.
