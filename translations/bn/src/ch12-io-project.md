# অধ্যায় 12: I/O প্রজেক্ট: CLI টুল তৈরি

এই অধ্যায়ে আমরা একটি সরল কমান্ড-লাইন টুল তৈরি করব যা একটি ফাইল পড়ে এবং এর লাইন, শব্দ এবং অক্ষর গণনা করে।

## প্রজেক্ট সেটআপ

```bash
mkdir wordcount
cd wordcount
v init
```

## বাস্তবায়ন

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

## চালানো

```bash
v run . main.v
```

## সারসংক্ষেপ

এই অধ্যায়ে আপনি একটি কমান্ড-লাইন টুল তৈরি করেছেন। পরবর্তী অধ্যায়ে আমরা ফাংশনাল ফিচার শিখব।
