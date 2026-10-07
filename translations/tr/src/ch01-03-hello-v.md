# Merhaba, V!

Daha ilginç bir örneğe bakalım:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Çalıştırın:

```bash
v run main.v
```

Çıktı:

```
Hello, V!
V is a great language.
```

## String interpolasyonu

V, string interpolasyonu için `${...}` kullanır. `${...}` içindeki herhangi bir ifade değerlendirilir ve string'e dönüştürülür:

```v
fn main() {
    a := 42
    b := 3.14
    println('a = ${a}, b = ${b}')
    println('a + 10 = ${a + 10}')
}
```

## Değişkenler

Bir değişken tanımlamak ve başlatmak için `:=` kullanın:

```v
fn main() {
    name := 'V'
    version := 0.5
    is_awesome := true
    println('${name} v${version} is awesome: ${is_awesome}')
}
```

## Sonraki

[Bölüm 2: Proje Oluşturma](ch02-building-a-project.md)
