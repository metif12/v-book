# Chapitre 12 : Projet E/S : Créer un outil CLI

Dans ce chapitre, nous allons créer un outil en ligne de commande simple qui lit un fichier et compte ses lignes, mots et caractères.

## Configuration du projet

```bash
mkdir wordcount
cd wordcount
v init
```

## Implémentation

```v no_run
import os

fn count(text string) (int, int, int) {
    lines := text.split('\n').len
    words := text.split(' ').len
    chars := text.len
    return lines, words, chars
}

fn main() {
    if os.args.len < 2 {
        println('Usage: wordcount <file>')
        exit(1)
    }

    path := os.args[1]
    content := os.read_file(path) or {
        println('Failed to read file: ${path}')
        exit(1)
    }

    lines, words, chars := count(content)
    println('Lines: ${lines}')
    println('Words: ${words}')
    println('Chars: ${chars}')
}
```

## Exécution

```bash
v run . main.v
```

## Résumé

Dans ce chapitre, vous avez créé un outil en ligne de commande. Dans le chapitre suivant, nous explorerons les fonctionnalités fonctionnelles.
