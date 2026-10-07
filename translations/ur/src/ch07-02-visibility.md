# مرئیت

- `pub` — عوامی، دیگر ماڈیولز سے قابل رسائی
- (کوئی تعدیل کار نہیں) — نجی، صرف ماڈیول

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## اگلا

[VPM](ch07-03-vpm.md)
