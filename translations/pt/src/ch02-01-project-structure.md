# Estrutura do Projeto

Um projeto V é um diretório com um arquivo `v.mod`:

```
my_project/
├── v.mod
├── main.v
├── my_module.v
└── my_module_test.v
```

## v.mod

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Criando um projeto

```bash
v init
```

## Próximo

[v.mod](ch02-02-vmod.md)
