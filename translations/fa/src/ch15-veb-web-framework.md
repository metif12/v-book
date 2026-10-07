# فصل ۱۵: فریم‌ورک وب Veb

Veb فریم‌ورک وب داخلی V است. این فریم‌ورک مسیریابی، مدیریت JSON، قالب‌های HTML، میان‌افزار و سرو فایل‌های استاتیک را با یک سطح API حداقلی ارائه می‌دهد.

## سلام، Veb!

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

ساختار `App` وضعیت برنامه شما را نگه می‌دارد. هر مسیر یک متد روی `App` است که با `@['/path']` مشخص شده است. مدیریت‌کننده یک `veb.Context` دریافت می‌کند که متدهایی برای نوشتن پاسخ‌ها ارائه می‌دهد.

## مسیریابی

Veb از پارامترهای مسیر با سینتکس `:name` استفاده می‌کند. پارامترهای مسیر مستقیماً به عنوان آرگومان تابع به مدیریت‌کننده منتقل می‌شوند.

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

پارامترهای مسیر (`:id`) از URL استخراج و به عنوان آرگومان منتقل می‌شوند. پارامترهای query string (`?q=...`) از طریق `ctx.query` که یک `map[string]string` است قابل دسترسی هستند.

## پاسخ‌های JSON

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

`ctx.json()` هر مقدار V را به JSON سریالایز می‌کند و هدر `Content-Type` را به `application/json` تنظیم می‌کند.

## قالب‌ها

Veb از قالب‌های HTML با تابع `$tmpl` پشتیبانی می‌کند. قالب‌ها از سینتکس درون‌یابی رشته V استفاده می‌کنند.

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

فایل قالب ساختار داده را دریافت می‌کند و می‌تواند با `{{ field_name }}` به فیلدهای آن دسترسی داشته باشد.

## میان‌افزار

میان‌افزار هر درخواست را احاطه می‌کند. از `app.use()` برای ثبت میان‌افزار سراسری یا `app.route_use()` برای میان‌افزار مخصوص مسیر استفاده کنید.

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

میان‌افزار `bool` برمی‌گرداند — `true` برای ادامه به مدیریت‌کننده بعدی، `false` برای توقف.

## فایل‌های استاتیک

Veb می‌تواند فایل‌های استاتیک را از یک دایرکتوری با `app.handle_static()` سرو کند.

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

فایل‌های دایرکتوری `public/` در مسیر ریشه سرو می‌شوند. به عنوان مثال، `public/style.css` در `http://localhost:8080/style.css` قابل دسترسی است.

## خلاصه

در این فصل، درباره Veb — فریم‌ورک وب داخلی V یاد گرفتید. دیدید که چگونه مسیرها را با پارامترهای مسیر و query تعریف کنید، پاسخ‌های JSON برگردانید، قالب‌های HTML رندر کنید، میان‌افزار برای نگریستن مسائل مشترک اضافه کنید و فایل‌های استاتیک سرو کنید. در فصل بعد، به همکاری با C می‌پردازیم.
