# الفصل 20: المشروع النهائي: تطبيق ويب

في هذا الفصل، سنبني تطبيق ويب بسيط مع Veb و ORM.

## إعداد المشروع

```bash
mkdir myapp
cd myapp
v init
```

## قاعدة البيانات

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

## المسارات

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

## الملخص

تهانينا! لقد أكملت كتاب لغة البرمجة V. لديك الآن أساس متين في V وأنت مستعد لبناء تطبيقات واقعية.
