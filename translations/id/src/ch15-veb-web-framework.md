# Bab 15: Web Framework Veb

Veb adalah web framework bawaan V. Ini menyediakan routing, penanganan JSON, template HTML, middleware, dan penyajian file statis — semuanya dengan API yang minimal.

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
Struct `App` menyimpan state aplikasi Anda. Setiap route adalah metode pada `App` yang dianotasi dengan `@['/path']`. Handler menerima `veb.Context` yang menyediakan metode untuk menulis respons.

## Routing

Veb menggunakan path parameter dengan sintaks `:name`. Path parameter diteruskan langsung sebagai argumen fungsi ke handler.

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
Path parameter (`:id`) diekstrak dari URL dan diteruskan sebagai argumen. Query string parameter (`?q=...`) diakses melalui `ctx.query` yang merupakan `map[string]string`.

## Respons JSON

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
`ctx.json()` menserialisasi nilai V apa pun ke JSON dan mengatur header `Content-Type` ke `application/json`.

## Template

Veb mendukung HTML template dengan fungsi `$tmpl`. Template menggunakan sintaks interpolasi string V.

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
File template menerima struct data dan dapat mengakses fieldnya dengan `{{ field_name }}`.

## Middleware

Middleware membungkus setiap request. Gunakan `app.use()` untuk mendaftarkan middleware global, atau `app.route_use()` untuk middleware spesifik route.

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
Middleware mengembalikan `bool` — `true` untuk melanjutkan ke handler berikutnya, `false` untuk berhenti.

## File statis

Veb dapat menyajikan file statis dari direktori menggunakan `app.handle_static()`.

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
File dalam direktori `public/` disajikan di root path. Misalnya, `public/style.css` dapat diakses di `http://localhost:8080/style.css`.

## Ringkasan

Dalam bab ini, Anda telah belajar tentang Veb — web framework bawaan V. Anda melihat cara mendefinisikan route dengan parameter path dan query, mengembalikan respons JSON, merender HTML template, menambahkan middleware untuk cross-cutting concerns, dan menyajikan file statis. Di bab berikutnya, kita akan menjelajahi C interop.
