# Bab 15: Web Framework Veb

Veb adalah web framework bawaan V. Ini menyediakan routing, penanganan JSON, template HTML, middleware, dan penyajian file statis — semuanya dengan API yang minimal.

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

File template menerima struct data dan dapat mengakses fieldnya dengan `{{ field_name }}`.

## Middleware

Middleware membungkus setiap request. Gunakan `app.use()` untuk mendaftarkan middleware global, atau `app.route_use()` untuk middleware spesifik route.

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

Middleware mengembalikan `bool` — `true` untuk melanjutkan ke handler berikutnya, `false` untuk berhenti.

## File statis

Veb dapat menyajikan file statis dari direktori menggunakan `app.handle_static()`.

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

File dalam direktori `public/` disajikan di root path. Misalnya, `public/style.css` dapat diakses di `http://localhost:8080/style.css`.

## Ringkasan

Dalam bab ini, Anda telah belajar tentang Veb — web framework bawaan V. Anda melihat cara mendefinisikan route dengan parameter path dan query, mengembalikan respons JSON, merender HTML template, menambahkan middleware untuk cross-cutting concerns, dan menyajikan file statis. Di bab berikutnya, kita akan menjelajahi C interop.
