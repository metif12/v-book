# Formatage avec v fmt

V dispose d'un formateur de code intégré :

```bash
v fmt -w .
```

L'option `-w` écrit les modifications dans les fichiers. Sans elle, le formateur affiche le résultat sur la sortie standard.

## Exemple

Avant :

```v
fn main(){
println( 'hello' )
}
```

Après `v fmt` :

```v
fn main() {
    println('hello')
}
```

## Suivant

[Tests avec v test](ch02-04-testing.md)
