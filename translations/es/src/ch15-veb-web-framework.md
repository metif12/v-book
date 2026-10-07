# Capítulo 15: Framework Web Veb

Veb es el framework web integrado de V. Proporciona enrutamiento, manejo de JSON, plantillas HTML, middleware y servicio de archivos estáticos — todo con una superficie de API mínima.

## ¡Hola, Veb!

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

El struct `App` contiene el estado de tu aplicación. Cada ruta es un método en `App` anotado con `@['/path']`. El handler recibe un `veb.Context` que proporciona métodos para escribir respuestas.

## Enrutamiento

Veb usa parámetros de ruta con la sintaxis `:name`. Los parámetros de ruta se pasan directamente como argumentos de la función al handler.

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

Los parámetros de ruta (`:id`) se extraen de la URL y se pasan como argumentos. Los parámetros de cadena de consulta (`?q=...`) se acceden vía `ctx.query` que es un `map[string]string`.

## Respuestas JSON

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

`ctx.json()` serializa cualquier valor V a JSON y establece el encabezado `Content-Type` a `application/json`.

## Plantillas

Veb soporta plantillas HTML con la función `$tmpl`. Las plantillas usan la sintaxis de interpolación de strings de V.

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

El archivo de plantilla recibe el struct de datos y puede acceder a sus campos con `{{ field_name }}`.

## Middleware

El middleware envuelve cada solicitud. Usa `app.use()` para registrar middleware global, o `app.route_use()` para middleware específico de ruta.

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

El middleware retorna `bool` — `true` para continuar al siguiente handler, `false` para detener.

## Archivos estáticos

Veb puede servir archivos estáticos desde un directorio usando `app.handle_static()`.

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

Los archivos en el directorio `public/` se sirven en la ruta raíz. Por ejemplo, `public/style.css` es accesible en `http://localhost:8080/style.css`.

## Resumen

En este capítulo, aprendiste sobre Veb — el framework web integrado de V. Viste cómo definir rutas con parámetros de ruta y consulta, devolver respuestas JSON, renderizar plantillas HTML, agregar middleware para preocupaciones transversales y servir archivos estáticos. En el siguiente capítulo, exploraremos la interoperabilidad con C.
