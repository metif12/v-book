# Chapter 16: C Interop

V can call C functions and be called from C.

## Calling C from V

V can call C functions directly using the `C` module. You need to declare the C function signature and include the necessary headers.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

The `#flag` directive passes flags to the C compiler. For example, `-lm` links the math library. The `#include` directive includes C header files so the compiler knows about the C functions. The `fn C.function_name` declaration tells V about the C function signature.

You can call any C function by declaring its signature. For example, to call `puts`:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## Calling V from C

Compile V to a shared library:

```bash
v -shared -o libmylib.so mylib.v
```

Then use the shared library from C:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V can translate C code to V:

```bash
v translate myheader.h
```

## Working with C types

V provides C-compatible types like `C.int`, `C.double`, `C.char`, etc.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## Callbacks

You can pass V functions to C callbacks:

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

## Summary

In this chapter, you learned about C interop. In the next chapter, we'll explore advanced features.
