# প্রজেক্ট স্ট্রাকচার

একটি V প্রজেক্ট হল একটি ডিরেক্টরি যাতে একটি `v.mod` ফাইল থাকে:

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

## প্রজেক্ট তৈরি

```bash
v init
```

## পরবর্তী

[v.mod](ch02-02-vmod.md)
