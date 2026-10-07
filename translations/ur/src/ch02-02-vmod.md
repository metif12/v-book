# v.mod

The `v.mod` file describes your project:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Fields

| Field | Description |
|-------|-------------|
| `name` | Project name (must match directory name) |
| `description` | Short description |
| `version` | Semantic version |
| `license` | License identifier |
| `dependencies` | List of VPM package names |

## Next

[Formatting with v fmt](ch02-03-formatting.md)
