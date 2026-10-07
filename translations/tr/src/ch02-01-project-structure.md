# Proje Yapısı

Bir V projesi, bir `v.mod` dosyası içeren bir dizindir:

```
my_project/
├── v.mod
├── main.v
├── my_module.v
└── my_module_test.v
```

## v.mod

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## Proje oluşturma

```bash
v init
```

## Sonraki

[v.mod](ch02-02-vmod.md)
