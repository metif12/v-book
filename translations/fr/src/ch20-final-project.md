# Chapitre 20 : Projet final : Application web

Dans ce chapitre, nous allons créer une application web simple avec Veb et un ORM.

## Configuration du projet

```bash
mkdir myapp
cd myapp
v init
```

## Base de données

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

## Routes

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

## Résumé

Félicitations ! Vous avez terminé Le livre du langage de programmation V. Vous avez maintenant une base solide en V et êtes prêt à construire des applications réelles.
