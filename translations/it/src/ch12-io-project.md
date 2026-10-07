# Capitolo 12: Progetto I/O: Costruire uno Strumento CLI

In questo capitolo, costruiremo un semplice strumento a riga di comando che legge un file e conta le righe, le parole e i caratteri.

## Configurazione del progetto

```bash
mkdir wordcount
cd wordcount
v init
```

## Implementazione

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

## Esecuzione

```bash
v run . main.v
```

## Riassunto

In questo capitolo, hai costruito uno strumento a riga di comando. Nel prossimo capitolo, esploreremo le funzionalità funzionali.
