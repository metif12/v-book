# Erişim Belirleyiciler

Alanlar varsayılan olarak özeldir:

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: same module
    println(u.age)   // OK: public
}
```

## Görünürlük

| Belirleyici | Kapsam |
|----------|-------|
| (yok) | Yalnızca modül |
| `pub` | Herkese açık |

## Sonraki

[Bölüm 6: Enum'lar ve Toplam Tipler](ch06-enums-and-sum-types.md)
