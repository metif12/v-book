# v.mod

`v.mod` 文件描述你的项目：

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## 字段

| 字段 | 描述 |
|-------|-------------|
| `name` | 项目名称（必须与目录名匹配） |
| `description` | 简短描述 |
| `version` | 语义化版本号 |
| `license` | 许可证标识符 |
| `dependencies` | VPM 包名列表 |

## 下一步

[使用 v fmt 格式化](ch02-03-formatting.md)
