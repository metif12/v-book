# Kapitel 2: Ein Projekt aufbauen

In diesem Kapitel lernen Sie, wie Sie ein V-Projekt strukturieren, `v.mod` verwenden, Code mit `v fmt` formatieren und Tests mit `v test` schreiben.

## Projektstruktur

Ein V-Projekt ist ein Verzeichnis mit einer `v.mod`-Datei und einer oder mehreren `.v`-Dateien:

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

Jedes V-Projekt hat eine `v.mod`-Datei, die das Projekt beschreibt:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

Erstellen Sie ein neues Projekt mit:

```bash
v init
```

Dies erstellt eine `v.mod` und eine `main.v` mit einer Grundvorlage.

## Formatierung mit v fmt

V verfügt über einen integrierten Code-Formatierer. Führen Sie ihn in Ihrem Projekt aus:

```bash
v fmt -w .
```

Das Flag `-w` schreibt den formatierten Code zurück in die Dateien.

## Testen mit v test

V verfügt über ein integriertes Testframework. Erstellen Sie eine Datei, die mit `_test.v` endet:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

Tests ausführen:

```bash
v test .
```

## Zusammenfassung

In diesem Kapitel haben Sie gelernt, wie Sie ein V-Projekt strukturieren, `v.mod` verwenden, Code formatieren und Tests schreiben. Im nächsten Kapitel tauchen wir in die häufigen Programmierkonzepte in V ein.
