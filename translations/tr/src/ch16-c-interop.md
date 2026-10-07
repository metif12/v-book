# Bölüm 16: C Birlikte Çalışma

V, C fonksiyonlarını çağırabilir ve C'den çağrılabilir.

## V'den C'yi çağırma

V, `C` modülünü kullanarak C fonksiyonlarını doğrudan çağırabilir. C fonksiyon imzasını tanımlamanız ve gerekli başlık dosyalarını dahil etmeniz gerekir.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

`#flag` yönergesi bayrakları C derleyicisine geçirir. Örneğin, `-lm` matematik kütüphanesini bağlar. `#include` yönergesi C başlık dosyalarını dahil eder, böylece derleyici C fonksiyonlarını bilir. `fn C.function_name` bildirimi V'ye C fonksiyon imzasını söyler.

İmzasını tanımlayarak herhangi bir C fonksiyonunu çağırabilirsiniz. Örneğin, `puts` çağırmak için:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## C'den V'yi çağırma

V'yi paylaşılan kütüphane olarak derleyin:

```bash
v -shared -o libmylib.so mylib.v
```

Ardından paylaşılan kütüphaneyi C'den kullanın:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V, C kodunu V'ye çevirebilir:

```bash
v translate myheader.h
```

## C tipleriyle çalışma

V, `C.int`, `C.double`, `C.char` gibi C uyumlu tipler sağlar.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## Callback'ler

V fonksiyonlarını C callback'lerine geçirebilirsiniz:

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

## Özet

Bu bölümde C birlikte çalışma hakkında bilgi edindiniz. Sonraki bölümde gelişmiş özellikleri inceleyeceğiz.
