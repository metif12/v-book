# Capítulo 20: Proyecto Final: Aplicación Web

En este capítulo, construiremos una aplicación web simple con Veb y un ORM.

## Configuración del proyecto

```bash
mkdir myapp
cd myapp
v init
```

## Base de datos

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

## Rutas

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

## Resumen

¡Felicidades! Has completado El Libro del Lenguaje de Programación V. Ahora tienes una base sólida en V y estás listo para construir aplicaciones del mundo real.
