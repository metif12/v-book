# विज़िबिलिटी

- `pub` — पब्लिक, अन्य मॉड्यूल से एक्सेस योग्य
- (कोई मॉडिफायर नहीं) — प्राइवेट, केवल मॉड्यूल

```v ignore
module math

fn private_helper() int {
    return 42
}

pub fn public_function() int {
    return private_helper()
}
```

## अगला

[VPM](ch07-03-vpm.md)
