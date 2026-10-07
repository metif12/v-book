# باب ۱۸: میموری مینجمنٹ گہرا جائزہ

## GC موڈز

V متعدد میموری مینجمنٹ حکمت عملی فراہم کرتا ہے، ہر ایک مختلف استعمال کے معاملات کے لیے موزوں۔

| موڈ | فلگ | استعمال |
|------|------|----------|
| Boehm GC | `-gc boehm` | عام مقصد |
| آٹوفری | `-autofree` | خودکار آزادی |
| کوئی نہیں | `-gc none` | دستی مینجمنٹ |
| پری الاکیٹ | `-prealloc` | ایرینا الاکیٹر |

## اسٹیک بمقابلہ ہیپ

V خودکار طور پر فیصلہ کرتا ہے کہ میموری کو کہاں الاکیٹ کرنا ہے۔ چھوٹی، مختصر مدتی قدریں اسٹیک پر رہتی ہیں۔ بڑی یا باہر نکلنے والی قدریں ہیپ پر جاتی ہیں۔

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

## آٹوفری موڈ

آٹوفری متغیرات کے اسکوپ سے باہر جانے پر خودکار طور پر میموری آزاد کرتا ہے۔ یہ ہیپ الاکیشنز کے لیے حوالہ گنتی استعمال کرتا ہے۔

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

## -gc none اور دستی میموری

`-gc none` کے ساتھ، V گاربيج کلکشن کو غیر فعال کرتا ہے۔ آپ کو `free` استعمال کر کے میموری کو دستی طور پر مینیج کرنا ہوگا۔

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

## -prealloc ایرینا الاکیٹر

پری الاکیٹ بہتر پرفارمنس کۆڑ لوپس میں بہتر پرفارمنس کے لیے ایرینا الاکیٹر استعمال کرتا ہے۔ الاکیشنز بڑے پیمانے پر آزاد ہوتے ہیں۔

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

## غیر محفوظ کوڈ

`unsafe` بلاک ایسے عملوں کی اجازت دیتا ہے جو V کی تحفظ کی ضمانتوں کو نظر انداز کرتے ہیں، جیسے کہ پوئنٹر حساب اور براہ راست میموری رسائی۔

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

### پوئنٹر حساب

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

## پرفارمنس کی بہتری

صحیح میموری مینجمنٹ موڈ کا انتخاب پرفارمنس کو نمایاں طور پر متاثر کر سکتا ہے۔

### مختلف موڈز کی بینچ مارکنگ

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

### ڈیٹا کی ساخت کی بہتری

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

## خلاصہ

اس باب میں، آپ نے میموری مینجمنٹ موڈز، اسٹیک بمقابلہ ہیپ الاکیشن، آٹوفری، دستی میموری مینجمنٹ، پری الاکیٹ، غیر محفوظ کوڈ، اور پرفارمنس کی بہتری کے بارے میں سیکھا۔ اگلے باب میں، ہم ٹولنگ کو دریافت کریں گے۔
