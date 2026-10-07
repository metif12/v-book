# Capitolo 20: Progetto Finale: Applicazione Web

In questo capitolo, costruiremo una semplice applicazione web con Veb e un ORM.

## Configurazione del progetto

```bash
mkdir myapp
cd myapp
v init
```

## Database

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

## Route

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

## Riassunto

Congratulazioni! Hai completato Il Libro del Linguaggio di Programmazione V. Ora hai una solida base in V e sei pronto per costruire applicazioni reali.
