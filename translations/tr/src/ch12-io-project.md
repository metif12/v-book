# Bölüm 12: I/O Projesi: CLI Aracı Oluşturma

Bu bölümde bir dosyayı okuyan ve satır, kelime ve karakter sayan basit bir komut satırı aracı oluşturacağız.

## Proje kurulumu

```bash
mkdir wordcount
cd wordcount
v init
```

## Uygulama

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

## Çalıştırma

```bash
v run . main.v
```

## Özet

Bu bölümde bir komut satırı aracı oluşturdunuz. Sonraki bölümde fonksiyonel özellikleri inceleyeceğiz.
