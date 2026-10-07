# پیوست E: مرجع همکاری V و C

## شامل کردن کد C

```v ignore
#include "myheader.h"
```

## پرچم‌های C

```v
#flag -lm
#flag -I/path/to/include
```

## فراخوانی توابع C

```v
fn C.my_c_function(int) int
```

## صادر کردن توابع V

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## کتابخانه‌های مشترک

```bash
v -shared -o libmylib.so mylib.v
```
