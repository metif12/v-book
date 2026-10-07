# Kapitel 7: Module und Pakete

## Modulsystem

V organisiert Code in Module. Ein Modul ist ein Verzeichnis mit `.v`-Dateien:

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

## Sichtbarkeit

- `pub` — öffentlich, von anderen Modulen zugreifbar
- (kein Modifikator) — privat, nur innerhalb des Moduls

## VPM

Der V Package Manager (VPM) hostet Community-Pakete:

```bash
v install vsl
```

## Zusammenfassung

In diesem Kapitel haben Sie Module, Sichtbarkeit und VPM kennengelernt. Im nächsten Kapitel untersuchen wir Collections.
