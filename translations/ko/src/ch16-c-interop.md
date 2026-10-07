# Chapter 16: C 인터롭

V는 C 함수를 호출할 수 있고 C에서 호출될 수도 있습니다.

## V에서 C 호출하기

V는 `C` 모듈을 사용하여 C 함수를 직접 호출할 수 있습니다. C 함수 시그니처를 선언하고 필요한 헤더를 포함해야 합니다.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

`#flag` 지시문은 C 컴파일러에 플래그를 전달합니다. 예를 들어 `-lm`은 수학 라이브러리를 링크합니다. `#include` 지시문은 C 헤더 파일을 포함하여 컴파일러가 C 함수를 인식할 수 있게 합니다. `fn C.function_name` 선언은 V에 C 함수 시그니처를 알려줍니다.

시그니처를 선언하여 모든 C 함수를 호출할 수 있습니다. 예를 들어 `puts`를 호출하려면:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## C에서 V 호출하기

V를 공유 라이브러리로 컴파일합니다:

```bash
v -shared -o libmylib.so mylib.v
```

그런 다음 C에서 공유 라이브러리를 사용합니다:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V는 C 코드를 V로 번역할 수 있습니다:

```bash
v translate myheader.h
```

## C 타입 다루기

V는 `C.int`, `C.double`, `C.char` 등 C 호환 타입을 제공합니다.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## 콜백

V 함수를 C 콜백에 전달할 수 있습니다:

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

## 요약

이 장에서는 C 인터롭에 대해 배웠습니다. 다음 장에서는 고급 기능을 살펴보겠습니다.
