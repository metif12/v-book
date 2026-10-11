# Capitolo 15: Framework Web Veb

Veb è il framework web integrato di V. Fornisce routing, gestione JSON, template HTML, middleware e serving di file statici — tutto con una superficie API minima.

## Ciao, Veb!

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
Lo struct `App` contiene lo stato della tua applicazione. Ogni route è un metodo su `App` annotato con `@['/path']`. L'handler riceve un `veb.Context` che fornisce metodi per scrivere le risposte.

## Routing

Veb usa parametri di percorso con la sintassi `:name`. I parametri di percorso vengono passati direttamente come argomenti della funzione all'handler.

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
I parametri di percorso (`:id`) vengono estratti dall'URL e passati come argomenti. I parametri della query string (`?q=...`) sono accessibili tramite `ctx.query` che è una `map[string]string`.

## Risposte JSON

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
`ctx.json()` serializza qualsiasi valore V in JSON e imposta l'header `Content-Type` su `application/json`.

## Template

Veb supporta template HTML con la funzione `$tmpl`. I template usano la sintassi di interpolazione delle stringhe di V.

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
Il file template riceve lo struct dei dati e può accedere ai suoi campi con `{{ field_name }}`.

## Middleware

Il middleware avvolge ogni richiesta. Usa `app.use()` per registrare middleware globale, o `app.route_use()` per middleware specifici per route.

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
Il middleware ritorna `bool` — `true` per continuare al prossimo handler, `false` per fermarsi.

## File statici

Veb può servire file statici da una directory usando `app.handle_static()`.

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
I file nella directory `public/` vengono serviti al percorso root. Ad esempio, `public/style.css` è accessibile a `http://localhost:8080/style.css`.

## Riassunto

In questo capitolo, hai imparato Veb — il framework web integrato di V. Hai visto come definire route con parametri di percorso e query, ritornare risposte JSON, renderizzare template HTML, aggiungere middleware per preoccupazioni trasversali e servire file statici. Nel prossimo capitolo, esploreremo l'interop con C.
