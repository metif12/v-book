# 부록 E: V와 C 인터롭 레퍼런스

## C 코드 포함

```v ignore
#include "myheader.h"
```

## C 플래그

```v
#flag -lm
#flag -I/path/to/include
```

## C 함수 호출

```v
fn C.my_c_function(int) int
```

## V 함수 내보내기

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## 공유 라이브러리

```bash
v -shared -o libmylib.so mylib.v
```
