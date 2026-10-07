# المكدس والكومة

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

## المكدس

- تخصيص وتحرير سريع
- حجم ثابت عند وقت التصريف
- يُحرَّر تلقائياً عند انتهاء النطاق

## الكومة

- حجم ديناميكي
- تخصيص أبطأ
- يُدار بواسطة GC أو التحرير التلقائي

## التالي

[جمع القمامة](ch04-02-garbage-collection.md)
