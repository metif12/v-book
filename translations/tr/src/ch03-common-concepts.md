# Bölüm 3: Ortak Kavramlar

Bu bölüm, V'deki ortak programlama kavramlarını kapsar: değişkenler, veri tipleri, fonksiyonlar, yorumlar ve kontrol akışı.

## Değişkenler ve Değişkenlik

V'de değişkenler varsayılan olarak değişmezdir. Değişken yapmak için `mut` kullanın:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Hata: name değişmez

    mut count := 0
    count = 1  // Tamam: count değişkendir
    count++
    println(count)
}
```

## Veri Tipleri

V'nin zengin bir tip sistemi vardır:

```v
fn main() {
    // Tamsayılar
    a := 42        // int
    b := i64(100)  // 64-bit tamsayı
    c := u8(255)   // işaretsiz 8-bit

    // Ondalıklı sayılar
    pi := 3.14     // f64
    e := f32(2.71) // 32-bit ondalıklı

    // Diğer tipler
    name := 'V'    // string
    is_ok := true  // bool
    letter := `A`  // rune (tek karakter)

    println('${a} ${b} ${c}')
    println('${pi} ${e}')
    println('${name} ${is_ok} ${letter}')
}
```

## Fonksiyonlar

Fonksiyonlar `fn` ile tanımlanır:

```v
fn add(a int, b int) int {
    return a + b
}

fn greet(name string) {
    println('Hello, ${name}!')
}

fn main() {
    result := add(2, 3)
    println(result)
    greet('World')
}
```

## Yorumlar

```v
// This is a line comment

/* This is a
   block comment */
```

## Kontrol Akışı

### If

```v
fn main() {
    age := 25
    if age >= 18 {
        println('Adult')
    } else {
        println('Minor')
    }
}
```

### For döngüsü

```v
fn main() {
    // Loop over an array
    fruits := ['apple', 'banana', 'cherry']
    for fruit in fruits {
        println(fruit)
    }

    // Range loop
    for i in 0 .. 5 {
        println(i)
    }
}
```

### Match

```v
fn main() {
    color := 'blue'
    match color {
        'red' { println('Red!') }
        'blue' { println('Blue!') }
        else { println('Other color') }
    }
}
```

## Özet

Bu bölümde V'deki değişkenler, veri tipleri, fonksiyonlar, yorumlar ve kontrol akışı hakkında bilgi edindiniz. Sonraki bölümde sahiplik ve bellek yönetimini inceleyeceğiz.
