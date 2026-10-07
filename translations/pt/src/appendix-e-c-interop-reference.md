# Apêndice E: Referência de Interop V e C

## Incluindo código C

```v ignore
#include "myheader.h"
```

## Flags C

```v
#flag -lm
#flag -I/path/to/include
```

## Chamando funções C

```v
fn C.my_c_function(int) int
```

## Exportando funções V

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## Bibliotecas compartilhadas

```bash
v -shared -o libmylib.so mylib.v
```
