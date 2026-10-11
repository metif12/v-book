# 第20章：最終プロジェクト：Webアプリケーション

この章では、VebとORMを使用してシンプルなWebアプリケーションを構築します。

## プロジェクトのセットアップ

```bash
mkdir myapp
cd myapp
v init
```

## データベース

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

## ルート

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

## まとめ

おめでとうございます！*Vプログラミング言語ブック*を完了しました。Vのしっかりとした基礎を身につけ、実世界のアプリケーションを構築する準備ができました。
