# 第 20 章：最终项目：Web 应用

在本章中，我们将使用 Veb 和 ORM 构建一个简单的 Web 应用。

## 项目设置

```bash
mkdir myapp
cd myapp
v init
```

## 数据库

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

## 路由

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

## 小结

恭喜！你已完成 V 编程语言指南的学习。你现在对 V 有了扎实的基础，可以构建实际应用了。
