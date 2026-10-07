# v.mod

ملف `v.mod` يصف مشروعك:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## الحقول

| الحقل | الوصف |
|-------|-------------|
| `name` | اسم المشروع (يجب أن يطابق اسم المجلد) |
| `description` | وصف مختصر |
| `version` | رقم الإصدار الدلالي |
| `license` | مُعرّف الترخيص |
| `dependencies` | قائمة أسماء حزم VPM |

## التالي

[التنسيق مع v fmt](ch02-03-formatting.md)
