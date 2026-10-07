# الملحق E: مرجع التفاعل بين V و C

## تضمين كود C

```v ignore
#include "myheader.h"
```

## علامات C

```v
#flag -lm
#flag -I/path/to/include
```

## استدعاء دوال C

```v
fn C.my_c_function(int) int
```

## تصدير دوال V

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## المكتبات المشتركة

```bash
v -shared -o libmylib.so mylib.v
```
