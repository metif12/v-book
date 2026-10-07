# Тип Option

```v
struct User {
    id   int
    name string
}

fn find_user(id int) ?User {
    if id == 0 {
        return none
    }
    return User{id: id, name: 'Alice'}
}

fn main() {
    user := find_user(0) or {
        println('User not found')
        return
    }
    println(user.name)
}
```

## Распаковка

```v
fn main() {
    x := ?int(42)
    y := x or { 0 }
    println(y)
}
```

## Далее

[Тип Result](ch09-02-result-type.md)
