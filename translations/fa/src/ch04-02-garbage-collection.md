# جمع‌آوری زباله

V به صورت پیش‌فرض از یک جمع‌آوری زباله استفاده می‌کند:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## غیرفعال کردن GC

برای کدهای حساس به عملکرد، می‌توانید GC را غیرفعال کنید:

```bash
v -gc none main.v
```

## بعدی

[آزادسازی خودکار](ch04-03-autofree.md)
