# Type Result

```v
fn parse_number(s string) !int {
    return s.int()
}

fn main() {
    n := parse_number('42') or {
        println('Failed to parse')
        return
    }
    println(n)
}
```

## Propagation des erreurs

```v
import os

fn read_file(path string) !string {
    return os.read_file(path)
}

fn main() {
    content := read_file('main.v') or {
        println('Failed to read file')
        return
    }
    println(content)
}
```

## Suivant

[Erreurs personnalisées](ch09-03-custom-errors.md)
