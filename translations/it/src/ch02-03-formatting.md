# Formattazione con v fmt

V ha un formattatore di codice integrato:

```bash
v fmt -w .
```

Il flag `-w` scrive le modifiche nei file. Senza di esso, il formattatore stampa su stdout.

## Esempio

Prima:

```v
fn main(){
println( 'hello' )
}
```

Dopo `v fmt`:

```v
fn main() {
    println('hello')
}
```

## Avanti

[Testing con v test](ch02-04-testing.md)
