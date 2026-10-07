# 使用 v test 测试

V 有内置的测试框架。创建一个以 `_test.v` 结尾的文件：

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

运行测试：

```bash
v test .
```

## 测试函数

测试函数以 `test_` 开头，不接收参数：

```v
fn test_something() {
    assert true
}
```

## 断言

使用 `assert` 检查条件：

```v
fn test_math() {
    assert 1 + 1 == 2
    assert 2 * 3 == 6
}
```

## 下一步

[第 3 章：基本概念](ch03-common-concepts.md)
