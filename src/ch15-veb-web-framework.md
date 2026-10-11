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

Veb renders HTML with V's own templates. The `$tmpl` function loads a template file and fills it with the fields of a struct, and the template syntax is V string interpolation:

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

The template file receives the data struct and reads its fields with `@` followed by the field name. A page that needs no template file can write its HTML inline:

```v no_run
import veb

struct Context {
	veb.Context
}

struct App {}

@['/hello']
fn (mut app App) hello(mut ctx Context) veb.Result {
	return ctx.html('<h1>Hello, Veb!</h1><p>Rendered without a template file.</p>')
}

fn main() {
	mut app := &App{}
	veb.run[App, Context](mut app, 18080)
}
```

> **Note**
> Web examples are compiled but not run, because a server would block. The `$tmpl` call above is compile-time, so that example is not run either.

## Middleware

Middleware wraps every request. A handler returns `bool`: `true` continues to the next handler and eventually to the route, `false` stops the chain. Register it with `use`, or with `route_use` for a single route.

```v no_run
import veb
import time

struct Context {
	veb.Context
}

struct App {
	veb.Middleware[Context]
mut:
	request_count int
}

fn (mut app App) logger(mut ctx Context) bool {
	app.request_count++
	println('Request #${app.request_count}: ${ctx.req.method} ${ctx.req.url}')
	return true
}

@['/']
fn (mut app App) index(mut ctx Context) {
	ctx.text('Hello, Veb!')
}

fn main() {
	mut app := &App{}
	app.use(veb.MiddlewareOptions[Context]{
		handler: app.logger
	})
	veb.run(mut app, 18080)
}
```

`MiddlewareOptions` also takes `after: true` to run the handler after the route, and a `methods` list to limit which HTTP methods it applies to.

## Static files

Veb serves a directory of static files when the app embeds `veb.StaticHandler` and mounts the directory:

```v no_run
import veb

struct App {
	veb.StaticHandler
}

@['/']
fn (mut app App) index(mut ctx veb.Context) {
	ctx.text('Static file server')
}

fn main() {
	mut app := &App{}
	app.mount_static_folder_at('public', '/assets') or {
		eprintln('cannot serve assets: ${err}')
		return
	}
	veb.run(mut app, 18080)
}
```

Files under `public/` are served under the mount path, so `public/style.css` is reachable at `http://localhost:18080/assets/style.css`. The `ctx.html()` handler above is what serves them, which is why an app that mounts a directory normally has an index route too.

## Summary

In this chapter, you learned about Veb — V's built-in web framework. You saw how to define routes with path and query parameters, return JSON responses, render HTML templates, add middleware for cross-cutting concerns, and serve static files. In the next chapter, we'll explore C interop.
