# v.mod

`v.mod` फ़ाइल आपके प्रोजेक्ट का वर्णन करती है:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## फ़ील्ड्स

| फ़ील्ड | विवरण |
|-------|-------------|
| `name` | प्रोजेक्ट का नाम (डायरेक्टरी के नाम से मेल खाना चाहिए) |
| `description` | संक्षिप्त विवरण |
| `version` | सिमेंटिक वर्ज़न |
| `license` | लाइसेंस पहचानकर्ता |
| `dependencies` | VPM पैकेज नामों की सूची |

## अगला

[v fmt के साथ फॉर्मेटिंग](ch02-03-formatting.md)
