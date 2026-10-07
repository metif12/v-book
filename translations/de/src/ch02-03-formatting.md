# Formatierung mit v fmt

V verfügt über einen integrierten Code-Formatierer:

```bash
v fmt -w .
```

Das Flag `-w` schreibt Änderungen zurück in die Dateien. Ohne das Flag gibt der Formatierer auf der Standardausgabe aus.

## Beispiel

Vorher:

```v
fn main(){
println( 'hello' )
}
```

Nach `v fmt`:

```v
fn main() {
    println('hello')
}
```

## Weiter

[Testen mit v test](ch02-04-testing.md)
