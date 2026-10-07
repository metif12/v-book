# Appendice E: Riferimento Interop V e C

## Includere codice C

```v ignore
#include "myheader.h"
```

## Flag C

```v
#flag -lm
#flag -I/path/to/include
```

## Chiamare funzioni C

```v
fn C.my_c_function(int) int
```

## Esportare funzioni V

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## Librerie condivise

```bash
v -shared -o libmylib.so mylib.v
```
