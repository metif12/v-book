# プロジェクト構造

Vプロジェクトは`v.mod`ファイルを持つディレクトリです：

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

## プロジェクトの作成

```bash
v init
```

## 次へ

[v.mod](ch02-02-vmod.md)
