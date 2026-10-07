# باب ۱۵: Veb ویب فریم ورک

Veb V کا بلٹ اِن ویب فریم ورک ہے۔ یہ روٹنگ، JSON ہینڈلنگ، HTML ٹیمپلیٹس، مڈل ویئر، اور اسٹیک فائل سروس فراہم کرتا ہے — سب کچھ ایک مختصر API سطح کے ساتھ۔

## ہیلو، Veb!

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

`App` struct آپ کی ایپلیکیشن کی حالت رکھتا ہے۔ ہر روٹ `App` پر ایک میتھڈ ہے جو `@['/path']` کے ساتھ تشریف ہے۔ ہینڈلر ایک `veb.Context` وصول کرتا ہے جو جوابات لکھنے کے لیے میتھڈز فراہم کرتا ہے۔

## روٹنگ

Veb `:name` نحو کے ساتھ پاتھ پیرامیٹرز استعمال کرتا ہے۔ پاتھ پیرامیٹرز براہ راست فنکشن کی دلیل کے طور پر ہینڈلر کو دیے جاتے ہیں۔

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

پاتھ پیرامیٹرز (`:id`) URL سے نکالے جاتے ہیں اور دلیل کے طور پر دیے جاتے ہیں۔ کوئری اسٹرنگ پیرامیٹرز (`?q=...`) `ctx.query` کے ذریعے تک رسائی ہوتے ہیں جو ایک `map[string]string` ہے۔

## JSON جوابات

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

`ctx.json()` کسی بھی V قدر کو JSON میں سیریلائز کرتا ہے اور `Content-Type` ہیڈر کو `application/json` پر سیٹ کرتا ہے۔

## ٹیمپلیٹس

Veb `$tmpl` فنکشن کے ساتھ HTML ٹیمپلیٹس کی حمایت کرتا ہے۔ ٹیمپلیٹس V کے اسٹرنگ انٹرپولیشن نحو استعمال کرتے ہیں۔

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

ٹیمپلیٹ فائل ڈیٹا struct وصول کرتی ہے اور `{{ field_name }}` کے ذریعے اس کے فیلڈز تک رسائی حاصل کر سکتی ہے۔

## مڈل ویئر

مڈل ویئر ہر درخواست کو لپیٹتا ہے۔ عالمی مڈل ویئر کو رجسٹر کرنے کے لیے `app.use()` استعمال کریں، یا روٹ کے لیے `app.route_use()` استعمال کریں۔

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

مڈل ویئر `bool` واپس کرتا ہے — اگلے ہینڈلر پر جانے کے لیے `true`، روکنے کے لیے `false`۔

## اسٹیک فائلیں

Veb `app.handle_static()` کے ذریعے ڈائریکٹری سے اسٹیک فائلیں سروس کر سکتا ہے۔

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

`public/` ڈائریکٹری کی فائلیں روٹ پاتھ پر سروس ہوتی ہیں۔ مثال کے طور پر، `public/style.css` `http://localhost:8080/style.css` پر قابل رسائی ہے۔

## خلاصہ

اس باب میں، آپ نے Veb — V کا بلٹ اِن ویب فریم ورک کے بارے میں سیکھا۔ آپ نے دیکھا کہ پاتھ اور کوئری پیرامیٹرز کے ساتھ روٹس کیسے تعریف کریں، JSON جوابات کیسے واپس کریں، HTML ٹیمپلیٹس کیسے رینڈر کریں، کراس کٹنگ خدمتوں کے لیے مڈل ویئر کیسے شامل کریں، اور اسٹیک فائلیں کیسے سروس کریں۔ اگلے باب میں، ہم C انٹراپ کو دریافت کریں گے۔
