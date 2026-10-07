# Formatação com v fmt

V tem um formatador de código imbutido:

```bash
v fmt -w .
```

A flag `-w` escreve as alterações de volta nos arquivos. Sem ela, o formatador imprime na saída padrão.

## Exemplo

Antes:

```v
fn main(){
println( 'hello' )
}
```

Depois de `v fmt`:

```v
fn main() {
    println('hello')
}
```

## Próximo

[Testes com v test](ch02-04-testing.md)
