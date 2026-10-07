# অধ্যায় 20: ফাইনাল প্রজেক্ট: ওয়েব অ্যাপ্লিকেশন

এই অধ্যায়ে আমরা Veb এবং ORM দিয়ে একটি সরল ওয়েব অ্যাপ্লিকেশন তৈরি করব।

## প্রজেক্ট সেটআপ

```bash
mkdir myapp
cd myapp
v init
```

## ডেটাবেস

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

## রাউট

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

## সারসংক্ষেপ

অভিনন্দন! আপনি V প্রোগ্রামিং ল্যাঙ্গুয়েজ বই সম্পন্ন করেছেন। এখন আপনার V-এর একটি মজবুত ভিত্তি আছে এবং বাস্তব-বিশ্বের অ্যাপ্লিকেশন তৈরির জন্য প্রস্তুত।
