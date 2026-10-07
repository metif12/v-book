# باب ۱۲: I/O پروجیکٹ: CLI ٹول بنانا

اس باب میں، ہم ایک سادہ کمانڈ لائن ٹول بنائیں گے جو فائل پڑھتا ہے اور اس کی لائنوں، الفاظ، اور حروف کا حساب کرتا ہے۔

## پروجیکٹ سیٹ اپ

```bash
mkdir wordcount
cd wordcount
v init
```

## عمل درآمد

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

## چلانا

```bash
v run . main.v
```

## خلاصہ

اس باب میں، آپ نے ایک کمانڈ لائن ٹول بنایا۔ اگلے باب میں، ہم فنکشنل خصوصیات کو دریافت کریں گے۔
