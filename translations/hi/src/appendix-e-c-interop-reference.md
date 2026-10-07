# अपेंडिक्स E: V और C इंटरॉप रेफरेंस

## C कोड शामिल करना

```v ignore
#include "myheader.h"
```

## C फ़्लैग

```v
#flag -lm
#flag -I/path/to/include
```

## C फ़ंक्शन कॉल करना

```v
fn C.my_c_function(int) int
```

## V फ़ंक्शन एक्सपोर्ट करना

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## शेयर्ड लाइब्रेरी

```bash
v -shared -o libmylib.so mylib.v
```
