# Hallo, Welt!

Erstellen Sie eine Datei namens `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Führen Sie sie aus:

```bash
v run main.v
```

Ausgabe:

```
Hello, World!
```

## Aufbau eines V-Programms

Betrachten wir das Programm im Detail:

- `fn main()` — Jedes V-Programm beginnt mit einer `main`-Funktion. Das Schlüsselwort `fn` deklariert eine Funktion.
- `println(...)` — Eine eingebaute Funktion, die eine Zeile auf der Standardausgabe ausgibt.
- `'Hello, World!'` — Ein String-Literal. V verwendet einfache Anführungszeichen für Strings.

## Kompilieren vs. Ausführen

`v run` kompiliert und führt in einem Schritt aus. Sie können auch zuerst kompilieren:

```bash
v main.v
./main
```

## Weiter

[Hallo, V!](ch01-03-hello-v.md)
