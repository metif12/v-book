# v fmt के साथ फॉर्मेटिंग

V में एक बिल्ट-इन कोड फॉर्मेटर है:

```bash
v fmt -w .
```

`-w` फ़्लैग परिवर्तनों को वापस फ़ाइलों में लिखता है। इसके बिना, फॉर्मेटर stdout पर प्रिंट करता है।

## उदाहरण

पहले:

```v
struct Config {
mut:
	debug bool
	path  string
}

fn describe(c Config) string {
	return 'debug=${c.debug} path=${c.path}'
}

fn main() {
	c := Config{
		debug: true
		path:  '/tmp/app'
	}
	println(describe(c))
	assert describe(c) == 'debug=true path=/tmp/app'
}
```
`v fmt` के बाद:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## अगला

[v test के साथ टेस्टिंग](ch02-04-testing.md)
