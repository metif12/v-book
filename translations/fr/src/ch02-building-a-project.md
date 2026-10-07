# Chapitre 2 : Créer un projet

Dans ce chapitre, vous apprendrez à structurer un projet V, à utiliser `v.mod`, à formater du code avec `v fmt` et à écrire des tests avec `v test`.

## Structure du projet

Un projet V est un répertoire avec un fichier `v.mod` et un ou plusieurs fichiers `.v` :

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

Chaque projet V possède un fichier `v.mod` qui décrit le projet :

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

Créez un nouveau projet avec :

```bash
v init
```

Cela crée un fichier `v.mod` et un fichier `main.v` avec un modèle de base.

## Formatage avec v fmt

V dispose d'un formateur de code intégré. Exécutez-le sur votre projet :

```bash
v fmt -w .
```

L'option `-w` écrit le code formaté dans les fichiers.

## Tests avec v test

V dispose d'un framework de test intégré. Créez un fichier se terminant par `_test.v` :

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Exécutez les tests :

```bash
v test .
```

## Résumé

Dans ce chapitre, vous avez appris à structurer un projet V, à utiliser `v.mod`, à formater du code et à écrire des tests. Dans le chapitre suivant, nous explorerons les concepts de programmation courants dans V.
