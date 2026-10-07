# فصل ۱۶: همکاری با C

V می‌تواند توابع C را فراخوانی کند و از C فراخوانی شود.

## فراخوانی C از V

V می‌تواند مستقیماً با ماژول `C` توابع C را فراخوانی کند. باید امضای تابع C را اعلام کنید و هدرهای لازم را شامل کنید.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

دستور `#flag` پرچم‌ها را به کامپایلر C منتقل می‌کند. به عنوان مثال، `-lm` کتابخانه ریاضی را لینک می‌کند. دستور `#include` فایل‌های هدر C را شامل می‌کند تا کامپایلر از توابع C مطلع شود. اعلام `fn C.function_name` امضای تابع C را به V معرفی می‌کند.

می‌توانید هر تابع C را با اعلام امضای آن فراخوانی کنید. به عنوان مثال، برای فراخوانی `puts`:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## فراخوانی V از C

V را به یک کتابخانه مشترک کامپایل کنید:

```bash
v -shared -o libmylib.so mylib.v
```

سپس از کتابخانه مشترک در C استفاده کنید:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V می‌تواند کد C را به V ترجمه کند:

```bash
v translate myheader.h
```

## کار با انواع C

V انواع سازگار با C مانند `C.int`، `C.double`، `C.char` و غیره ارائه می‌دهد.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## بازگشت‌ها (Callbacks)

می‌توانید توابع V را به بازگشت‌های C منتقل کنید:

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

## خلاصه

در این فصل، درباره همکاری با C یاد گرفتید. در فصل بعد، به ویژگی‌های پیشرفته می‌پردازیم.
