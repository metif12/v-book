# Project Structure

A V project is a directory with a `v.mod` file:

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

## Creating a project

```bash
v init
```

## Next

[v.mod](ch02-02-vmod.md)
