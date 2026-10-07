# Tests avec v test

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

## Fonctions de test

Les fonctions de test commencent par `test_` et ne prennent aucun argument :

```v
fn test_something() {
    assert true
}
```

## Assertions

Utilisez `assert` pour vérifier des conditions :

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## Suivant

[Chapitre 3 : Concepts courants](ch03-common-concepts.md)
