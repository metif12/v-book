# Capítulo 2: Construyendo un Proyecto

En este capítulo, aprenderás a estructurar un proyecto V, usar `v.mod`, formatear código con `v fmt` y escribir pruebas con `v test`.

## Estructura del proyecto

Un proyecto V es un directorio con un archivo `v.mod` y uno o más archivos `.v`:

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

Todo proyecto V tiene un archivo `v.mod` que describe el proyecto:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

Crea un nuevo proyecto con:

```bash
v init
```

Esto crea un `v.mod` y un `main.v` con una plantilla básica.

## Formateo con v fmt

V tiene un formateador de código integrado. Ejecútalo en tu proyecto:

```bash
v fmt -w .
```

La opción `-w` escribe el código formateado de vuelta en los archivos.

## Pruebas con v test

V tiene un framework de pruebas integrado. Crea un archivo que termine en `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Ejecuta las pruebas:

```bash
v test .
```

## Resumen

En este capítulo, aprendiste a estructurar un proyecto V, usar `v.mod`, formatear código y escribir pruebas. En el siguiente capítulo, profundizaremos en los conceptos comunes de programación en V.
