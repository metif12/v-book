# Capítulo 13: Recursos Funcionais

V suporta closures e funções de ordem superior.

## Closures

```v
fn main() {
    add := fn (a int, b int) int {
        return a + b
    }
    println(add(2, 3))
}
```

## Funções de ordem superior

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

## Funções anônimas

```v
fn main() {
    nums := [1, 2, 3, 4, 5]
    doubled := nums.map(fn (x int) int {
        return x * 2
    })
    println(doubled)
}
```

## Resumo

Neste capítulo, você aprendeu sobre closures e funções de ordem superior. No próximo capítulo, vamos explorar concorrência.
