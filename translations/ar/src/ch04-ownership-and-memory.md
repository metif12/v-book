# الفصل 4: الملكية والذاكرة

يتبع V نهجاً مختلفاً في إدارة الذاكرة مقارنة بالعديد من اللغات. بدلاً من إدارة الذاكرة اليدوية أو جمع القمامة وحده، يقدم V استراتيجيات متعددة.

## المكدس والكومة

يقرر V تلقائياً ما إذا كان سيخصص في المكدس أو الكومة:

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

## جمع القمامة

يستخدم V جامع قمامة افتراضياً. لا تحتاج لتحرير الذاكرة يدوياً:

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

## التحرير التلقائي

لديه V وضع التحرير التلقائي الذي يحرر الذاكرة تلقائياً عندما تخرج المتغيرات من النطاق:

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

## المراجع

يمكنك استخدام المراجع لتجنب نسخ البيانات الكبيرة:

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

## أوضاع إدارة الذاكرة

| الوضع | العلمة | الوصف |
|------|------|-------------|
| GC (افتراضي) | `-gc boehm` | جامع قمامة Boehm |
| التحرير التلقائي | `-autofree` | تحرير تلقائي للذاكرة |
| بدون | `-gc none` | إدارة يدوية للذاكرة |
| التخصيص المسبق | `-prealloc` | تخصيص الساحة |

## الملخص

في هذا الفصل، تعلمت عن خيارات إدارة الذاكرة في V. في الفصل التالي، سنستكشف structs.
