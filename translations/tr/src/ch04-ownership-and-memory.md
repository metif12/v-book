# Bölüm 4: Sahiplik ve Bellek

V, birçok dilden farklı bir bellek yönetimi yaklaşımı benimser. Manuel bellek yönetimi veya yalnızca çöp toplama yerine, V birden fazla strateji sunar.

## Yığın ve Yığın (Heap)

V, yığın mı yoksa heap mi tahsis edileceğini otomatik olarak belirler:

```v
fn main() {
    // Stack-allocated (small, fixed size)
    x := 42
    arr := [1, 2, 3]

    // Heap-allocated (large, dynamic)
    mut big := []int{}
    for i in 0 .. 1000 {
        big << i
    }

    println('${x} ${arr} ${big.len}')
}
```

## Çöp Toplama

V varsayılan olarak bir çöp toplayıcı kullanır. Belleği manuel olarak serbest bırakmanıza gerek yoktur:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // Memory is automatically freed when no longer referenced
    println(names.len)
}
```

## Autofree

V'nin, değişkenler kapsam dışına çıktığında belleği otomatik olarak serbest bırakan bir autofree modu vardır:

```bash
v -autofree main.v
```

```v
fn process() {
    mut data := []int{}
    for i in 0 .. 1000 {
        data << i
    }
    // data is automatically freed here
}

fn main() {
    process()
    println('done')
}
```

## Referanslar

Büyük verilerin kopyalanmaktan kaçınmak için referanslar kullanabilirsiniz:

```v
fn modify(mut arr []int) {
    arr << 42
}

fn main() {
    mut data := [1, 2, 3]
    modify(mut data)
    println(data)
}
```

## Bellek yönetimi modları

| Mod | Bayrak | Açıklama |
|------|------|-------------|
| GC (varsayılan) | `-gc boehm` | Boehm garbage collector |
| Autofree | `-autofree` | Automatic memory freeing |
| Yok | `-gc none` | Manual memory management |
| Prealloc | `-prealloc` | Arena allocation |

## Özet

Bu bölümde V'nin bellek yönetimi seçenekleri hakkında bilgi edindiniz. Sonraki bölümde struct'ları inceleyeceğiz.
