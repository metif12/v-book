# Apéndice E: Referencia de Interoperabilidad entre V y C

## Incluyendo código C

```v ignore
#include "myheader.h"
```

## Opciones de C

```v
#flag -lm
#flag -I/path/to/include
```

## Llamando a funciones C

```v
fn C.my_c_function(int) int
```

## Exportando funciones V

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## Bibliotecas compartidas

```bash
v -shared -o libmylib.so mylib.v
```
