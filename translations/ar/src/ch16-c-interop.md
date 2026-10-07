# الفصل 16: التفاعل مع C

V يمكنه استدعاء دوال C ويمكن استدعاؤه من C.

## استدعاء C من V

V يمكنه استدعاء دوال C مباشرة باستخدام وحدة `C`. تحتاج إلى تعريف توقيع دالة C وتضمين الترويسات اللازمة.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

التوجيه `#flag` يمرر علامات إلى مُصرِّف C. على سبيل المثال، `-lm` يربط مكتبة الرياضيات. التوجيه `#include` يضمّن ملفات ترويسة C حتى يعرف المُصرِّف عن دوال C. التعريف `fn C.function_name` يخبر V عن توقيع دالة C.

يمكنك استدعاء أي دالة C بتعريف توقيعها. على سبيل المثال، لاستدعاء `puts`:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## استدعاء V من C

صرّف V إلى مكتبة مشتركة:

```bash
v -shared -o libmylib.so mylib.v
```

ثم استخدم المكتبة المشتركة من C:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V يمكنه ترجمة كود C إلى V:

```bash
v translate myheader.h
```

## العمل مع أنواع C

V يوفر أنواعاً متوافقة مع C مثل `C.int`، `C.double`، `C.char`، إلخ.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## الاستدعاءات الراجعة (Callbacks)

يمكنك تمرير دوال V إلى استدعاءات راجعة في C:

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

## الملخص

في هذا الفصل، تعلمت عن التفاعل مع C. في الفصل التالي، سنستكشف الميزات المتقدمة.
