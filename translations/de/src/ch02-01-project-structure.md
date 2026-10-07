# Projektstruktur

Ein V-Projekt ist ein Verzeichnis mit einer `v.mod`-Datei:

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

## Ein Projekt erstellen

```bash
v init
```

## Weiter

[v.mod](ch02-02-vmod.md)
