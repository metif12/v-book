# Capítulo 19: Herramientas

## v fmt

Formatea el código fuente V según la guía de estilo oficial. Usa `-w` para escribir los cambios en su lugar.

```bash
v fmt -w .
```

### Formatear un solo archivo

```bash
v fmt -w main.v
```

### Verificar formato sin escribir

```bash
v fmt -check .
```

## v doc

Genera documentación desde archivos fuente V. Produce HTML por defecto.

```bash
v doc .
```

### Documentar un módulo específico

```bash
v doc -o docs/ .
```

## v profiler

Perfilaa la ejecución del programa para identificar cuellos de botella de rendimiento.

```bash
v -profile profile.txt run main.v
```

### Analizar la salida del perfil

```bash
v profile profile.txt
```

## v test

Ejecuta pruebas unitarias en el directorio actual o en el archivo especificado.

```bash
v test .
```

### Ejecutar una prueba específica

```bash
v test -run TestName .
```

### Ejecutar pruebas con cobertura

```bash
v test -cover .
```

## v check

Realiza análisis estático en código V, verificando errores, advertencias y problemas de estilo.

```bash
v check .
```

### Verificar un solo archivo

```bash
v check main.v
```

## Compilación cruzada

V puede compilar código para diferentes sistemas operativos y arquitecturas desde una sola máquina.

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### Especificar arquitectura

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### Compilación cruzada para objetivos embebidos

```bash
v -os embedded -arch arm main.v
```

## v doctor

Muestra información de diagnóstico sobre la instalación de V, incluyendo la versión del compilador, el sistema operativo y la configuración.

```bash
v doctor
```

## v up

Actualiza el compilador de V a la última versión.

```bash
v up
```

### Actualizar a una versión específica

```bash
v up --version 0.5.2
```

## Resumen

En este capítulo, aprendiste sobre el ecosistema de herramientas de V: `v fmt` para formateo, `v doc` para documentación, `v profiler` para análisis de rendimiento, `v test` para pruebas, `v check` para análisis estático, compilación cruzada, `v doctor` para diagnósticos y `v up` para auto-actualizaciones. En el siguiente capítulo, construiremos un proyecto final.
