# Variabili e Mutabilità

In V, le variabili sono immutabili per impostazione predefinita:

```v
fn main() {
    name := 'V'
    // name = 'Go'  // Errore: name è immutabile

    mut count := 0
    count = 1  // OK: count è mutabile
    count++
    println(count)
}
```

## Dichiarazione

Usa `:=` per dichiarare e inizializzare:

```v
x := 42
name := 'V'
is_ready := true
```

## Inferenza di tipo

V deduce i tipi dall'inizializzatore:

```v
a := 42      // int
b := 3.14    // f64
c := 'hello' // string
d := true    // bool
```

## Tipi espliciti

Puoi specificare i tipi esplicitamente:

```v
a := i64(42)
b := f32(3.14)
c := u8(255)
```

## Avanti

[Tipi di Dato](ch03-02-data-types.md)
