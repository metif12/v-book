# অধ্যায় 16: C ইন্টরপ

V C ফাংশন কল করতে পারে এবং C থেকে কল করা যায়।

## V থেকে C কল করা

V `C` মডিউল ব্যবহার করে সরাসরি C ফাংশন কল করতে পারে। আপনাকে C ফাংশন সিগনেচার ঘোষণা করতে হবে এবং প্রয়োজনীয় হেডার অন্তর্ভুক্ত করতে হবে।

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

`#flag` ডিরেক্টিভ C কম্পাইলারে ফ্ল্যাগ পাঠায়। উদাহরণস্বরূপ, `-lm` ম্যাথ লাইব্রেরি লিংক করে। `#include` ডিরেক্টিভ C হেডার ফাইল অন্তর্ভুক্ত করে যাতে কম্পাইলার C ফাংশন সম্পর্কে জানে। `fn C.function_name` ঘোষণা V-কে C ফাংশন সিগনেচার সম্পর্কে জানায়।

আপনি সিগনেচার ঘোষণা করে যেকোনো C ফাংশন কল করতে পারেন। উদাহরণস্বরূপ, `puts` কল করতে:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## C থেকে V কল করা

V কে শেয়ার্ড লাইব্রেরিতে কম্পাইল করুন:

```bash
v -shared -o libmylib.so mylib.v
```

তারপর C থেকে শেয়ার্ড লাইব্রেরি ব্যবহার করুন:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V C কোডকে V-এ অনুবাদ করতে পারে:

```bash
v translate myheader.h
```

## C টাইপের সাথে কাজ

V `C.int`, `C.double`, `C.char` ইত্যাদি C-সামঞ্জস্যপূর্ণ টাইপ প্রদান করে।

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## কলব্যাক

আপনি C কলব্যাকে V ফাংশন পাঠাতে পারেন:

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

## সারসংক্ষেপ

এই অধ্যায়ে আপনি C ইন্টরপ সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা অ্যাডভান্সড ফিচার শিখব।
