# 第15章：Veb Webフレームワーク

VebはVの組み込みWebフレームワークです。ルーティング、JSON処理、HTMLテンプレート、ミドルウェア、静的ファイル提供を最小限のAPIで提供します。

## Hello, Veb!

```v no_run
import veb

struct App {}

@['/']
fn (mut app App) index(mut ctx veb.Context) {
    ctx.text('Hello, Veb!')
}

fn main() {
    veb.run(mut App{}, 8080)
}
```

`App` structはアプリケーションの状態を保持します。各ルートは`@['/path']`でアノテートされた`App`のメソッドです。ハンドラは`veb.Context`を受け取り、レスポンスを書き込むためのメソッドを提供します。

## ルーティング

Vebは`:name`構文でパスパラメータを使用します。パスパラメータはハンドラの関数引数として直接渡されます。

```v
import veb

struct App {}

@['/users/:id']
fn (mut app App) user(mut ctx veb.Context, id string) {
    ctx.text('User ${id}')
}

@['/search']
fn (mut app App) search(mut ctx veb.Context) {
    query := ctx.query['q']
    ctx.text('Searching for: ${query}')
}
```

パスパラメータ（`:id`）はURLから抽出されて引数として渡されます。クエリ文字列パラメータ（`?q=...`）は`ctx.query`（`map[string]string`）を介してアクセスされます。

## JSONレスポンス

```v
import veb

struct App {}

struct User {
    id   int
    name string
}

@['/api/users']
fn (mut app App) users(mut ctx veb.Context) {
    users := [
        User{id: 1, name: 'Alice'},
        User{id: 2, name: 'Bob'},
    ]
    ctx.json(users)
}
```

`ctx.json()`は任意のVの値をJSONにシリアライズし、`Content-Type`ヘッダーを`application/json`に設定します。

## テンプレート

Vebは`$tmpl`関数でHTMLテンプレートをサポートします。テンプレートはVの文字列補間構文を使用します。

```v no_run
import veb

struct App {}

struct Page {
    title string
    body  string
}

@['/page']
fn (mut app App) page(mut ctx veb.Context) {
    page := Page{
        title: 'My Page'
        body:  'Welcome to Veb templates!'
    }
    ctx.html($tmpl('templates/page.html', page))
}
```

```v ignore
<!DOCTYPE html>
<html>
<head><title>{{ page.title }}</title></head>
<body>{{ page.body }}</body>
</html>
```

テンプレートファイルはデータstructを受け取り、`{{ field_name }}`でフィールドにアクセスできます。

## ミドルウェア

ミドルウェアはすべてのリクエストをラップします。`app.use()`でグローバルミドルウェアを登録するか、`app.route_use()`でルート固有のミドルウェアを登録します。

```v no_run
import veb
import time

struct App {
    mut:
    request_count int
}

fn (mut app App) logger(mut ctx veb.Context) bool {
    start := time.now()
    app.request_count++
    println('Request #${app.request_count}: ${ctx.req.method} ${ctx.req.url}')
    return true
}

@['/']
fn (mut app App) index(mut ctx veb.Context) {
    ctx.text('Hello, Veb!')
}

fn main() {
    mut app := &App{}
    app.use(veb.Middleware[veb.Context]{
        handler: app.logger
    })
    veb.run(mut app, 8080)
}
```

ミドルウェアは`bool`を返します。`true`で次のハンドラに続行、`false`で停止します。

## 静的ファイル

Vebは`app.handle_static()`でディレクトリから静的ファイルを提供できます。

```v no_run
import veb

struct App {}

@['/']
fn (mut app App) index(mut ctx veb.Context) {
    ctx.text('Static file server')
}

fn main() {
    mut app := &App{}
    app.handle_static('public', true) or {
        eprintln('Failed to serve static files: ${err}')
        return
    }
    veb.run(mut app, 8080)
}
```

`public/`ディレクトリのファイルはルートパスで提供されます。例えば、`public/style.css`は`http://localhost:8080/style.css`でアクセスできます。

## まとめ

この章では、Vの組み込みWebフレームワークであるVebについて学びました。パスパラメータとクエリパラメータによるルート定義、JSONレスポンスの返却、HTMLテンプレートのレンダリング、横断的関心事のためのミドルウェア追加、静的ファイルの提供を見てきました。次の章では、C相互運用を見ていきます。
