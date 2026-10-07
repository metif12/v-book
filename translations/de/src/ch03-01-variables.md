# Variablen und Veränderbarkeit

In V sind Variablen standardmäßig unveränderlich:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Fehler: name is immutable

    mut count := 0
    count = 1  // OK: count is mutable
    count++
    println(count)
}
```

## Deklaration

Verwenden Sie `:=`, um zu deklarieren und zu initialisieren:

```v
x := 42
name := 'V'
is_ready := true
```

## Typinferenz

V leitet Typen aus dem Initialisierer ab:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## Explizite Typen

Sie können Typen explizit angeben:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## Weiter

[Datentypen](ch03-02-data-types.md)
