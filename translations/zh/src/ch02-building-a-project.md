# 第 2 章：构建项目

在本章中，你将学习如何组织 V 项目、使用 `v.mod`、用 `v fmt` 格式化代码以及用 `v test` 编写测试。

## 项目结构

V 项目是一个包含 `v.mod` 文件和一个或多个 `.v` 文件的目录：

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

每个 V 项目都有一个 `v.mod` 文件来描述项目：

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

使用以下命令创建新项目：

```bash
v init
```

这会创建一个 `v.mod` 和一个包含基本模板的 `main.v`。

## 使用 v fmt 格式化

V 有内置的代码格式化工具。在项目上运行：

```bash
v fmt -w .
```

`-w` 参数将格式化后的代码写回文件。

## 使用 v test 测试

V 有内置的测试框架。创建一个以 `_test.v` 结尾的文件：

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

运行测试：

```bash
v test .
```

## 小结

在本章中，你学习了如何组织 V 项目、使用 `v.mod`、格式化代码和编写测试。在下一章中，我们将深入探讨 V 中的通用编程概念。
