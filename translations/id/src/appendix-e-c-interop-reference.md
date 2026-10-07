# Lampiran E: Referensi Interop V dan C

## Menyertakan kode C

```v ignore
#include "myheader.h"
```

## Flag C

```v
#flag -lm
#flag -I/path/to/include
```

## Memanggil fungsi C

```v
fn C.my_c_function(int) int
```

## Mengekspor fungsi V

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## Shared library

```bash
v -shared -o libmylib.so mylib.v
```
