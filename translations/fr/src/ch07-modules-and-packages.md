# Chapitre 7 : Modules et paquets

## Système de modules

V organise le code en modules. Un module est un répertoire avec des fichiers `.v` :

```
my_project/
├── v.mod
├── main.v
└── math/
    └── math.v
```

`math/math.v` :

```v ignore
module math

pub fn add(a int, b int) int {
    return a + b
}
```

`main.v` :

```v ignore
import math

fn main() {
    println(math.add(2, 3))
}
```

## Visibilité

- `pub` — public, accessible depuis d'autres modules
- (aucun modificateur) — privé, module uniquement

## VPM

Le gestionnaire de paquets V (VPM) héberge les paquets de la communauté :

```bash
v install vsl
```

## Résumé

Dans ce chapitre, vous avez appris les modules, la visibilité et VPM. Dans le chapitre suivant, nous explorerons les collections.
