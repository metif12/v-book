# پروجیکٹ کا ڈھانچہ

ایک V پروجیکٹ ایک ڈائریکٹری ہے جس میں ایک `v.mod` فائل ہوتی ہے:

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

## پروجیکٹ بنانا

```bash
v init
```

## اگلا

[v.mod](ch02-02-vmod.md)
