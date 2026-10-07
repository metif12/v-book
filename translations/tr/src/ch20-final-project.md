# Bölüm 20: Final Projesi: Web Uygulaması

Bu bölümde Veb ve ORM ile basit bir web uygulaması oluşturacağız.

## Proje kurulumu

```bash
mkdir myapp
cd myapp
v init
```

## Veritabanı

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

## Rotalar

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

## Özet

Tebrikler! V Programlama Dili Kitabını tamamladınız. Artık V'de sağlam bir temele sahipsiniz ve gerçek dünya uygulamaları oluşturmaya hazırsınız.
