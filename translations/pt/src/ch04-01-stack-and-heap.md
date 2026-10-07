# Stack e Heap

V decide automaticamente se aloca na stack ou no heap:

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

## Stack

- Alocação e desalocação rápidas
- Tamanho fixo em tempo de compilação
- Liberada automaticamente quando o escopo termina

## Heap

- Tamanho dinâmico
- Alocação mais lenta
- Gerenciado por GC ou autofree

## Próximo

[Coleta de Lixo](ch04-02-garbage-collection.md)
