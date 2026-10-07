# अध्याय 15: Veb वेब फ्रेमवर्क

Veb V का बिल्ट-इन वेब फ्रेमवर्क है। यह राउटिंग, JSON हैंडलिंग, HTML टेम्पलेट, मिडलवेयर और स्टैटिक फ़ाइल सर्विंग प्रदान करता है — सब कुछ न्यूनतम API सरफ़ेस के साथ।

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

`App` struct आपके एप्लिकेशन स्टेट को धारण करता है। प्रत्येक रूट `App` पर एक मेथड है जो `@['/path']` से एनोटेट किया गया है। हैंडलर एक `veb.Context` प्राप्त करता है जो रिस्पॉन्स लिखने के लिए मेथड्स प्रदान करता है।

## राउटिंग

Veb `:name` सिंटैक्स के साथ पैरामीटर का उपयोग करता है। पैरामीटर सीधे हैंडलर को फ़ंक्शन आर्ग्यूमेंट के रूप में पास किए जाते हैं।

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

पैरामीटर (`:id`) URL से निकाले जाते हैं और आर्ग्यूमेंट के रूप में पास किए जाते हैं। क्वेरी स्ट्रिंग पैरामीटर (`?q=...`) `ctx.query` के माध्यम से एक्सेस किए जाते हैं जो एक `map[string]string` है।

## JSON रिस्पॉन्स

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

`ctx.json()` किसी भी V मान को JSON में सीरियलाइज़ करता है और `Content-Type` हेडर को `application/json` पर सेट करता है।

## टेम्पलेट

Veb `$tmpl` फ़ंक्शन के साथ HTML टेम्पलेट को सपोर्ट करता है। टेम्पलेट V की स्ट्रिंग इंटरपोलेशन सिंटैक्स का उपयोग करते हैं।

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

टेम्पलेट फ़ाइल डेटा struct प्राप्त करती है और `{{ field_name }}` के साथ उसके फ़ील्ड्स तक पहुंच सकती है।

## मिडलवेयर

मिडलवेयर प्रत्येक रिक्वेस्ट को रैप करता है। ग्लोबल मिडलवेयर रजिस्टर करने के लिए `app.use()` का उपयोग करें, या रूट-विशिष्ट मिडलवेयर के लिए `app.route_use()` का उपयोग करें।

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

मिडलवेयर `bool` रिटर्न करता है — अगले हैंडलर पर जाने के लिए `true`, रोकने के लिए `false`।

## स्टैटिक फ़ाइलें

Veb `app.handle_static()` का उपयोग करके डायरेक्टरी से स्टैटिक फ़ाइलें सर्व कर सकता है।

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

`public/` डायरेक्टरी की फ़ाइलें रूट पथ पर सर्व होती हैं। उदाहरण के लिए, `public/style.css` पर `http://localhost:8080/style.css` पर एक्सेस योग्य है।

## सारांश

इस अध्याय में, आपने Veb के बारे में सीखा — V का बिल्ट-इन वेब फ्रेमवर्क। आपने देखा कि पैरामीटर और क्वेरी पैरामीटर के साथ रूट कैसे परिभाषित करें, JSON रिस्पॉन्स कैसे रिटर्न करें, HTML टेम्पलेट कैसे रेंडर करें, क्रॉस-कटिंग कंसर्न के लिए मिडलवेयर कैसे जोड़ें, और स्टैटिक फ़ाइलें कैसे सर्व करें। अगले अध्याय में, हम C इंटरॉप का पता लगाएंगे।
