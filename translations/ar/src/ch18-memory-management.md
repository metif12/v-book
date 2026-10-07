# الفصل 18: إدارة الذاكرة بالتفصيل

## أوضاع GC

V يوفر عدة استراتيجيات لإدارة الذاكرة، كل منها مناسب لحالات استخدام مختلفة.

| الوضع | العلمة | حالة الاستخدام |
|------|------|----------|
| Boehm GC | `-gc boehm` | للأغراض العامة |
| Autofree | `-autofree` | تحرير تلقائي |
| None | `-gc none` | إدارة يدوية |
| Prealloc | `-prealloc` | تخصيص الساحة |

## المكدس مقابل الكومة

يقرر V تلقائياً أين يخصص الذاكرة. القيم الصغيرة قصيرة الأمد تبقى في المكدس. القيم الأكبر أو الهاربة تذهب إلى الكومة.

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

## وضع Autofree

Autofree يحرر الذاكرة تلقائياً عندما تخرج المتغيرات من النطاق. يستخدم عد المراجع لتخصيصات الكومة.

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

## -gc none والذاكرة اليدوية

مع `-gc none`، يعطل V جمع القمامة. يجب عليك إدارة الذاكرة يدوياً باستخدام `free`.

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

## تخصيص الساحة -prealloc

Prealloc يستخدم تخصيص الساحة لأداء أفضل في الحلقات المحكمة. التخصيصات تُحرَّر دفعة واحدة.

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

## الكود غير الآمن

كتلة `unsafe` تسمح بعمليات تتجاوز ضمانات الأمان في V، مثل حساب المؤشرات والوصول المباشر للذاكرة.

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

### حساب المؤشرات

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

## ضبط الأداء

اختيار وضع إدارة الذاكرة المناسب يمكن أن يؤثر بشكل كبير على الأداء.

### قياس أداء الأوضاع المختلفة

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

### تحسين هياكل البيانات

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

## الملخص

في هذا الفصل، تعلمت عن أوضاع إدارة الذاكرة، التخصيص في المكدس مقابل الكومة، autofree، إدارة الذاكرة اليدوية، prealloc، الكود غير الآمن، وضبط الأداء. في الفصل التالي، سنستكشف الأدوات.
