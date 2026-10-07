# Bölüm 9: Hata Yönetimi

V, hata yönetimi için Option (`?T`) ve Result (`!T`) tiplerini kullanır.

## Option Tipi

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

## Result Tipi

```v
fn parse_number(s string) !int {
    return s.int()
}

fn main() {
    n := parse_number('42') or {
        println('Failed to parse')
        return
    }
    println(n)
}
```

## Özel Hatalar

```v
struct MyError {
    msg string
}

fn (e MyError) msg() string {
    return e.msg
}

fn fail() !int {
    return error(MyError{msg: 'something went wrong'}.msg())
}

fn main() {
    result := fail() or {
        println(err.msg())
        return
    }
    println(result)
}
```

## Özet

Bu bölümde Option, Result ve özel hatalar hakkında bilgi edindiniz. Sonraki bölümde generics'i inceleyeceğiz.
