# Chapitre 5 : Structs

Les structs sont la manière de V de définir des types de données personnalisés.

## Définir des structs

```v
struct Point {
    x int
    y int
}

fn main() {
    p := Point{x: 10, y: 20}
    println('(${p.x}, ${p.y})')
}
```

## Méthodes

```v
struct Point {
    x int
    y int
}

fn (p Point) str() string {
    return '(${p.x}, ${p.y})'
}

fn main() {
    p := Point{x: 10, y: 20}
    println(p.str())
}
```

## Structs imbriquées

```v
struct Point {
    x int
    y int
}

struct Circle {
    Point
    radius f64
}

fn main() {
    c := Circle{
        Point: Point{x: 0, y: 0}
        radius: 5.0
    }
    println('(${c.x}, ${c.y}) r=${c.radius}')
}
```

## Modificateurs d'accès

Les champs sont privés par défaut. Utilisez `pub` pour les rendre publics :

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

## Résumé

Dans ce chapitre, vous avez appris les structs, les méthodes, l'imbrication et les modificateurs d'accès. Dans le chapitre suivant, nous explorerons les enums et les types somme.
