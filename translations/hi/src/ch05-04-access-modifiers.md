# एक्सेस मॉडिफायर

फ़ील्ड्स डिफ़ॉल्ट रूप से प्राइवेट होती हैं:

```v
struct User {
    name string
pub:
    age int
}

fn main() {
    u := User{name: 'Alice', age: 30}
    println(u.name)  // OK: same module
    println(u.age)   // OK: public
}
```

## विज़िबिलिटी

| मॉडिफायर | स्कोप |
|----------|-------|
| (none) | Module only |
| `pub` | Public |

## अगला

[अध्याय 6: Enums और Sum Types](ch06-enums-and-sum-types.md)
