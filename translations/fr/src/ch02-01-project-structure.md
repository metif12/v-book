# Structure du projet

Un projet V est un répertoire avec un fichier `v.mod` :

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

## Créer un projet

```bash
v init
```

## Suivant

[v.mod](ch02-02-vmod.md)
