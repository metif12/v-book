# Capítulo 17: Recursos Avançados

## Atributos

Atributos são anotações de metadados colocadas antes de declarações. Eles controlam o comportamento do compilador, dicas de otimização e ciclo de vida da API.

### [deprecated]

Marca uma função ou tipo como depreciada. O compilador emite um aviso quando o item é usado.

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

Dica ao compilador para embutir a função no local da chamada, eliminando a sobrecarga de chamada. Melhor para funções pequenas e frequentemente chamadas.

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

Marca uma função como insegura, permitindo que ela use blocos `unsafe` sem que o chamador também seja marcado como inseguro.

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

Compilação condicional em tempo de compilação. O bloco é incluído apenas quando a condição é verdadeira.

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## Código em tempo de compilação

V fornece várias construções em tempo de compilação que são executadas durante a compilação, permitindo metaprogramação e abstrações de custo zero.

### $if

Avalia condições em tempo de compilação. Suporta detecção de plataforma, verificações de arquitetura e flags customizadas.

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

Itera em tempo de compilação sobre arrays, campos de struct ou intervalos. Útil para gerar código repetitivo.

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

Asserções em tempo de compilação que abortam a compilação se a condição for falsa.

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## Sobrecarga de operadores

V permite definir comportamento customizado para operadores em tipos definidos pelo usuário. Cada operador mapeia para um método com uma assinatura específica.

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

### Operadores de comparação

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

## Reflexão em tempo de compilação

A construção `$for` de V pode iterar sobre campos de struct em tempo de compilação, permitindo serialização automática, validação e mais.

### Iterando campos de struct

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

### Gerando código de validação

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

## Resumo

Neste capítulo, você aprendeu sobre atributos, código em tempo de compilação, sobrecarga de operadores e reflexão em tempo de compilação. Esses recursos permitem padrões poderosos de metaprogramação e controle refinado sobre a compilação. No próximo capítulo, vamos explorar gerenciamento de memória em profundidade.
