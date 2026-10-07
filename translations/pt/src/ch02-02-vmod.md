# v.mod

O arquivo `v.mod` descreve seu projeto:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Campos

| Campo | Descrição |
|-------|-------------|
| `name` | Nome do projeto (deve corresponder ao nome do diretório) |
| `description` | Descrição curta |
| `version` | Versão semântica |
| `license` | Identificador de licença |
| `dependencies` | Lista de nomes de pacotes VPM |

## Próximo

[Formatação com v fmt](ch02-03-formatting.md)
