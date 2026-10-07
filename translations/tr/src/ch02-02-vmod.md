# v.mod

`v.mod` dosyası projenizi tanımlar:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Alanlar

| Alan | Açıklama |
|-------|-------------|
| `name` | Proje adı (dizin adıyla eşleşmelidir) |
| `description` | Kısa açıklama |
| `version` | Semantik sürüm |
| `license` | Lisans tanımlayıcı |
| `dependencies` | VPM paket adlarının listesi |

## Sonraki

[v fmt ile Biçimlendirme](ch02-03-formatting.md)
