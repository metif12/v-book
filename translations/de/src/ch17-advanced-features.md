# Kapitel 17: Fortgeschrittene Merkmale

## Attribute

Attribute sind Metadaten-Annotationen, die vor Deklarationen platziert werden. Sie steuern das Compiler-Verhalten, Optimierungshinweise und den API-Lebenszyklus.

### [deprecated]

Markiert eine Funktion oder einen Typ als veraltet. Der Compiler gibt eine Warnung aus, wenn das Element verwendet wird.

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

Weist den Compiler an, die Funktion am Aufrufort zu inline zu setzen, wodurch der Aufrufaufwand entfällt. Am besten für kleine, häufig aufgerufene Funktionen geeignet.

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

Markiert eine Funktion als unsicher, sodass sie `unsafe`-Blöcke verwenden kann, ohne dass der Aufer ebenfalls als unsicher markiert sein muss.

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

Bedingte Kompilierung zur Kompilierzeit. Der Block wird nur eingeschlossen, wenn die Bedingung wahr ist.

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## Code zur Kompilierzeit

V bietet mehrere Konstrukte zur Kompilierzeit, die während der Kompilierung ausgeführt werden und Metaprogrammierung sowie Abstraktionen mit null Kosten ermöglichen.

### $if

Wertet Bedingungen zur Kompilierzeit aus. Unterstützt Plattformenerkennung, Architekturprüfungen und benutzerdefinierte Flags.

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

Iteriert zur Kompilierzeit über Arrays, Struct-Felder oder Bereiche. Nützlich für die Generierung von repetitivem Code.

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

Assertions zur Kompilierzeit, die die Kompilierung abbrechen, wenn die Bedingung falsch ist.

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## Operatorüberladung

V ermöglicht die Definition von benutzerdefiniertem Verhalten für Operatoren auf benutzerdefinierten Typen. Jeder Operator wird einer Methode mit einer bestimmten Signatur zugeordnet.

### Arithmetische Operatoren

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

### Vergleichsoperatoren

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

### Index-Operator

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

## Reflexion zur Kompilierzeit

Das `$for`-Konstrukt von V kann zur Kompilierzeit über Struct-Felder iterieren und ermöglicht automatische Serialisierung, Validierung und mehr.

### Struct-Felder iterieren

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

### Validierungscode generieren

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

## Zusammenfassung

In diesem Kapitel haben Sie Attribute, Code zur Kompilierzeit, Operatorüberladung und Reflexion zur Kompilierzeit kennengelernt. Diese Merkmale ermöglichen leistungsstarke Metaprogrammierungsmuster und feine Kontrolle über die Kompilierung. Im nächsten Kapitel untersuchen wir das Speichermanagement eingehend.
