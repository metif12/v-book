# Formateo con v fmt

V tiene un formateador de código integrado:

```bash
v fmt -w .
```

La opción `-w` escribe los cambios de vuelta en los archivos. Sin ella, el formateador imprime en la salida estándar.

## Ejemplo

Antes:

```v
fn main(){
println( 'hello' )
}
```

Después de `v fmt`:

```v
fn main() {
    println('hello')
}
```

## Siguiente

[Pruebas con v test](ch02-04-testing.md)
