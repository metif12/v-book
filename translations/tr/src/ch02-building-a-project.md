# Bölüm 2: Proje Oluşturma

Bu bölümde bir V projesini nasıl yapılandıracağınızı, `v.mod` dosyasını nasıl kullanacağınızı, `v fmt` ile kod biçimlendirmeyi ve `v test` ile test yazmayı öğreneceksiniz.

## Proje yapısı

Bir V projesi, bir `v.mod` dosyası ve bir veya daha fazla `.v` dosyası içeren bir dizindir:

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

Her V projesinde projeyi tanımlayan bir `v.mod` dosyası vardır:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

Yeni bir proje oluşturmak için:

```bash
v init
```

Bu, temel bir şablon içeren bir `v.mod` ve bir `main.v` dosyası oluşturur.

## v fmt ile biçimlendirme

V'nin yerleşik bir kod biçimlendiricisi vardır. Projenizde çalıştırın:

```bash
v fmt -w .
```

`-w` bayrağı, biçimlendirilmiş kodu dosyaların üzerine yazar.

## v test ile test etme

V'nin yerleşik bir test çerçevesi vardır. `_test.v` ile biten bir dosya oluşturun:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Testleri çalıştırın:

```bash
v test .
```

## Özet

Bu bölümde bir V projesini yapılandırmayı, `v.mod` dosyasını kullanmayı, kod biçimlendirmeyi ve test yazmayı öğrendiniz. Sonraki bölümde V'deki ortak programlama kavramlarına dalacağız.
