# الفصل 15: إطار عمل Veb للويب

Veb هو إطار عمل الويب المدمج في V. يوفر التوجيه، معالجة JSON، قوالب HTML، middleware، وتقديم الملفات الثابتة — كل ذلك بواجهة API بسيطة.

## مرحباً، Veb!

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

struct `App` يحتفظ بحالة تطبيقك. كل مسار هو دالة على `App` مُعلَّمة بـ `@['/path']`. المعالج يستقبل `veb.Context` الذي يوفر دوالاً لكتابة الاستجابات.

## التوجيه (Routing)

Veb يستخدم معاملات المسار بصيغة `:name`. معاملات المسار تُمرَّر مباشرة كمعاملات للدالة المعالجة.

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

معاملات المسار (`:id`) تُستخرج من عنوان URL وتُمرَّر كمعاملات. معاملات سلسلة الاستعلام (`?q=...`) تُوصَل عبر `ctx.query` وهو `map[string]string`.

## استجابات JSON

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

`ctx.json()` يُسلسِل أي قيمة V إلى JSON ويعيّن ترويسة `Content-Type` إلى `application/json`.

## القوالب (Templates)

Veb يدعم قوالب HTML مع دالة `$tmpl`. القوالب تستخدم صيغة استيفاء النصوص في V.

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

ملف القالب يستقبل struct البيانات ويمكنه الوصول إلى حقوله بـ `{{ field_name }}`.

## Middleware

middleware يُغلِّف كل طلب. استخدم `app.use()` لتسجيل middleware عام، أو `app.route_use()` لمiddleware خاص بمسار.

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

middleware يُعيد `bool` — `true` للمتابعة إلى المعالج التالي، `false` للتوقف.

## الملفات الثابتة

Veb يمكنه تقديم الملفات الثابتة من مجلد باستخدام `app.handle_static()`.

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

الملفات في مجلد `public/` تُقدَّم عند المسار الجذري. على سبيل المثال، `public/style.css` متاح على `http://localhost:8080/style.css`.

## الملخص

في هذا الفصل، تعلمت عن Veb — إطار عمل الويب المدمج في V. رأيت كيف تُعرّف المسارات بمعاملات المسار وسلسلة الاستعلام، وتُعيد استجابات JSON، وتُصيغ قوالب HTML، وتضيف middleware للمخاوف المتقاطعة، وتقدم الملفات الثابتة. في الفصل التالي، سنستكشف التفاعل مع C.
