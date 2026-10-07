# Bab 12: Proyek I/O: Membangun Alat CLI

Dalam bab ini, kita akan membangun alat command-line sederhana yang membaca file dan menghitung baris, kata, dan karakter.

## Penyiapan proyek

```bash
mkdir wordcount
cd wordcount
v init
```

## Implementasi

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

## Menjalankan

```bash
v run . main.v
```

## Ringkasan

Dalam bab ini, Anda telah membangun alat command-line. Di bab berikutnya, kita akan menjelajahi fitur fungsional.
