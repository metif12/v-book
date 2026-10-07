# گاربيج کلکشن

V ڈیفالٹ طور پر گاربيج کلکٹر استعمال کرتا ہے:

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

## GC کو غیر فعال کرنا

پرفارمنس سے متعلقہ کوڈ کے لیے، GC کو غیر فعال کر سکتے ہیں:

```bash
v -gc none main.v
```

## اگلا

[آٹوفری](ch04-03-autofree.md)
