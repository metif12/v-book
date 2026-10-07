# Capítulo 20: Projeto Final: Aplicação Web

Neste capítulo, vamos construir uma aplicação web simples com Veb e um ORM.

## Configuração do projeto

```bash
mkdir myapp
cd myapp
v init
```

## Banco de dados

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

## Rotas

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

## Resumo

Parabéns! Você completou O Livro da Linguagem de Programação V. Agora você tem uma base sólida em V e está pronto para construir aplicações do mundo real.
