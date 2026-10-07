# Capítulo 15: Framework Web Veb

Veb é o framework web imbutido de V. Ele fornece roteamento, manipulação de JSON, templates HTML, middleware e servimento de arquivos estáticos — tudo com uma superfície de API mínima.

## Olá, Veb!

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

A struct `App` armazena o estado da sua aplicação. Cada rota é um método em `App` anotado com `@['/path']`. O handler recebe um `veb.Context` que fornece métodos para escrever respostas.

## Roteamento

Veb usa parâmetros de caminho com a sintaxe `:name`. Parâmetros de caminho são passados diretamente como argumentos da função para o handler.

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

Parâmetros de caminho (`:id`) são extraídos da URL e passados como argumentos. Parâmetros de query string (`?q=...`) são acessados via `ctx.query` que é um `map[string]string`.

## Respostas JSON

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

`ctx.json()` serializa qualquer valor V para JSON e define o cabeçalho `Content-Type` para `application/json`.

## Templates

Veb suporta templates HTML com a função `$tmpl`. Templates usam a sintaxe de interpolação de strings de V.

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

O arquivo de template recebe a struct de dados e pode acessar seus campos com `{{ field_name }}`.

## Middleware

Middleware envolve cada requisição. Use `app.use()` para registrar middleware global, ou `app.route_use()` para middleware específico de rota.

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

Middleware retorna `bool` — `true` para continuar para o próximo handler, `false` para parar.

## Arquivos estáticos

Veb pode servir arquivos estáticos de um diretório usando `app.handle_static()`.

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

Arquivos no diretório `public/` são servidos no caminho raiz. Por exemplo, `public/style.css` é acessível em `http://localhost:8080/style.css`.

## Resumo

Neste capítulo, você aprendeu sobre Veb — o framework web imbutido de V. Você viu como definir rotas com parâmetros de caminho e query, retornar respostas JSON, renderizar templates HTML, adicionar middleware para preocupações transversais e servir arquivos estáticos. No próximo capítulo, vamos explorar interop com C.
