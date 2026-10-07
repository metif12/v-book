# Chapter 20: 최종 프로젝트: 웹 애플리케이션

이 장에서는 Veb와 ORM으로 간단한 웹 애플리케이션을 만들어보겠습니다.

## 프로젝트 설정

```bash
mkdir myapp
cd myapp
v init
```

## 데이터베이스

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

## 라우트

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

## 요약

축하합니다! V 프로그래밍 언어 북을 완료했습니다. 이제 V에 대한 탄탄한 기초를 갖추었고 실제 애플리케이션을 구축할 준비가 되었습니다.
