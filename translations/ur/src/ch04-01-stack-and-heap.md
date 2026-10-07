# اسٹیک اور ہیپ

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

## اسٹیک

- تیز الاکیٹر اور ڈی الاکیٹر
- کمپائل ٹائم پر مقررہ سائز
- اسکوپ ختم ہونے پر خودکار طور پر آزاد

## ہیپ

- متحرک سائز
- سست الاکیٹر
- GC یا آٹوفری کے ذریعے مینیج

## اگلا

[گاربيج کلکشن](ch04-02-garbage-collection.md)
