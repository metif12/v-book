# Chapter 12: I/O Project: Building a CLI Tool

In this chapter, we'll build a simple command-line tool that reads a file and counts its lines, words, and characters.

## Project setup

```bash
mkdir wordcount
cd wordcount
v init
```

## Implementation

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

## Running

```bash
v run . main.v
```

## Summary

In this chapter, you built a command-line tool. In the next chapter, we'll explore functional features.
