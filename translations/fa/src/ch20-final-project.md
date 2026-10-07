# فصل ۲۰: پروژه پایانی: برنامه وب

در این فصل، یک برنامه وب ساده با Veb و ORM می‌سازیم.

## راه‌اندازی پروژه

```bash
mkdir myapp
cd myapp
v init
```

## پایگاه داده

```v no_run
import veb
import db.sqlite

struct App {
    db sqlite.DB
}

struct User {
    id   int
    name string
    email string
}

fn main() {
    mut app := App{
        db: sqlite.connect('myapp.db') or { panic(err) }
    }
    sql app.db {
        create table User
    } or {}
    veb.run(mut app, 8080)
}
```

## مسیرها

```v no_run
import veb
import db.sqlite

struct App {
    db sqlite.DB
}

struct User {
    id   int
    name string
    email string
}

@['/']
fn (mut app App) index(mut ctx veb.Context) {
    ctx.text('Welcome!')
}

@['/users']
fn (mut app App) users(mut ctx veb.Context) {
    users := sql app.db {
        select from User
    } or { [] }
    ctx.json(users)
}
```

## خلاصه

آفرین! شما کتاب زبان برنامه‌نویسی V را تکمیل کرده‌اید. اکنون پایه محیطی در V دارید و آماده ساخت برنامه‌های واقعی هستید.
