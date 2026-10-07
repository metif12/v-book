# Errores Personalizados

```v
struct MyError {
    msg string
}

fn (e MyError) msg() string {
    return e.msg
}

fn fail() !int {
    return error(MyError{msg: 'something went wrong'}.msg())
}

fn main() {
    result := fail() or {
        println(err.msg())
        return
    }
    println(result)
}
```

## Siguiente

[Capítulo 10: Genéricos](ch10-generics.md)
