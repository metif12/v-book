# v.mod

`v.mod`ファイルはプロジェクトを記述します：

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## フィールド

| フィールド | 説明 |
|-------|-------------|
| `name` | プロジェクト名（ディレクトリ名と一致する必要があります） |
| `description` | 短い説明 |
| `version` | セマンティックバージョン |
| `license` | ライセンス識別子 |
| `dependencies` | VPMパッケージ名のリスト |

## 次へ

[v fmtによるフォーマット](ch02-03-formatting.md)
