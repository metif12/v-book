# v.mod

`v.mod` ফাইলটি আপনার প্রজেক্ট বর্ণনা করে:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## ফিল্ড

| ফিল্ড | বিবরণ |
|-------|-------------|
| `name` | প্রজেক্টের নাম (ডিরেক্টরির নামের সাথে মিলতে হবে) |
| `description` | সংক্ষিপ্ত বিবরণ |
| `version` | সিম্যান্টিক ভার্সন |
| `license` | লাইসেন্স শনাক্তকারী |
| `dependencies` | VPM প্যাকেজ নামের তালিকা |

## পরবর্তী

[v fmt দিয়ে ফরম্যাটিং](ch02-03-formatting.md)
