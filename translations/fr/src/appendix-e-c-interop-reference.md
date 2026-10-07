# Annexe E : Référence d'interop V et C

## Inclure du code C

```v ignore
#include "myheader.h"
```

## Options C

```v
#flag -lm
#flag -I/path/to/include
```

## Appeler des fonctions C

```v
fn C.my_c_function(int) int
```

## Exporter des fonctions V

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## Bibliothèques partagées

```bash
v -shared -o libmylib.so mylib.v
```
