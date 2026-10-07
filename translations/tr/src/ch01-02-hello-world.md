# Merhaba, Dünya!

`main.v` adında bir dosya oluşturun:

```v
fn main() {
    println('Hello, World!')
}
```

Çalıştırın:

```bash
v run main.v
```

Çıktı:

```
Hello, World!
```

## V programının anatomisi

Programı parçalara ayıralım:

- `fn main()` — Her V programı bir `main` fonksiyonuyla başlar. `fn` anahtar kelimesi bir fonksiyon tanımlar.
- `println(...)` — stdout'a bir satır yazdırılan yerleşik bir fonksiyon.
- `'Hello, World!'` — Bir string literal. V, string'ler için tek tırnak kullanır.

## Derleme vs çalıştırma

`v run` tek adımda derler ve çalıştırır. Önce de derleyebilirsiniz:

```bash
v main.v
./main
```

## Sonraki

[Merhaba, V!](ch01-03-hello-v.md)
