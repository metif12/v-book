# v.mod

Die `v.mod`-Datei beschreibt Ihr Projekt:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Felder

| Feld | Beschreibung |
|-------|-------------|
| `name` | Projektname (muss mit dem Verzeichnisnamen übereinstimmen) |
| `description` | Kurze Beschreibung |
| `version` | Semantische Version |
| `license` | Lizenzkennung |
| `dependencies` | Liste der VPM-Paketnamen |

## Weiter

[Formatierung mit v fmt](ch02-03-formatting.md)
