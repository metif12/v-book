# Kapitel 20: Abschlussprojekt: Webanwendung

In diesem Kapitel bauen wir eine einfache Webanwendung mit Veb und einem ORM.

## Projekt-Setup

```bash
mkdir myapp
cd myapp
v init
```

## Datenbank

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

## Routen

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

## Zusammenfassung

Herzlichen Glückwunsch! Sie haben Das V-Programmierhandbuch abgeschlossen. Sie verfügen nun über eine solide Grundlage in V und sind bereit, echte Anwendungen zu entwickeln.
