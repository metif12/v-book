# Chapter 12: I/O 프로젝트: CLI 도구 만들기

이 장에서는 파일을 읽어 줄, 단어, 문자의 개수를 세는 간단한 명령줄 도구를 만들어보겠습니다.

## 프로젝트 설정

```bash
mkdir wordcount
cd wordcount
v init
```

## 구현

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

## 실행

```bash
v run . main.v
```

## 요약

이 장에서는 명령줄 도구를 만들었습니다. 다음 장에서는 함수형 기능을 살펴보겠습니다.
