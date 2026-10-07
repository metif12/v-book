# Kapitel 12: I/O-Projekt: Ein CLI-Tool bauen

In diesem Kapitel bauen wir ein einfaches Kommandozeilen-Tool, das eine Datei liest und deren Zeilen, Wörter und Zeichen zählt.

## Projekt-Setup

```bash
mkdir wordcount
cd wordcount
v init
```

## Implementierung

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

## Ausführung

```bash
v run . main.v
```

## Zusammenfassung

In diesem Kapitel haben Sie ein Kommandozeilen-Tool gebaut. Im nächsten Kapitel untersuchen wir funktionale Merkmale.
