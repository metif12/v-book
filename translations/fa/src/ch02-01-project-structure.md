# ساختار پروژه

یک پروژه V یک دایرکتوری با یک فایل `v.mod` است:

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

## ایجاد یک پروژه

```bash
v init
```

## بعدی

[v.mod](ch02-02-vmod.md)
