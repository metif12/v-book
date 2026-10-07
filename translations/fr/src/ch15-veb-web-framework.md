# Chapitre 15 : Framework Web Veb

Veb est le framework web intégré de V. Il fournit le routage, la gestion JSON, les templates HTML, le middleware et le service de fichiers statiques — le tout avec une API minimale.

## Bonjour, Veb !

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

La struct `App` contient l'état de votre application. Chaque route est une méthode sur `App` annotée avec `@['/path']`. Le gestionnaire reçoit un `veb.Context` qui fournit des méthodes pour écrire des réponses.

## Routage

Veb utilise des paramètres de chemin avec la syntaxe `:name`. Les paramètres de chemin sont passés directement comme arguments de fonction au gestionnaire.

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

Les paramètres de chemin (`:id`) sont extraits de l'URL et passés comme arguments. Les paramètres de chaîne de requête (`?q=...`) sont accessibles via `ctx.query` qui est une `map[string]string`.

## Réponses JSON

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

`ctx.json()` sérialise n'importe quelle valeur V en JSON et définit l'en-tête `Content-Type` sur `application/json`.

## Templates

Veb supporte les templates HTML avec la fonction `$tmpl`. Les templates utilisent la syntaxe d'interpolation de chaînes de V.

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

Le fichier template reçoit la struct de données et peut accéder à ses champs avec `{{ field_name }}`.

## Middleware

Le middleware enveloppe chaque requête. Utilisez `app.use()` pour enregistrer un middleware global, ou `app.route_use()` pour un middleware spécifique à une route.

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

Le middleware renvoie un `bool` — `true` pour continuer vers le gestionnaire suivant, `false` pour arrêter.

## Fichiers statiques

Veb peut servir des fichiers statiques depuis un répertoire en utilisant `app.handle_static()`.

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

Les fichiers du répertoire `public/` sont servis à la racine. Par exemple, `public/style.css` est accessible à `http://localhost:8080/style.css`.

## Résumé

Dans ce chapitre, vous avez appris Veb — le framework web intégré de V. Vous avez vu comment définir des routes avec des paramètres de chemin et de requête, renvoyer des réponses JSON, rendre des templates HTML, ajouter du middleware pour les préoccupations transversales et servir des fichiers statiques. Dans le chapitre suivant, nous explorerons l'interop C.
