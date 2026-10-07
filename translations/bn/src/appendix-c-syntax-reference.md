# অতিরিক্ত C: V সিনট্যাক্স রেফারেন্স

## ফাংশন

```v
fn function_name(param1 int, param2 string) int {
    return param1
}
```

## struct

```v
struct StructName {
    field1 int
    field2 string
pub:
    public_field int
}
```

## enum

```v
enum EnumName {
    value1
    value2
}
```

## sum type

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## ইন্টারফেস

```v
interface InterfaceName {
    method_name() int
}
```

## মডিউল

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
