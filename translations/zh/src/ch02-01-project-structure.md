# 项目结构

V 项目是一个包含 `v.mod` 文件的目录：

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

## 创建项目

```bash
v init
```

## 下一步

[v.mod](ch02-02-vmod.md)
