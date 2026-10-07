# Capítulo 7: Módulos y Paquetes

## Sistema de Módulos

V organiza el código en módulos. Un módulo es un directorio con archivos `.v`:

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

## Visibilidad

- `pub` — público, accesible desde otros módulos
- (sin modificador) — privado, solo módulo

## VPM

El Gestor de Paquetes de V (VPM) aloja paquetes de la comunidad:

```bash
v install vsl
```

## Resumen

En este capítulo, aprendiste sobre módulos, visibilidad y VPM. En el siguiente capítulo, exploraremos las colecciones.
