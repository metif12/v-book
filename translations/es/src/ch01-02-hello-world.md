# ¡Hola, Mundo!

Crea un archivo llamado `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Ejecútalo:

```bash
v run main.v
```

Salida:

```
Hello, World!
```

## Anatomía de un programa V

Desglosemos el programa:

- `fn main()` — Todo programa V comienza con una función `main`. La palabra clave `fn` declara una función.
- `println(...)` — Una función integrada que imprime una línea en la salida estándar.
- `'Hello, World!'` — Un literal de string. V usa comillas simples para los strings.

## Compilar vs ejecutar

`v run` compila y ejecuta en un solo paso. También puedes compilar primero:

```bash
v main.v
./main
```

## Siguiente

[¡Hola, V!](ch01-03-hello-v.md)
