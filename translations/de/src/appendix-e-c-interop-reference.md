# Anhang E: V- und C-Interop-Referenz

## C-Code einbinden

```v ignore
#include "myheader.h"
```

## C-Flags

```v
#flag -lm
#flag -I/path/to/include
```

## C-Funktionen aufrufen

```v
fn C.my_c_function(int) int
```

## V-Funktionen exportieren

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## Shared Libraries

```bash
v -shared -o libmylib.so mylib.v
```
