# v fmt ile Biçimlendirme

V'nin yerleşik bir kod biçimlendiricisi vardır:

```bash
v fmt -w .
```

`-w` bayrağı değişiklikleri dosyaların üzerine yazar. Bu bayrak olmadan, biçimlendirici stdout'a yazdırır.

## Örnek

Öncesi:

```v
fn main(){
println( 'hello' )
}
```

`v fmt` sonrası:

```v
fn main() {
    println('hello')
}
```

## Sonraki

[v test ile Test Etme](ch02-04-testing.md)
