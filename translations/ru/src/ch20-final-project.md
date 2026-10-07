# Глава 20: Финальный проект: веб-приложение

В этой главе мы создадим простое веб-приложение с Veb и ORM.

## Настройка проекта

```bash
mkdir myapp
cd myapp
v init
```

## База данных

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

## Маршруты

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

## Итоги

Поздравляем! Вы завершили книгу по языку программирования V. Теперь у вас есть прочный фундамент в V, и вы готовы создавать реальные приложения.
