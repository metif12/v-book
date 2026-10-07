# الفصل 7: الوحدات والحزم

## نظام الوحدات

ينظم V الكود في وحدات. الوحدة هي مجلد يحتوي على ملفات `.v`:

```
my_project/
├── v.mod
├── main.v
└── math/
    └── math.v
```

`math/math.v`:

```v ignore
module math

pub fn add(a int, b int) int {
    return a + b
}
```

`main.v`:

```v ignore
import math

fn main() {
    println(math.add(2, 3))
}
```

## الظهور

- `pub` — عام، يمكن الوصول إليه من وحدات أخرى
- (بدون محدد) — خاص، للوحدة فقط

## VPM

مدير حزم V (VPM) يستضيف حزم المجتمع:

```bash
v install vsl
```

## الملخص

في هذا الفصل، تعلمت عن الوحدات، الظهور، و VPM. في الفصل التالي، سنستكشف المجموعات.
