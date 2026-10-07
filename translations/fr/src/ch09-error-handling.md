# Chapitre 9 : Gestion des erreurs

V utilise les types Option (`?T`) et Result (`!T`) pour la gestion des erreurs.

## Type Option

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

## Type Result

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

## Erreurs personnalisées

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

## Résumé

Dans ce chapitre, vous avez appris les types Option, Result et les erreurs personnalisées. Dans le chapitre suivant, nous explorerons les génériques.
