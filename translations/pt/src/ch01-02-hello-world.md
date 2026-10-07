# Olá, Mundo!

Crie um arquivo chamado `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Execute:

```bash
v run main.v
```

Saída:

```
Hello, World!
```

## Anatomia de um programa V

Vamos analisar o programa:

- `fn main()` — Todo programa V começa com uma função `main`. A palavra-chave `fn` declara uma função.
- `println(...)` — Uma função imbutida que imprime uma linha na saída padrão.
- `'Hello, World!'` — Uma string literal. V usa aspas simples para strings.

## Compilando vs executando

`v run` compila e executa em uma só etapa. Você também pode compilar primeiro:

```bash
v main.v
./main
```

## Próximo

[Olá, V!](ch01-03-hello-v.md)
