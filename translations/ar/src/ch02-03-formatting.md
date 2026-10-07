# التنسيق مع v fmt

V يحتوي على مُنسّق كود مدمج:

```bash
v fmt -w .
```

العلمة `-w` تكتب التغييرات مرة أخرى إلى الملفات. بدونها، يطبع المُنسّق إلى stdout.

## مثال

قبل:

```v
fn main(){
println( 'hello' )
}
```

بعد `v fmt`:

```v
fn main() {
    println('hello')
}
```

## التالي

[الاختبار مع v test](ch02-04-testing.md)
