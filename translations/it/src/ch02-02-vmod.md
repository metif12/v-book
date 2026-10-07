# v.mod

Il file `v.mod` descrive il tuo progetto:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Campi

| Campo | Descrizione |
|-------|-------------|
| `name` | Nome del progetto (deve corrispondere al nome della directory) |
| `description` | Breve descrizione |
| `version` | Versione semantica |
| `license` | Identificativo della licenza |
| `dependencies` | Elenco dei nomi dei pacchetti VPM |

## Avanti

[Formattazione con v fmt](ch02-03-formatting.md)
