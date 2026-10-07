# Capítulo 12: Projeto de I/O: Construindo uma Ferramenta CLI

Neste capítulo, vamos construir uma ferramenta simples de linha de comando que lê um arquivo e conta suas linhas, palavras e caracteres.

## Configuração do projeto

```bash
mkdir wordcount
cd wordcount
v init
```

## Implementação

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

## Executando

```bash
v run . main.v
```

## Resumo

Neste capítulo, você construiu uma ferramenta de linha de comando. No próximo capítulo, vamos explorar recursos funcionais.
