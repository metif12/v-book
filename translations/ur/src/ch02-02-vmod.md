# v.mod

`v.mod` فائل آپ کے پروجیکٹ کی وضاحت کرتی ہے:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## فیلڈز

| فیلڈ | تفصیل |
|-------|-------------|
| `name` | پروجیکٹ کا نام (ڈائریکٹری کے نام سے مماثل ہونا چاہیے) |
| `description` | مختصر وضاحت |
| `version` | سیمنٹک ورژن |
| `license` | لائسنس کی شناخت |
| `dependencies` | VPM پیکج ناموں کی فہرست |

## اگلا

[v fmt کے ساتھ فارمیٹنگ](ch02-03-formatting.md)
