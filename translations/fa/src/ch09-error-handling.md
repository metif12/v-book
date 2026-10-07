# فصل ۹: مدیریت خطا

V از انواع Option (`?T`) و Result (`!T`) برای مدیریت خطا استفاده می‌کند.

## نوع Option

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

## نوع Result

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

## خطاهای سفارشی

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

## خلاصه

در این فصل، درباره Option، Result و خطاهای سفارشی یاد گرفتید. در فصل بعد، به ژنریک‌ها می‌پردازیم.
