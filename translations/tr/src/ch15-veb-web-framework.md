# Bölüm 15: Veb Web Framework

Veb, V'nin yerleşik web framework'üdür. Yönlendirme, JSON işleme, HTML şablonları, middleware ve statik dosya sunma gibi özellikleri minimal bir API yüzeyiyle sunar.

## Merhaba, Veb!

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

`App` struct'ı uygulama durumunuzu tutar. Her rota, `@['/path']` ile açıklanan `App` üzerinde bir metottur. Handler, yanıt yazmak için metotlar sağlayan bir `veb.Context` alır.

## Yönlendirme

Veb, `:name` sözdizimiyle yol parametreleri kullanır. Yol parametreleri doğrudan handler'a fonksiyon argümanı olarak geçirilir.

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

Yol parametreleri (`:id`) URL'den çıkarılır ve argüman olarak geçirilir. Sorgu string parametreleri (`?q=...`) `ctx.query` üzerinden erişilir, bu bir `map[string]string` dir.

## JSON yanıtları

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

`ctx.json()`, herhangi bir V değerini JSON'a serileştirir ve `Content-Type` başlığını `application/json` olarak ayarlar.

## Şablonlar

Veb, `$tmpl` fonksiyonu ile HTML şablonlarını destekler. Şablonlar V'nin string interpolasyon sözdizimini kullanır.

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

Şablon dosyası veri struct'ını alır ve `{{ field_name }}` ile alanlarına erişebilir.

## Middleware

Middleware her isteği sarar. Global middleware kaydetmek için `app.use()`, rota özel middleware için `app.route_use()` kullanın.

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

Middleware `bool` döner — sonraki handler'a devam etmek için `true`, durdurmak için `false`.

## Statik dosyalar

Veb, `app.handle_static()` kullanarak bir dizinden statik dosyalar sunabilir.

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

`public/` dizinindeki dosyalar kök yolda sunulur. Örneğin, `public/style.css` adresine `http://localhost:8080/style.css` ile erişilebilir.

## Özet

Bu bölümde V'nin yerleşik web framework'ü Veb hakkında bilgi edindiniz. Yol ve sorgu parametreleriyle rotalar tanımlamayı, JSON yanıtları döndürmeyi, HTML şablonları render etmeyi, cross-cutting concern'ler için middleware eklemeyi ve statik dosyalar sunmayı gördünüz. Sonraki bölümde C birlikte çalışmayı inceleyeceğiz.
