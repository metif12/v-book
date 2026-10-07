# Capítulo 18: Aprofundamento em Gerenciamento de Memória

## Modos de GC

V fornece várias estratégias de gerenciamento de memória, cada uma adequada a diferentes casos de uso.

| Modo | Flag | Caso de uso |
|------|------|----------|
| Boehm GC | `-gc boehm` | Uso geral |
| Autofree | `-autofree` | Liberação automática |
| Nenhum | `-gc none` | Gerenciamento manual |
| Prealloc | `-prealloc` | Alocação em arena |

## Stack vs heap

V decide automaticamente onde alocar memória. Valores pequenos e de curta duração permanecem na stack. Valores maiores ou que escapam vão para o heap.

```v
fn stack_example() int {
    x := 42
    y := x * 2
    return y
}

fn heap_example() []int {
    data := []int{len: 100, init: 0}
    return data
}

fn main() {
    a := stack_example()
    b := heap_example()
    println(a)
    println(b.len)
}
```

## Modo Autofree

Autofree libera memória automaticamente quando variáveis saem de escopo. Ele usa contagem de referências para alocações no heap.

```v
fn create_user(name string) string {
    greeting := 'Hello, ${name}!'
    return greeting
}

fn main() {
    msg := create_user('World')
    println(msg)
}
```

## -gc none e memória manual

Com `-gc none`, V desabilita a coleta de lixo. Você deve gerenciar memória manualmente usando `free`.

```v
fn main() {
    mut data := []int{len: 1000, init: 0}
    for i in 0 .. 1000 {
        data[i] = i * 2
    }
    println(data[500])
    unsafe {
        data.free()
    }
}
```

## Alocação em arena com -prealloc

Prealloc usa alocação em arena para melhor desempenho em loops apertados. As alocações são liberadas em massa.

```v
fn process_items(count int) int {
    mut total := 0
    $if prealloc {
        for i in 0 .. count {
            total += i * i
        }
    } $else {
        for i in 0 .. count {
            total += i * i
        }
    }
    return total
}

fn main() {
    result := process_items(10000)
    println(result)
}
```

## Código inseguro

O bloco `unsafe` permite operações que contornam as garantias de segurança de V, como aritmética de ponteiros e acesso direto à memória.

```v
fn main() {
    x := 42
    p := unsafe { &x }
    println(p)
    unsafe {
        q := p + 1
        println(q)
    }
}
```

### Aritmética de ponteiros

```v
fn main() {
    arr := [10, 20, 30, 40, 50]
    unsafe {
        p := &arr[0]
        first := p[0]
        second := p[1]
        third := p[2]
        println('${first} ${second} ${third}')
    }
}
```

## Ajuste de desempenho

Escolher o modo correto de gerenciamento de memória pode impactar significativamente o desempenho.

### Fazendo benchmark de diferentes modos

```v
fn benchmark_allocations(iterations int) i64 {
    sw := i64(0)
    $if boehm ? {
        sw = i64(1)
    }
    $if autofree ? {
        sw = i64(2)
    }
    $if prealloc ? {
        sw = i64(3)
    }
    return sw
}

fn main() {
    mode := benchmark_allocations(1000000)
    println('Mode: ${mode}')
}
```

### Otimizando estruturas de dados

```v
struct Point {
    x f64
    y f64
}

fn sum_points(points []Point) f64 {
    mut total := 0.0
    for p in points {
        total += p.x + p.y
    }
    return total
}

fn main() {
    points := []Point{len: 10000, init: Point{x: 1.0, y: 2.0}}
    result := sum_points(points)
    println(result)
}
```

## Resumo

Neste capítulo, você aprendeu sobre modos de gerenciamento de memória, alocação stack vs heap, autofree, gerenciamento manual de memória, prealloc, código inseguro e ajuste de desempenho. No próximo capítulo, vamos explorar ferramentas.
