# Bölüm 7: Modüller ve Paketler

## Modül Sistemi

V, kodu modüller halinde düzenler. Bir modül, `.v` dosyalarını içeren bir dizindir:

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

## Görünürlük

- `pub` — herkese açık, diğer modüllerden erişilebilir
- (belirleyici yok) — özel, yalnızca modül içi

## VPM

V Paket Yöneticisi (VPM) topluluk paketlerini barındırır:

```bash
v install vsl
```

## Özet

Bu bölümde modüller, görünürlük ve VPM hakkında bilgi edindiniz. Sonraki bölümde koleksiyonları inceleyeceğiz.
