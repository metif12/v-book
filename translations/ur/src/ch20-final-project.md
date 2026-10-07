# باب ۲۰: حتمی پروجیکٹ: ویب ایپلیکیشن

اس باب میں، ہم Veb اور ORM کے ساتھ ایک سادہ ویب ایپلیکیشن بنائیں گے۔

## پروجیکٹ سیٹ اپ

```bash
mkdir myapp
cd myapp
v init
```

## ڈیٹا بیس

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

## روٹس

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

## خلاصہ

مبارک ہو! آپ نے V پروگرامنگ زبان کی کتاب مکمل کر لی ہے۔ آپ کو V کی مضبوط بنیاد حاصل ہو گئی ہے اور آپ حقیقی دنیا کی ایپلیکیشنز بنانے کے لیے تیار ہیں۔
