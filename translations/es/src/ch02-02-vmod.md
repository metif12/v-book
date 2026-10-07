# v.mod

El archivo `v.mod` describe tu proyecto:

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

| Campo | Descripción |
|-------|-------------|
| `name` | Nombre del proyecto (debe coincidir con el nombre del directorio) |
| `description` | Descripción corta |
| `version` | Versión semántica |
| `license` | Identificador de licencia |
| `dependencies` | Lista de nombres de paquetes VPM |

## Siguiente

[Formateo con v fmt](ch02-03-formatting.md)
