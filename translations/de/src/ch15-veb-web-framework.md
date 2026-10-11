# Kapitel 15: Veb Web Framework

Veb ist das integrierte Web-Framework von V. Es bietet Routing, JSON-Verarbeitung, HTML-Templates, Middleware und das Bereitstellen statischer Dateien — alles mit einer minimalen API.

## Hallo, Veb!

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
Die `App`-Struktur enthält Ihren Anwendungszustand. Jede Route ist eine Methode auf `App`, annotiert mit `@['/path']`. Der Handler erhält einen `veb.Context`, der Methoden zum Schreiben von Antworten bereitstellt.

## Routing

Veb verwendet Pfadparameter mit der `:name`-Syntax. Pfadparameter werden direkt als Funktionsargumente an den Handler übergeben.

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
Pfadparameter (`:id`) werden aus der URL extrahiert und als Argumente übergeben. Query-String-Parameter (`?q=...`) werden über `ctx.query` abgerufen, das eine `map[string]string` ist.

## JSON-Antworten

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
`ctx.json()` serialisiert jeden V-Wert zu JSON und setzt den `Content-Type`-Header auf `application/json`.

## Templates

Veb unterstützt HTML-Templates mit der `$tmpl`-Funktion. Templates verwenden die String-Interpolationssyntax von V.

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
Die Template-Datei erhält die Datenstruktur und kann mit `{{ field_name }}` auf ihre Felder zugreifen.

## Middleware

Middleware umschließt jede Anfrage. Verwenden Sie `app.use()`, um globale Middleware zu registrieren, oder `app.route_use()` für routenspezifische Middleware.

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
Middleware gibt `bool` zurück — `true`, um zum nächsten Handler fortzufahren, `false`, um zu stoppen.

## Statische Dateien

Veb kann statische Dateien aus einem Verzeichnis mit `app.handle_static()` bereitstellen.

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
Dateien im `public/`-Verzeichnis werden unter dem Stammpfad bereitgestellt. Zum Beispiel ist `public/style.css` unter `http://localhost:8080/style.css` zugänglich.

## Zusammenfassung

In diesem Kapitel haben Sie Veb kennengelernt — das integrierte Web-Framework von V. Sie haben gelernt, wie man Routes mit Pfad- und Query-Parametern definiert, JSON-Antworten zurückgibt, HTML-Templates rendert, Middleware für übergreifende Anliegen hinzufügt und statische Dateien bereitstellt. Im nächsten Kapitel untersuchen wir C-Interop.
