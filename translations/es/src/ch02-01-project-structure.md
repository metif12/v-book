# Estructura del Proyecto

Un proyecto V es un directorio con un archivo `v.mod`:

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

## Crear un proyecto

```bash
v init
```

## Siguiente

[v.mod](ch02-02-vmod.md)
