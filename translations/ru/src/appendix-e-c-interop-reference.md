# Appendix E: V and C Interop Reference

## Including C code

```v ignore
#include "myheader.h"
```

## C flags

```v
#flag -lm
#flag -I/path/to/include
```

## Calling C functions

```v
fn C.my_c_function(int) int
```

## Exporting V functions

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## Shared libraries

```bash
v -shared -o libmylib.so mylib.v
```
