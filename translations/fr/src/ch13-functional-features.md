# Chapitre 13 : Fonctionnalités fonctionnelles

V supporte les fermetures (closures) et les fonctions d'ordre supérieur.

## Fermetures (closures)

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## Fonctions d'ordre supérieur

```v
fn apply(f fn (int) int, x int) int {
    return f(x)
}

fn main() {
    double := fn (x int) int {
        return x * 2
    }
    println(apply(double, 5))
}
```

## Fonctions anonymes

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## Résumé

Dans ce chapitre, vous avez appris les fermetures et les fonctions d'ordre supérieur. Dans le chapitre suivant, nous explorerons la concurrence.
