# 附录 C：V 语法参考

## 函数

```v
fn function_name(param1 int, param2 string) int {
    return param1
}
```

## 结构体

```v
struct StructName {
    field1 int
    field2 string
pub:
    public_field int
}
```

## 枚举

```v
enum EnumName {
    value1
    value2
}
```

## 和类型

```v
struct Type1 {}
struct Type2 {}

type SumType = Type1 | Type2
```

## 接口

```v
interface InterfaceName {
    method_name() int
}
```

## 模块

```v ignore
module module_name

pub fn public_function() {
    // ...
}
```
