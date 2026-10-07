# Chapter 9: 에러 처리

V는 에러 처리에 Option(`?T`)과 Result(`!T`) 타입을 사용합니다.

## Option 타입

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

## Result 타입

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

## 커스텀 에러

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

## 요약

이 장에서는 Option, Result, 커스텀 에러에 대해 배웠습니다. 다음 장에서는 제네릭을 살펴보겠습니다.
