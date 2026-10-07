# Глава 12: Проект ввода-вывода: создание CLI-инструмента

В этой главе мы создадим простой инструмент командной строки, который читает файл и подсчитывает количество строк, слов и символов.

## Настройка проекта

```bash
mkdir wordcount
cd wordcount
v init
```

## Реализация

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

## Запуск

```bash
v run . main.v
```

## Итоги

В этой главе вы создали инструмент командной строки. В следующей главе мы рассмотрим функциональные возможности.
