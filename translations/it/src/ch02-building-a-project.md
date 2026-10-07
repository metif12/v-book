# Capitolo 2: Costruire un Progetto

In questo capitolo, imparerai come strutturare un progetto V, usare `v.mod`, formattare il codice con `v fmt` e scrivere test con `v test`.

## Struttura del progetto

Un progetto V è una directory con un file `v.mod` e uno o più file `.v`:

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

Ogni progetto V ha un file `v.mod` che descrive il progetto:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

Crea un nuovo progetto con:

```bash
v init
```

Questo crea un `v.mod` e un `main.v` con un template di base.

## Formattazione con v fmt

V ha un formattatore di codice integrato. Eseguilo sul tuo progetto:

```bash
v fmt -w .
```

Il flag `-w` scrive il codice formattato nei file.

## Testing con v test

V ha un framework di testing integrato. Crea un file che termina con `_test.v`:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Esegui i test:

```bash
v test .
```

## Riassunto

In questo capitolo, hai imparato come strutturare un progetto V, usare `v.mod`, formattare il codice e scrivere test. Nel prossimo capitolo, approfondiremo i concetti di programmazione comuni in V.
