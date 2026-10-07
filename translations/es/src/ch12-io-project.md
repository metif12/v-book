# Capítulo 12: Proyecto de I/O: Construyendo una Herramienta CLI

En este capítulo, construiremos una herramienta simple de línea de comandos que lee un archivo y cuenta sus líneas, palabras y caracteres.

## Configuración del proyecto

```bash
mkdir wordcount
cd wordcount
v init
```

## Implementación

```v no_run
import os

fn count(text string) (int, int, int) {
    lines := text.split('\n').len
    words := text.split(' ').len
    chars := text.len
    return lines, words, chars
}

fn main() {
    if os.args.len < 2 {
        println('Usage: wordcount <file>')
        exit(1)
    }

    path := os.args[1]
    content := os.read_file(path) or {
        println('Failed to read file: ${path}')
        exit(1)
    }

    lines, words, chars := count(content)
    println('Lines: ${lines}')
    println('Words: ${words}')
    println('Chars: ${chars}')
}
```

## Ejecución

```bash
v run . main.v
```

## Resumen

En este capítulo, construiste una herramienta de línea de comandos. En el siguiente capítulo, exploraremos las características funcionales.
