# الفصل 12: مشروع الإدخال/الإخراج: بناء أداة CLI

في هذا الفصل، سنبني أداة سطر أوامر بسيطة تقرأ ملفاً وتحسب أسطره وكلماته وأحرفه.

## إعداد المشروع

```bash
mkdir wordcount
cd wordcount
v init
```

## التنفيذ

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

## التشغيل

```bash
v run . main.v
```

## الملخص

في هذا الفصل، بنيت أداة سطر أوامر. في الفصل التالي، سنستكشف الميزات الوظيفية.
