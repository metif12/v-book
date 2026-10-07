# অতিরিক্ত E: V এবং C ইন্টরপ রেফারেন্স

## C কোড অন্তর্ভুক্ত করা

```v ignore
#include "myheader.h"
```

## C ফ্ল্যাগ

```v
#flag -lm
#flag -I/path/to/include
```

## C ফাংশন কল করা

```v
fn C.my_c_function(int) int
```

## V ফাংশন এক্সপোর্ট করা

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## শেয়ার্ড লাইব্রেরি

```bash
v -shared -o libmylib.so mylib.v
```
