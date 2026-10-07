# قابلیت مشاهده

- `pub` — عمومی، قابل دسترسی از ماژول‌های دیگر
- (بدون اصلاح‌کننده) — خصوصی، فقط ماژول

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## بعدی

[VPM](ch07-03-vpm.md)
