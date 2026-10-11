# অধ্যায় 15: Veb ওয়েব ফ্রেমওয়ার্ক

Veb হল V-এর বিল্ট-ইন ওয়েব ফ্রেমওয়ার্ক। এটি রাউটিং, JSON হ্যান্ডলিং, HTML টেমপ্লেট, মিডলওয়্যার এবং স্ট্যাটিক ফাইল সার্ভিং প্রদান করে — সবই একটি ন্যূনতম API সারফেসের সাথে।

## হ্যালো, Veb!

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
`App` struct আপনার অ্যাপ্লিকেশন স্টেট ধরে রাখে। প্রতিটি রাউট হল `App`-এর একটি মেথড যা `@['/path']` দিয়ে চিহ্নিত। হ্যান্ডলার একটি `veb.Context` পায় যা রেসপন্স লেখার জন্য মেথড প্রদান করে।

## রাউটিং

Veb `:name` সিনট্যাক্স দিয়ে প্যাথ প্যারামিটার ব্যবহার করে। প্যাথ প্যারামিটার সরাসরি হ্যান্ডলারের আর্গুমেন্ট হিসেবে পাঠানো হয়।

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
প্যাথ প্যারামিটার (`:id`) URL থেকে বের করা হয় এবং আর্গুমেন্ট হিসেবে পাঠানো হয়। কোয়েরি স্ট্রিং প্যারামিটার (`?q=...`) `ctx.query` এর মাধ্যমে অ্যাক্সেস করা যায় যা একটি `map[string]string`।

## JSON রেসপন্স

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
`ctx.json()` যেকোনো V মানকে JSON-এ সিরিয়ালাইজ করে এবং `Content-Type` হেডার `application/json`-এ সেট করে।

## টেমপ্লেট

Veb `$tmpl` ফাংশন দিয়ে HTML টেমপ্লেট সমর্থন করে। টেমপ্লেট V-এর স্ট্রিং ইন্টারপোলেশন সিনট্যাক্স ব্যবহার করে।

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
টেমপ্লেট ফাইল ডেটা struct পায় এবং `{{ field_name }}` দিয়ে এর ফিল্ড অ্যাক্সেস করতে পারে।

## মিডলওয়্যার

মিডলওয়্যার প্রতিটি রিকোয়েস্টকে মোড়ায়। গ্লোবাল মিডলওয়্যার রেজিস্টার করতে `app.use()` ব্যবহার করুন, অথবা রাউট-নির্দিষ্ট মিডলওয়্যারের জন্য `app.route_use()` ব্যবহার করুন।

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
মিডলওয়্যার `bool` ফেরত দেয় — পরবর্তী হ্যান্ডলারে যেতে `true`, থামতে `false`।

## স্ট্যাটিক ফাইল

Veb `app.handle_static()` ব্যবহার করে একটি ডিরেক্টরি থেকে স্ট্যাটিক ফাইল সার্ভ করতে পারে।

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
`public/` ডিরেক্টরির ফাইলগুলো রুট প্যাথে সার্ভ হয়। উদাহরণস্বরূপ, `public/style.css` অ্যাক্সেসযোগ্য `http://localhost:8080/style.css`-এ।

## সারসংক্ষেপ

এই অধ্যায়ে আপনি Veb সম্পর্কে শিখেছেন — V-এর বিল্ট-ইন ওয়েব ফ্রেমওয়ার্ক। আপনি দেখেছেন কীভাবে প্যাথ এবং কোয়েরি প্যারামিটার দিয়ে রাউট সংজ্ঞায়িত করতে হয়, JSON রেসপন্স ফেরত দিতে হয়, HTML টেমপ্লেট রেন্ডার করতে হয়, ক্রস-কাটিং কনসার্নের জন্য মিডলওয়্যার যোগ করতে হয় এবং স্ট্যাটিক ফাইল সার্ভ করতে হয়। পরবর্তী অধ্যায়ে আমরা C ইন্টরপ শিখব।
