# Capítulo 2: Construindo um Projeto

Neste capítulo, você aprenderá como estruturar um projeto V, usar `v.mod`, formatar código com `v fmt` e escrever testes com `v test`.

## Estrutura do projeto

Um projeto V é um diretório com um arquivo `v.mod` e um ou mais arquivos `.v`:

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

Todo projeto V tem um arquivo `v.mod` que descreve o projeto:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

Crie um novo projeto com:

```bash
v init
```

Isso cria um `v.mod` e um `main.v` com um modelo básico.

## Formatação com v fmt

V tem um formatador de código imbutido. Execute-o no seu projeto:

```bash
v fmt -w .
```

A flag `-w` escreve o código formatado de volta nos arquivos.

## Testes com v test

V tem um framework de testes imbutido. Crie um arquivo terminando em `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Execute os testes:

```bash
v test .
```

## Resumo

Neste capítulo, você aprendeu como estruturar um projeto V, usar `v.mod`, formatar código e escrever testes. No próximo capítulo, vamos mergulhar nos conceitos comuns de programação em V.
