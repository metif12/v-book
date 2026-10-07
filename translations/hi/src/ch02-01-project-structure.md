# प्रोजेक्ट संरचना

एक V प्रोजेक्ट एक डायरेक्टरी है जिसमें एक `v.mod` फ़ाइल होती है:

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

## प्रोजेक्ट बनाना

```bash
v init
```

## अगला

[v.mod](ch02-02-vmod.md)
