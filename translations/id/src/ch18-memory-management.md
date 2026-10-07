# Bab 18: Manajemen Memori Mendalam

## Mode GC

V menyediakan beberapa strategi manajemen memori, masing-masing cocok untuk use case yang berbeda.

| Mode | Flag | Use case |
|------|------|----------|
| Boehm GC | `-gc boehm` | General purpose |
| Autofree | `-autofree` | Automatic freeing |
| None | `-gc none` | Manual management |
| Prealloc | `-prealloc` | Arena allocation |

## Stack vs heap

V secara otomatis memutuskan di mana mengalokasikan memori. Nilai kecil yang berumur pendek tetap di stack. Nilai yang lebih besar atau escaped pergi ke heap.

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

## Mode autofree

Autofree secara otomatis membebaskan memori ketika variabel keluar dari scope. Ini menggunakan reference counting untuk alokasi heap.

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

## -gc none dan memori manual

Dengan `-gc none`, V menonaktifkan garbage collection. Anda harus mengelola memori secara manual menggunakan `free`.

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

## -prealloc arena allocation

Prealloc menggunakan arena allocation untuk performa yang lebih baik dalam loop ketat. Alokasi dibebarkan secara massal.

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

## Kode unsafe

Blok `unsafe` memungkinkan operasi yang melewati jaminan keamanan V, seperti pointer arithmetic dan akses memori langsung.

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

### Pointer arithmetic

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

## Tuning performa

Memilih mode manajemen memori yang tepat dapat berdampak signifikan pada performa.

### Benchmark mode yang berbeda

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

### Optimasi struktur data

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

## Ringkasan

Dalam bab ini, Anda telah belajar tentang mode manajemen memori, alokasi stack vs heap, autofree, manajemen memori manual, prealloc, kode unsafe, dan tuning performa. Di bab berikutnya, kita akan menjelajahi tooling.
