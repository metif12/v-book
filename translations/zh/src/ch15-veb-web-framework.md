# 第 15 章：Veb Web 框架

Veb 是 V 内置的 Web 框架。它提供路由、JSON 处理、HTML 模板、中间件和静态文件服务——所有功能都具有极简的 API。

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

`App` 结构体保存你的应用状态。每个路由是 `App` 上使用 `@['/path']` 注解的方法。处理函数接收 `veb.Context`，它提供写入响应的方法。

## 路由

Veb 使用 `:name` 语法的路径参数。路径参数直接作为函数参数传递给处理函数。

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

路径参数（`:id`）从 URL 中提取并作为参数传递。查询字符串参数（`?q=...`）通过 `ctx.query` 访问，它是一个 `map[string]string`。

## JSON 响应

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

`ctx.json()` 将任何 V 值序列化为 JSON 并设置 `Content-Type` 头为 `application/json`。

## 模板

Veb 支持使用 `$tmpl` 函数的 HTML 模板。模板使用 V 的字符串插值语法。

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

模板文件接收数据结构体，可以使用 `{{ field_name }}` 访问其字段。

## 中间件

中间件包装每个请求。使用 `app.use()` 注册全局中间件，或使用 `app.route_use()` 注册路由特定的中间件。

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

中间件返回 `bool` — `true` 继续到下一个处理函数，`false` 停止。

## 静态文件

Veb 可以使用 `app.handle_static()` 从目录提供静态文件。

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

`public/` 目录中的文件在根路径提供。例如，`public/style.css` 可在 `http://localhost:8080/style.css` 访问。

## 小结

在本章中，你学习了 Veb——V 内置的 Web 框架。你了解了如何定义带路径和查询参数的路由、返回 JSON 响应、渲染 HTML 模板、添加中间件处理横切关注点以及提供静态文件。在下一章中，我们将探讨 C 语言互操作。
