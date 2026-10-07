# Capítulo 4: Posse e Memória

V adota uma abordagem diferente de gerenciamento de memória em relação a muitas linguagens. Em vez de gerenciamento manual de memória ou apenas coleta de lixo, V oferece múltiplas estratégias.

## Stack e Heap

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

## Coleta de Lixo

V usa um coletor de lixo por padrão. Você não precisa liberar memória manualmente:

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

V tem um modo autofree que libera memória automaticamente quando variáveis saem de escopo:

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

## Referências

Você pode usar referências para evitar copiar grandes volumes de dados:

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

## Modos de gerenciamento de memória

| Modo | Flag | Descrição |
|------|------|-------------|
| GC (padrão) | `-gc boehm` | Coletor de lixo Boehm |
| Autofree | `-autofree` | Liberação automática de memória |
| Nenhum | `-gc none` | Gerenciamento manual de memória |
| Prealloc | `-prealloc` | Alocação em arena |

## Resumo

Neste capítulo, você aprendeu sobre as opções de gerenciamento de memória de V. No próximo capítulo, vamos explorar structs.
