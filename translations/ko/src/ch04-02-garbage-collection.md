# 가비지 컬렉션

V는 기본적으로 가비지 컬렉터를 사용합니다:

```v
fn main() {
    mut names := []string{}
    for i in 0 .. 100 {
        names << 'name ${i}'
    }
    // 더 이상 참조되지 않으면 메모리가 자동으로 해제됩니다
    println(names.len)
}
```

## GC 비활성화

성능이 중요한 코드에서는 GC를 비활성화할 수 있습니다:

```bash
v -gc none main.v
```

## 다음

[Autofree](ch04-03-autofree.md)
