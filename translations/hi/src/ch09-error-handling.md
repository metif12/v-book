# अध्याय 9: एरर हैंडलिंग

V एरर हैंडलिंग के लिए Option (`?T`) और Result (`!T`) टाइप्स का उपयोग करता है।

## Option Type

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

## Result Type

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

## कस्टम एरर

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

## सारांश

इस अध्याय में, आपने Option, Result, और कस्टम एरर के बारे में सीखा। अगले अध्याय में, हम जेनरिक्स का पता लगाएंगे।
