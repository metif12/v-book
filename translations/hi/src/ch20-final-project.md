# अध्याय 20: फाइनल प्रोजेक्ट: वेब एप्लिकेशन

इस अध्याय में, हम Veb और ORM के साथ एक सरल वेब एप्लिकेशन बनाएंगे।

## प्रोजेक्ट सेटअप

```bash
mkdir myapp
cd myapp
v init
```

## डेटाबेस

```v no_run
import veb
import db.sqlite

struct App {
    db sqlite.DB
}

struct User {
    id   int
    name string
    email string
}

fn main() {
    mut app := App{
        db: sqlite.connect('myapp.db') or { panic(err) }
    }
    sql app.db {
        create table User
    } or {}
    veb.run(mut app, 8080)
}
```

## रूट्स

```v no_run
import veb
import db.sqlite

struct App {
    db sqlite.DB
}

struct User {
    id   int
    name string
    email string
}

@['/']
fn (mut app App) index(mut ctx veb.Context) {
    ctx.text('Welcome!')
}

@['/users']
fn (mut app App) users(mut ctx veb.Context) {
    users := sql app.db {
        select from User
    } or { [] }
    ctx.json(users)
}
```

## सारांश

बधाई हो! आपने V प्रोग्रामिंग भाषा बुक पूरी कर ली है। अब आपके पास V की मजबूत नींव है और आप वास्तविक-दुनिया की एप्लिकेशन बनाने के लिए तैयार हैं।
