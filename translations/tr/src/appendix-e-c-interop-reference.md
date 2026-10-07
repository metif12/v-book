# Ek E: V ve C Birlikte Çalışma Başvurusu

## C kodunu dahil etme

```v ignore
#include "myheader.h"
```

## C bayrakları

```v
#flag -lm
#flag -I/path/to/include
```

## C fonksiyonlarını çağırma

```v
fn C.my_c_function(int) int
```

## V fonksiyonlarını dışa aktarma

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## Paylaşılan kütüphaneler

```bash
v -shared -o libmylib.so mylib.v
```
