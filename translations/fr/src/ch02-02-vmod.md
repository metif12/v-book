# v.mod

Le fichier `v.mod` décrit votre projet :

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Champs

| Champ | Description |
|-------|-------------|
| `name` | Nom du projet (doit correspondre au nom du répertoire) |
| `description` | Brève description |
| `version` | Version sémantique |
| `license` | Identifiant de licence |
| `dependencies` | Liste des noms de paquets VPM |

## Suivant

[Formatage avec v fmt](ch02-03-formatting.md)
