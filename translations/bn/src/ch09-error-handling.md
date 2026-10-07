# অধ্যায় 9: এরর হ্যান্ডলিং

V এরর হ্যান্ডলিংয়ের জন্য Option (`?T`) এবং Result (`!T`) টাইপ ব্যবহার করে।

## option টাইপ

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

## result টাইপ

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

## কাস্টম এরর

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

## সারসংক্ষেপ

এই অধ্যায়ে আপনি option, result এবং কাস্টম এরর সম্পর্কে শিখেছেন। পরবর্তী অধ্যায়ে আমরা জেনেরিক্স শিখব।
