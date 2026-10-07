# جمع القمامة

يستخدم V جامع قمامة افتراضياً:

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

## تعطيل GC

للكود الحساس للأداء، يمكنك تعطيل GC:

```bash
v -gc none main.v
```

## التالي

[التحرير التلقائي](ch04-03-autofree.md)
