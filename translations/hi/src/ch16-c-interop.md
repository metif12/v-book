# अध्याय 16: C इंटरॉप

V C फ़ंक्शन को कॉल कर सकता है और C से कॉल किया जा सकता है।

## V से C कॉल करना

V `C` मॉड्यूल का उपयोग करके सीधे C फ़ंक्शन को कॉल कर सकता है। आपको C फ़ंक्शन सिग्नेचर को घोषित करने और आवश्यक हेडर शामिल करने की आवश्यकता है।

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

`#flag` डायरेक्टिव C कंपाइलर को फ़्लैग पास करता है। उदाहरण के लिए, `-lm` मैथ लाइब्रेरी को लिंक करता है। `#include` डायरेक्टिव C हेडर फ़ाइलों को शामिल करता है ताकि कंपाइलर C फ़ंक्शनों के बारे में जान सके। `fn C.function_name` घोषणा V को C फ़ंक्शन सिग्नेचर के बारे में बताती है।

आप किसी भी C फ़ंक्शन को उसका सिग्नेचर घोषित करके कॉल कर सकते हैं। उदाहरण के लिए, `puts` को कॉल करने के लिए:

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## C से V कॉल करना

V को शेयर्ड लाइब्रेरी में कंपाइल करें:

```bash
v -shared -o libmylib.so mylib.v
```

फिर C से शेयर्ड लाइब्रेरी का उपयोग करें:

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V C कोड को V में अनुवाद कर सकता है:

```bash
v translate myheader.h
```

## C टाइप्स के साथ काम करना

V `C.int`, `C.double`, `C.char` आदि जैसे C-संगत टाइप्स प्रदान करता है।

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## कॉलबैक

आप C कॉलबैक में V फ़ंक्शन पास कर सकते हैं:

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

## सारांश

इस अध्याय में, आपने C इंटरॉप के बारे में सीखा। अगले अध्याय में, हम एडवांस्ड फ़ीचर्स का पता लगाएंगे।
