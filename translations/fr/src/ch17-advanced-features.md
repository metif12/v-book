# Chapitre 17 : Fonctionnalités avancées

## Attributs

Les attributs sont des annotations de métadonnées placées avant les déclarations. Ils contrôlent le comportement du compilateur, les indices d'optimisation et le cycle de vie des API.

### [deprecated]

Marque une fonction ou un type comme obsolète. Le compilateur émet un avertissement lorsque l'élément est utilisé.

```v
[deprecated]
fn old_add(a int, b int) int {
    return a + b
}

[deprecated: 'Use new_add instead']
fn old_multiply(a int, b int) int {
    return a * b
}
```

### [inline]

Indique au compilateur d'inliner la fonction au site d'appel, éliminant la surcharge d'appel. Idéal pour les petites fonctions fréquemment appelées.

```v
[inline]
fn square(x int) int {
    return x * x
}

fn main() {
    result := square(5)
    println(result)
}
```

### [unsafe]

Marque une fonction comme non sécurisée, lui permettant d'utiliser des blocs `unsafe` sans que l'appelant soit également marqué unsafe.

```v
[unsafe]
fn read_pointer(ptr voidptr) int {
    return unsafe { *(&int(ptr)) }
}

fn main() {
    x := 42
    val := read_pointer(&x)
    println(val)
}
```

### [if]

Compilation conditionnelle au moment de la compilation. Le bloc n'est inclus que lorsque la condition est vraie.

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## Code au moment de la compilation

V fournit plusieurs constructions au moment de la compilation qui s'exécutent pendant la compilation, permettant la métaprogrammation et les abstractions à coût nul.

### $if

Évalue les conditions au moment de la compilation. Supporte la détection de plateforme, les vérifications d'architecture et les options personnalisées.

```v
$if windows {
    const os_name = 'Windows'
} $else $if macos {
    const os_name = 'macOS'
} $else $if linux {
    const os_name = 'Linux'
} $else {
    const os_name = 'Unknown'
}

fn main() {
    println('Running on ${os_name}')
}
```

### $for

Itère au moment de la compilation sur des tableaux, des champs de struct ou des plages. Utile pour générer du code répétitif.

```v
const platforms = ['windows', 'linux', 'macos']

fn is_platform(name string) bool {
    return name in platforms
}

fn main() {
    println(is_platform('windows'))
    println(is_platform('linux'))
    println(is_platform('macos'))
    println(is_platform('freebsd'))
}
```

### $assert

Assertions au moment de la compilation qui interrompent la compilation si la condition est fausse.

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## Surcharge d'opérateurs

V permet de définir un comportement personnalisé pour les opérateurs sur les types définis par l'utilisateur. Chaque opérateur correspond à une méthode avec une signature spécifique.

### Opérateurs arithmétiques

```v
struct Vec2 {
    x f64
    y f64
}

fn (a Vec2) + (b Vec2) Vec2 {
    return Vec2{x: a.x + b.x, y: a.y + b.y}
}

fn (a Vec2) - (b Vec2) Vec2 {
    return Vec2{x: a.x - b.x, y: a.y - b.y}
}

fn (a Vec2) * (b Vec2) Vec2 {
    return Vec2{x: a.x * b.x, y: a.y * b.y}
}

fn (a Vec2) / (b Vec2) Vec2 {
    return Vec2{x: a.x / b.x, y: a.y / b.y}
}

fn main() {
    a := Vec2{x: 10, y: 20}
    b := Vec2{x: 2, y: 4}
    sum := a + b
    diff := a - b
    prod := a * b
    quot := a / b
    println('Sum: ${sum.x}, ${sum.y}')
    println('Diff: ${diff.x}, ${diff.y}')
    println('Prod: ${prod.x}, ${prod.y}')
    println('Quot: ${quot.x}, ${quot.y}')
}
```

### Opérateurs de comparaison

```v
struct Money {
    amount   f64
    currency string
}

fn (a Money) == (b Money) bool {
    return a.amount == b.amount && a.currency == b.currency
}

fn main() {
    a := Money{amount: 10.0, currency: 'USD'}
    b := Money{amount: 10.0, currency: 'USD'}
    c := Money{amount: 20.0, currency: 'USD'}
    println(a == b)
    println(a == c)
}
```

### Opérateur d'indexation

```v
struct Grid {
    data [][]int
}

fn (g Grid) row_count() int {
    return g.data.len
}

fn (g Grid) get(row int, col int) int {
    return g.data[row][col]
}

fn main() {
    g := Grid{
        data: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    }
    println(g.row_count())
    println(g.get(1, 2))
}
```

## Réflexion au moment de la compilation

La construction `$for` de V peut itérer sur les champs de struct au moment de la compilation, permettant la sérialisation automatique, la validation et plus encore.

### Itérer sur les champs de struct

```v
struct User {
    id    int
    name  string
    email string
    age   int
}

fn main() {
    u := User{
        id: 1
        name: 'Alice'
        email: 'alice@example.com'
        age: 30
    }
    $for field in User.fields {
        $if field.typ is string {
            println('${field.name} is a string field')
        } $else $if field.typ is int {
            println('${field.name} is an int field')
        }
    }
    println('${u.name} is ${u.age} years old')
}
```

### Générer du code de validation

```v
struct Config {
    host    string
    port    int
    timeout f64
}

fn validate_config(c Config) ! {
    $for field in Config.fields {
        $if field.typ is string {
            if c.$(field.name).len == 0 {
                return error('${field.name} must not be empty')
            }
        } $else $if field.typ is int {
            if c.$(field.name) <= 0 {
                return error('${field.name} must be positive')
            }
        }
    }
}

fn main() {
    cfg := Config{
        host: 'localhost'
        port: 8080
        timeout: 30.0
    }
    validate_config(cfg) or {
        println('Config invalid: ${err}')
        return
    }
    println('Config is valid')
}
```

## Résumé

Dans ce chapitre, vous avez appris les attributs, le code au moment de la compilation, la surcharge d'opérateurs et la réflexion au moment de la compilation. Ces fonctionnalités permettent des patrons de métaprogrammation puissants et un contrôle fin de la compilation. Dans le chapitre suivant, nous explorerons la gestion de la mémoire en profondeur.
