# Bonjour, le Monde !

Créez un fichier appelé `main.v` :

```v
fn main() {
    println('Hello, World!')
}
```

Exécutez-le :

```bash
v run main.v
```

Sortie :

```
Hello, World!
```

## Anatomie d'un programme V

Décomposons le programme :

- `fn main()` — Chaque programme V commence par une fonction `main`. Le mot-clé `fn` déclare une fonction.
- `println(...)` — Une fonction intégrée qui affiche une ligne sur la sortie standard.
- `'Hello, World!'` — Une chaîne de caractères littérale. V utilise des guillemets simples pour les chaînes.

## Compiler vs exécuter

`v run` compile et exécute en une seule étape. Vous pouvez aussi compiler d'abord :

```bash
v main.v
./main
```

## Suivant

[Bonjour, V !](ch01-03-hello-v.md)
