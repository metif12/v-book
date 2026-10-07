# باب ۴: ملکیت اور میموری

V میموری مینجمنٹ کے لیے بہت سی زبانوں سے مختلف نقطہ نظر رکھتا ہے۔ دستی میموری مینجمنٹ یا صرف گاربيج کلکشن کے بجائے، V کئی حکمت عملی پیش کرتا ہے۔

## اسٹیک اور ہیپ

V خودکار طور پر فیصلہ کرتا ہے کہ اسٹیک یا ہیپ پر الاکیٹ کرنا ہے:

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

## گاربيج کلکشن

V ڈیفالٹ طور پر گاربيج کلکٹر استعمال کرتا ہے۔ آپ کو میموری کو دستی طور پر آزاد کرنے کی ضرورت نہیں:

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

## آٹوفری

V میں ایک آٹوفری موڈ ہے جو متغیرات کے اسکوپ سے باہر جانے پر خودکار طور پر میموری آزاد کرتا ہے:

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

## حوالہ جات

بڑے ڈیٹا کی کاپی سے بچنے کے لیے حوالہ جات استعمال کر سکتے ہیں:

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

## میموری مینجمنٹ موڈز

| موڈ | فلگ | تفصیل |
|------|------|-------------|
| GC (ڈیفالٹ) | `-gc boehm` | Boehm گاربيج کلکٹر |
| آٹوفری | `-autofree` | خودکار میموری آزادی |
| کوئی نہیں | `-gc none` | دستی میموری مینجمنٹ |
| پری الاکیٹ | `-prealloc` | ایرینا الاکیٹر |

## خلاصہ

اس باب میں، آپ نے V کے میموری مینجمنٹ کے اختیارات کے بارے میں سیکھا۔ اگلے باب میں، ہم structs کو دریافت کریں گے۔
