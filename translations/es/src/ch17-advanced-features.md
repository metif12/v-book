# Capítulo 17: Características Avanzadas

## Atributos

Los anotaciones son anotaciones de metadatos colocadas antes de las declaraciones. Controlan el comportamiento del compilador, sugerencias de optimización y el ciclo de vida de la API.

### [deprecated]

Marca una función o tipo como obsoleto. El compilador emite una advertencia cuando se usa el elemento.

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

Sugiere al compilador que inserte la función en el sitio de llamada, eliminando la sobrecarga de la llamada. Ideal para funciones pequeñas y llamadas frecuentemente.

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

Marca una función como insegura, permitiéndole usar bloques `unsafe` sin que el llamador también esté marcado como inseguro.

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

Compilación condicional en tiempo de compilación. El bloque se incluye solo cuando la condición es verdadera.

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## Código en tiempo de compilación

V proporciona varias construcciones en tiempo de compilación que se ejecutan durante la compilación, permitiendo metaprogramación y abstracciones de costo cero.

### $if

Evalúa condiciones en tiempo de compilación. Soporta detección de plataforma, verificación de arquitectura y banderas personalizadas.

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

Itera en tiempo de compilación sobre arrays, campos de structs o rangos. Útil para generar código repetitivo.

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

Aserciones en tiempo de compilación que abortan la compilación si la condición es falsa.

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## Sobrecarga de operadores

V permite definir comportamiento personalizado para operadores en tipos definidos por el usuario. Cada operador se mapea a un método con una firma específica.

### Operadores aritméticos

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

### Operadores de comparación

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

### Operador de índice

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

## Reflexión en tiempo de compilación

La construcción `$for` de V puede iterar sobre campos de structs en tiempo de compilación, permitiendo serialización automática, validación y más.

### Iterando campos de structs

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

### Generando código de validación

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

## Resumen

En este capítulo, aprendiste sobre atributos, código en tiempo de compilación, sobrecarga de operadores y reflexión en tiempo de compilación. Estas características permiten poderosos patrones de metaprogramación y control detallado sobre la compilación. En el siguiente capítulo, exploraremos la gestión de memoria en profundidad.
