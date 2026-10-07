# Bölüm 18: Bellek Yönetimi Derinlemesine

## GC modları

V, her biri farklı kullanım durumlarına uygun çeşitli bellek yönetimi stratejileri sağlar.

| Mod | Bayrak | Kullanım durumu |
|------|------|----------|
| Boehm GC | `-gc boehm` | Genel amaçlı |
| Autofree | `-autofree` | Otomatik serbest bırakma |
| Yok | `-gc none` | Manuel yönetim |
| Prealloc | `-prealloc` | Arena tahsisi |

## Yığın vs yığın (Heap)

V, belleğin nereye tahsis edileceğini otomatik olarak belirler. Küçük, kısa ömürlü değerler yığında kalır. Daha büyük veya kaçan değerler heap'e gider.

```v
fn stack_example() int {
    x := 42
    y := x * 2
    return y
}

fn heap_example() []int {
    data := []int{len: 100, init: 0}
    return data
}

fn main() {
    a := stack_example()
    b := heap_example()
    println(a)
    println(b.len)
}
```

## Autofree modu

Autofree, değişkenler kapsam dışına çıktığında belleği otomatik olarak serbest bırakır. Heap tahsisleri için referans sayımı kullanır.

```v
fn create_user(name string) string {
    greeting := 'Hello, ${name}!'
    return greeting
}

fn main() {
    msg := create_user('World')
    println(msg)
}
```

## -gc none ve manuel bellek

`-gc none` ile V, çöp toplamayı devre dışı bırakır. `free` kullanarak belleği manuel olarak yönetmeniz gerekir.

```v
fn main() {
    mut data := []int{len: 1000, init: 0}
    for i in 0 .. 1000 {
        data[i] = i * 2
    }
    println(data[500])
    unsafe {
        data.free()
    }
}
```

## -prealloc arena tahsisi

Prealloc, sıkı döngülerde daha iyi performans için arena tahsisi kullanır. Tahsisler toplu halde serbest bırakılır.

```v
fn process_items(count int) int {
    mut total := 0
    $if prealloc {
        for i in 0 .. count {
            total += i * i
        }
    } $else {
        for i in 0 .. count {
            total += i * i
        }
    }
    return total
}

fn main() {
    result := process_items(10000)
    println(result)
}
```

## Güvensiz kod

`unsafe` bloğu, V'nin güvenlik garantilerini bypass eden işlemlere izin verir, örneğin pointer aritmetiği ve doğrudan bellek erişimi.

```v
fn main() {
    x := 42
    p := unsafe { &x }
    println(p)
    unsafe {
        q := p + 1
        println(q)
    }
}
```

### Pointer aritmetiği

```v
fn main() {
    arr := [10, 20, 30, 40, 50]
    unsafe {
        p := &arr[0]
        first := p[0]
        second := p[1]
        third := p[2]
        println('${first} ${second} ${third}')
    }
}
```

## Performans ayarlama

Doğru bellek yönetimi modunu seçmek performansı önemli ölçüde etkileyebilir.

### Farklı modlarda benchmark

```v
fn benchmark_allocations(iterations int) i64 {
    sw := i64(0)
    $if boehm ? {
        sw = i64(1)
    }
    $if autofree ? {
        sw = i64(2)
    }
    $if prealloc ? {
        sw = i64(3)
    }
    return sw
}

fn main() {
    mode := benchmark_allocations(1000000)
    println('Mode: ${mode}')
}
```

### Veri yapılarını optimizasyon

```v
struct Point {
    x f64
    y f64
}

fn sum_points(points []Point) f64 {
    mut total := 0.0
    for p in points {
        total += p.x + p.y
    }
    return total
}

fn main() {
    points := []Point{len: 10000, init: Point{x: 1.0, y: 2.0}}
    result := sum_points(points)
    println(result)
}
```

## Özet

Bu bölümde bellek yönetimi modları, yığın vs heap tahsisi, autofree, manuel bellek yönetimi, prealloc, güvensiz kod ve performans ayarlama hakkında bilgi edindiniz. Sonraki bölümde araçları inceleyeceğiz.
