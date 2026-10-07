# Kapitel 4: Ownership und Speicher

V verfolgt einen anderen Ansatz zur Speicherverwaltung als viele Sprachen. Statt manueller Speicherverwaltung oder alleiniger Garbage Collection bietet V mehrere Strategien.

## Stack und Heap

V entscheidet automatisch, ob auf dem Stack oder Heap allokiert wird:

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

## Garbage Collection

V verwendet standardmäßig einen Garbage Collector. Sie müssen Speicher nicht manuell freigeben:

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

## Autofree

V verfügt über einen Autofree-Modus, der Speicher automatisch freigibt, wenn Variablen ihren Gültigkeitsbereich verlassen:

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

## Referenzen

Sie können Referenzen verwenden, um das Kopieren großer Datenmengen zu vermeiden:

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

## Speicherverwaltungsmodi

| Modus | Flag | Beschreibung |
|------|------|-------------|
| GC (Standard) | `-gc boehm` | Boehm Garbage Collector |
| Autofree | `-autofree` | Automatische Speicherfreigabe |
| Keiner | `-gc none` | Manuelle Speicherverwaltung |
| Prealloc | `-prealloc` | Arena-Allokation |

## Zusammenfassung

In diesem Kapitel haben Sie die Speicherverwaltungsoptionen von V kennengelernt. Im nächsten Kapitel untersuchen wir Structs.
