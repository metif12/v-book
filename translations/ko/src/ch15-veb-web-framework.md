# Chapter 15: Veb Web Framework

Veb is V's built-in web framework. It provides routing, JSON handling, HTML templates, middleware, and static file serving — all with a minimal API surface.

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

The `App` struct holds your application state. Each route is a method on `App` annotated with `@['/path']`. The handler receives a `veb.Context` which provides methods for writing responses.

## Routing

Veb uses path parameters with the `:name` syntax. Path parameters are passed directly as function arguments to the handler.

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

Path parameters (`:id`) are extracted from the URL and passed as arguments. Query string parameters (`?q=...`) are accessed via `ctx.query` which is a `map[string]string`.

## JSON responses

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

`ctx.json()` serializes any V value to JSON and sets the `Content-Type` header to `application/json`.

## Templates

Veb supports HTML templates with the `$tmpl` function. Templates use V's string interpolation syntax.

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

The template file receives the data struct and can access its fields with `{{ field_name }}`.

## Middleware

Middleware wraps every request. Use `app.use()` to register global middleware, or `app.route_use()` for route-specific middleware.

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

Middleware returns `bool` — `true` to continue to the next handler, `false` to stop.

## Static files

Veb can serve static files from a directory using `app.handle_static()`.

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

Files in the `public/` directory are served at the root path. For example, `public/style.css` is accessible at `http://localhost:8080/style.css`.

## Summary

In this chapter, you learned about Veb — V's built-in web framework. You saw how to define routes with path and query parameters, return JSON responses, render HTML templates, add middleware for cross-cutting concerns, and serve static files. In the next chapter, we'll explore C interop.
