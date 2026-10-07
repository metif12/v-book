# 使用 v fmt 格式化

V 有内置的代码格式化工具：

```bash
v fmt -w .
```

`-w` 参数将更改写回文件。不带此参数时，格式化工具会输出到标准输出。

## 示例

格式化前：

```v
fn main(){
println( 'hello' )
}
```

执行 `v fmt` 后：

```v
fn main() {
    println('hello')
}
```

## 下一步

[使用 v test 测试](ch02-04-testing.md)
