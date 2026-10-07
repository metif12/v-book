# Ciao, Mondo!

Crea un file chiamato `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Eseguilo:

```bash
v run main.v
```

Output:

```
Hello, World!
```

## Anatomia di un programma V

Analizziamo il programma:

- `fn main()` — Ogni programma V inizia con una funzione `main`. La parola chiave `fn` dichiara una funzione.
- `println(...)` — Una funzione built-in che stampa una riga su stdout.
- `'Hello, World!'` — Un letterale stringa. V usa gli apici singoli per le stringhe.

## Compilare vs eseguire

`v run` compila ed esegue in un unico passaggio. Puoi anche compilare prima:

```bash
v main.v
./main
```

## Avanti

[Ciao, V!](ch01-03-hello-v.md)
