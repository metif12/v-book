# 附录 E：V 与 C 互操作参考

## 包含 C 代码

```v ignore
#include "myheader.h"
```

## C 标志

```v
#flag -lm
#flag -I/path/to/include
```

## 调用 C 函数

```v
fn C.my_c_function(int) int
```

## 导出 V 函数

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## 共享库

```bash
v -shared -o libmylib.so mylib.v
```
