# ضمیمہ E: V اور C انٹراپ کا حوالہ

## C کوڈ شامل کرنا

```v ignore
#include "myheader.h"
```

## C فلگز

```v
#flag -lm
#flag -I/path/to/include
```

## C فنکشنز کو بلانا

```v
fn C.my_c_function(int) int
```

## V فنکشنز کو ایکسپورٹ کرنا

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## مشترکہ لائبریریاں

```bash
v -shared -o libmylib.so mylib.v
```
