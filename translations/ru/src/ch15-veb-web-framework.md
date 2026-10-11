# Глава 15: Веб-фреймворк Veb

Veb — это встроенный веб-фреймворк V. Он предоставляет маршрутизацию, обработку JSON, HTML-шаблоны, промежуточное ПО (middleware) и раздачу статических файлов — всё с минимальным API.

## Привет, Veb!

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
Структура `App` хранит состояние вашего приложения. Каждый маршрут — это метод на `App` с аннотацией `@['/path']`. Обработчик получает `veb.Context`, который предоставляет методы для записи ответов.

## Маршрутизация

Veb использует параметры пути с синтаксисом `:name`. Параметры пути передаются напрямую как аргументы функции обработчику.

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
Параметры пути (`:id`) извлекаются из URL и передаются как аргументы. Параметры строки запроса (`?q=...`) доступны через `ctx.query`, который является `map[string]string`.

## JSON-ответы

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
`ctx.json()` сериализует любое значение V в JSON и устанавливает заголовок `Content-Type` в `application/json`.

## Шаблоны

Veb поддерживает HTML-шаблоны с функцией `$tmpl`. Шаблоны используют синтаксис интерполяции строк V.

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
Файл шаблона получает структуру данных и может обращаться к её полям через `{{ field_name }}`.

## Промежуточное ПО (Middleware)

Middleware оборачивает каждый запрос. Используйте `app.use()` для регистрации глобального middleware или `app.route_use()` для middleware конкретного маршрута.

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
Middleware возвращает `bool` — `true` для продолжения к следующему обработчику, `false` для остановки.

## Статические файлы

Veb может раздавать статические файлы из каталога с помощью `app.handle_static()`.

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
Файлы в каталоге `public/` раздаются по корневому пути. Например, `public/style.css` доступен по адресу `http://localhost:8080/style.css`.

## Итоги

В этой главе вы узнали о Veb — встроенном веб-фреймворке V. Вы увидели, как определять маршруты с параметрами пути и строки запроса, возвращать JSON-ответы, рендерить HTML-шаблоны, добавлять middleware для сквозных задач и раздавать статические файлы. В следующей главе мы рассмотрим интероперабельность с C.
