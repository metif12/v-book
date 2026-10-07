# باب ۱۶: C انٹراپ

V C فنکشنز کو بلا سکتا ہے اور C سے بلا یا جا سکتا ہے۔

## V سے C بلانا

V `C` ماڈیول کے ذریعے براہ راست C فنکشنز کو بلا سکتا ہے۔ آپ کو C فنکشن کے دستخط کی تعریف اور ضروری ہیڈرز شامل کرنے کی ضرورت ہے۔

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

`#flag` ہدایت C کمپائلر کو فلگز دیتی ہے۔ مثال کے طور پر، `-lm` میتھ لائبریری کو جوڑتا ہے۔ `#include` ہدایت C ہیڈر فائلوں کو شامل کرتی ہے تاکہ کمپائلر C فنکشنز کے بارے میں جان سکے۔ `fn C.function_name` تعریف V کو C فنکشن کے دستخط کے بارے میں بتاتی ہے۔

آپ کسی بھی C فنکشن کو اس کے دستخط کی تعریف کر کے بلا سکتے ہیں۔ مثال کے طور پر، `puts` کو بلانے کے لیے:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## C سے V بلانا

V کو مشترکہ لائبریری میں کمپائل کریں:

```bash
v -shared -o libmylib.so mylib.v
```

پھر C سے مشترکہ لائبریری استعمال کریں:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V C کوڈ کو V میں ترجمہ کر سکتا ہے:

```bash
v translate myheader.h
```

## C ٹائپس کے ساتھ کام

V `C.int`، `C.double`، `C.char` وغیرہ جیسے C کے ساتھ ہم آہنگ ٹائپس فراہم کرتا ہے۔

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## کال بیکس

آپ V فنکشنز کو C کال بیکس میں پاس کر سکتے ہیں:

```v ignore
#flag -lm
#include "stdlib.h"

fn C.atexit(fn ())

fn my_callback() {
    println('done')
}

fn main() {
    C.atexit(my_callback)
}
```

## خلاصہ

اس باب میں، آپ نے C انٹراپ کے بارے میں سیکھا۔ اگلے باب میں، ہم جدید خصوصیات کو دریافت کریں گے۔
