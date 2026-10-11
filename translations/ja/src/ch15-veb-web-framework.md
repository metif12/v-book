# 第15章：Veb Webフレームワーク

VebはVの組み込みWebフレームワークです。ルーティング、JSON処理、HTMLテンプレート、ミドルウェア、静的ファイル提供を最小限のAPIで提供します。

## Hello, Veb!

```v no_run
import veb

// Context is the request state every handler receives. Declaring it lets the
// compiler infer the app's context type in veb.run.
struct Context {
	veb.Context
}

struct App {}

@['/']
fn (mut app App) index(mut ctx Context) {
	ctx.text('Hello, Veb!')
}

fn main() {
	mut app := &App{}
	veb.run[App, Context](mut app, 8080)
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

```v ignore
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
<h1>@page.title</h1>
<p>@page.body</p>
```
テンプレートファイルはデータstructを受け取り、`{{ field_name }}`でフィールドにアクセスできます。

## ミドルウェア

ミドルウェアはすべてのリクエストをラップします。`app.use()`でグローバルミドルウェアを登録するか、`app.route_use()`でルート固有のミドルウェアを登録します。

```v no_run
import veb

struct Context {
	veb.Context
}

// A middleware handler is a plain function: it takes the context, returns a
// bool, and keeps its state in the context or in its own module state.
fn log_request(mut ctx Context) bool {
	println('${ctx.req.method} ${ctx.req.url}')
	return true
}

struct App {
	veb.Middleware[Context]
}

@['/']
fn (mut app App) index(mut ctx Context) {
	ctx.text('Hello, Veb!')
}

fn main() {
	mut app := &App{}
	app.use(veb.MiddlewareOptions[Context]{
		handler: log_request
	})
	veb.run[App, Context](mut app, 18080)
}
```
ミドルウェアは`bool`を返します。`true`で次のハンドラに続行、`false`で停止します。

## 静的ファイル

Vebは`app.handle_static()`でディレクトリから静的ファイルを提供できます。

```v no_run
import veb

struct Context {
	veb.Context
}

struct App {
	veb.StaticHandler
}

@['/']
fn (mut app App) index(mut ctx Context) {
	ctx.text('Static file server')
}

fn main() {
	mut app := &App{}
	app.mount_static_folder_at('public', '/assets') or {
		eprintln('cannot serve assets: ${err}')
		return
	}
	veb.run[App, Context](mut app, 18080)
}
```
`public/`ディレクトリのファイルはルートパスで提供されます。例えば、`public/style.css`は`http://localhost:8080/style.css`でアクセスできます。

## まとめ

この章では、Vの組み込みWebフレームワークであるVebについて学びました。パスパラメータとクエリパラメータによるルート定義、JSONレスポンスの返却、HTMLテンプレートのレンダリング、横断的関心事のためのミドルウェア追加、静的ファイルの提供を見てきました。次の章では、C相互運用を見ていきます。
