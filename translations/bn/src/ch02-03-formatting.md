# v fmt দিয়ে ফরম্যাটিং

V-তে একটি বিল্ট-ইন কোড ফরম্যাটার আছে:

```bash
v fmt -w .
```

`-w` ফ্ল্যাগ পরিবর্তনগুলো ফাইলে ফিরিয়ে লেখে। এটি ছাড়া ফরম্যাটার stdout-এ প্রিন্ট করে।

## উদাহরণ

আগে:

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
`v fmt` এর পর:

```v
fn shout(s string) string {
	return s.to_upper()
}

fn main() {
	println(shout('hello formats'))
}
```
## পরবর্তী

[v test দিয়ে টেস্টিং](ch02-04-testing.md)
