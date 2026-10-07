# अध्याय 12: I/O प्रोजेक्ट: CLI टूल बनाना

इस अध्याय में, हम एक सरल कमांड-लाइन टूल बनाएंगे जो फ़ाइल को पढ़ता है और उसकी पंक्तियों, शब्दों और वर्णों की गिनती करता है।

## प्रोजेक्ट सेटअप

```bash
mkdir wordcount
cd wordcount
v init
```

## इम्प्लीमेंटेशन

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

## चलाना

```bash
v run . main.v
```

## सारांश

इस अध्याय में, आपने एक कमांड-लाइन टूल बनाया। अगले अध्याय में, हम फ़ंक्शनल फ़ीचर्स का पता लगाएंगे।
