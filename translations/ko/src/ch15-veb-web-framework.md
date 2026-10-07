# Chapter 15: Veb 웹 프레임워크

Veb는 V의 내장 웹 프레임워크입니다. 라우팅, JSON 처리, HTML 템플릿, 미들웨어, 정적 파일 서빙을 최소한의 API 표면으로 제공합니다.

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

`App` struct는 애플리케이션 상태를 저장합니다. 각 라우트는 `@['/path']` 어노테이션이 있는 `App`의 메서드입니다. 핸들러는 응답 작성을 위한 메서드를 제공하는 `veb.Context`를 받습니다.

## 라우팅

Veb는 `:name` 구문으로 경로 파라미터를 사용합니다. 경로 파라미터는 핸들러의 함수 인자로 직접 전달됩니다.

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

경로 파라미터(`:id`)는 URL에서 추출되어 인자로 전달됩니다. 쿼리 문자열 파라미터(`?q=...`)는 `map[string]string`인 `ctx.query`를 통해 접근합니다.

## JSON 응답

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

`ctx.json()`은 모든 V 값을 JSON으로 직렬화하고 `Content-Type` 헤더를 `application/json`으로 설정합니다.

## 템플릿

Veb는 `$tmpl` 함수로 HTML 템플릿을 지원합니다. 템플릿은 V의 문자열 보간 구문을 사용합니다.

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

템플릿 파일은 데이터 struct를 받아 `{{ field_name }}`으로 필드에 접근할 수 있습니다.

## 미들웨어

미들웨어는 모든 요청을 감쌉니다. `app.use()`로 전역 미들웨어를 등록하거나 `app.route_use()`로 라우트별 미들웨어를 등록하세요.

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

미들웨어는 `bool`을 반환합니다. `true`는 다음 핸들러로 계속, `false`는 중지입니다.

## 정적 파일

Veb는 `app.handle_static()`으로 디렉터리에서 정적 파일을 서빙할 수 있습니다.

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

`public/` 디렉터리의 파일은 루트 경로에서 서빙됩니다. 예를 들어 `public/style.css`는 `http://localhost:8080/style.css`에서 접근할 수 있습니다.

## 요약

이 장에서는 V의 내장 웹 프레임워크인 Veb에 대해 배웠습니다. 경로 및 쿼리 파라미터로 라우트를 정의하고, JSON 응답을 반환하고, HTML 템플릿을 렌더링하고, 횡단 관심사를 위한 미들웨어를 추가하고, 정적 파일을 서빙하는 방법을 살펴보았습니다. 다음 장에서는 C 인터롭을 살펴보겠습니다.
