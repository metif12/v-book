# الظهور

- `pub` — عام، يمكن الوصول إليه من وحدات أخرى
- (بدون محدد) — خاص، للوحدة فقط

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## التالي

[VPM](ch07-03-vpm.md)
