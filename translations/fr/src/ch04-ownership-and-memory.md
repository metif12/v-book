# Chapitre 4 : Propriété et mémoire

V adopte une approche différente de la gestion de la mémoire par rapport à de nombreux langages. Au lieu d'une gestion manuelle de la mémoire ou d'un ramasse-miettes seul, V offre plusieurs stratégies.

## Pile et tas

V décide automatiquement d'allouer sur la pile ou le tas :

```v
fn main() {
    // Stack-allocated (small, fixed size)
    x := 42
    arr := [1, 2, 3]

    // Heap-allocated (large, dynamic)
    mut big := []int{}
    for i in 0 .. 1000 {
        big << i
    }

    println('${x} ${arr} ${big.len}')
}
```

## Ramasse-miettes

V utilise un ramasse-miettes par défaut. Vous n'avez pas besoin de libérer la mémoire manuellement :

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

## Autofree

V dispose d'un mode autofree qui libère automatiquement la mémoire lorsque les variables sortent de leur portée :

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data is automatically freed here
}

fn main() {
    process()
    println('done')
}
```

## Références

Vous pouvez utiliser des références pour éviter de copier des données volumineuses :

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## Modes de gestion de la mémoire

| Mode | Option | Description |
|------|--------|-------------|
| GC (par défaut) | `-gc boehm` | Ramasse-miettes Boehm |
| Autofree | `-autofree` | Libération automatique de la mémoire |
| Aucun | `-gc none` | Gestion manuelle de la mémoire |
| Prealloc | `-prealloc` | Allocation par arène |

## Résumé

Dans ce chapitre, vous avez appris les options de gestion de la mémoire de V. Dans le chapitre suivant, nous explorerons les structs.
