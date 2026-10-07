# Capitolo 7: Moduli e Pacchetti

## Sistema di Moduli

V organizza il codice in moduli. Un modulo è una directory con file `.v`:

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

## Visibilità

- `pub` — pubblico, accessibile da altri moduli
- (nessun modificatore) — privato, solo modulo

## VPM

V Package Manager (VPM) ospita i pacchetti della comunità:

```bash
v install vsl
```

## Riassunto

In questo capitolo, hai imparato i moduli, la visibilità e VPM. Nel prossimo capitolo, esploreremo le collezioni.
