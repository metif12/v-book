# Bab 20: Proyek Akhir: Aplikasi Web

Dalam bab ini, kita akan membangun aplikasi web sederhana dengan Veb dan ORM.

## Penyiapan proyek

```bash
mkdir myapp
cd myapp
v init
```

## Database

```v no_run
import veb
import db.sqlite

struct Context {
	veb.Context
}

struct App {
	db sqlite.DB
}

struct User {
	id    int
	name  string
	email string
}

fn main() {
	mut app := &App{
		db: sqlite.connect('myapp.db') or { panic(err) }
	}
	sql app.db {
		create table User
	} or {}
	veb.run[App, Context](mut app, 8080)
}
```

## Route

```v no_run
import veb
import db.sqlite

struct Context {
	veb.Context
}

struct App {
	db sqlite.DB
}

struct User {
	id    int
	name  string
	email string
}

@['/']
fn (mut app App) index(mut ctx Context) {
	ctx.text('Welcome!')
}

@['/users']
fn (mut app App) users(mut ctx Context) {
    users := sql app.db {
        select from User
    } or { [] }
    ctx.json(users)
}
```

## Ringkasan

Selamat! Anda telah menyelesaikan Buku Bahasa Pemrograman V. Anda sekarang memiliki fondasi yang kuat dalam V dan siap membangun aplikasi dunia nyata.
