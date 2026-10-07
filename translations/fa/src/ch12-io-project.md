# فصل ۱۲: پروژه I/O: ساخت یک ابزار CLI

در این فصل، یک ابزار خط فرمان ساده می‌سازیم که یک فایل را می‌خواند و تعداد خطوط، کلمات و کاراکترهای آن را می‌شمارد.

## راه‌اندازی پروژه

```bash
mkdir wordcount
cd wordcount
v init
```

## پیاده‌سازی

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

## اجرا

```bash
v run . main.v
```

## خلاصه

در این فصل، یک ابزار خط فرمان ساختید. در فصل بعد، به ویژگی‌های تابعی می‌پردازیم.
