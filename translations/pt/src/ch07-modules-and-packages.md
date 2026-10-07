# Capítulo 7: Módulos e Pacotes

## Sistema de Módulos

V organiza código em módulos. Um módulo é um diretório com arquivos `.v`:

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

## Visibilidade

- `pub` — público, acessível de outros módulos
- (sem modificador) — privado, apenas módulo

## VPM

O V Package Manager (VPM) hospeda pacotes da comunidade:

```bash
v install vsl
```

## Resumo

Neste capítulo, você aprendeu sobre módulos, visibilidade e VPM. No próximo capítulo, vamos explorar coleções.
