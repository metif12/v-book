# অধ্যায় 17: অ্যাডভান্সড ফিচার

## অ্যাট্রিবিউট

অ্যাট্রিবিউট হল মেটাডেটা অ্যানোটেশন যা ঘোষণার আগে রাখা হয়। এগুলো কম্পাইলার আচরণ, অপ্টিমাইজেশন ইঙ্গিত এবং API লাইফসাইকেল নিয়ন্ত্রণ করে।

### [deprecated]

ফাংশন বা টাইপকে অপ্রচলিত হিসেবে চিহ্নিত করে। আইটেম ব্যবহার করলে কম্পাইলার সতর্কতা জারি করে।

```v
[deprecated]
fn old_add(a int, b int) int {
    return a + b
}

[deprecated: 'Use new_add instead']
fn old_multiply(a int, b int) int {
    return a * b
}
```

### [inline]

কম্পাইলারকে কল সাইটে ফাংশন ইনলাইন করার ইঙ্গিত দেয়, কল ওভারহেড দূর করে। ছোট, ঘন ঘন কল হওয়া ফাংশনের জন্য সবচেয়ে ভালো।

```v
[inline]
fn square(x int) int {
    return x * x
}

fn main() {
    result := square(5)
    println(result)
}
```

### [unsafe]

ফাংশনকে অনিরাপদ হিসেবে চিহ্নিত করে, যা কলারকেও অনিরাপদ হিসেবে চিহ্নিত না করে `unsafe` ব্লক ব্যবহার করার অনুমতি দেয়।

```v
[unsafe]
fn read_pointer(ptr voidptr) int {
    return unsafe { *(&int(ptr)) }
}

fn main() {
    x := 42
    val := read_pointer(&x)
    println(val)
}
```

### [if]

কম্পাইল টাইমে শর্তাধীন কম্পাইলেশন। শর্ত সত্য হলেই ব্লক অন্তর্ভুক্ত হয়।

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## কম্পাইল-টাইম কোড

V কম্পাইলেশন চলাকালীন মেটাপ্রোগ্রামিং এবং শূন্য-খরচ অ্যাবস্ট্রাকশন সক্ষম করে এমন একাধিক কম্পাইল-টাইম কনস্ট্রাক্ট প্রদান করে।

### $if

কম্পাইল টাইমে শর্ত মূল্যায়ন করে। প্ল্যাটফর্ম সনাক্তকরণ, আর্কিটেকচার পরীক্ষা এবং কাস্টম ফ্ল্যাগ সমর্থন করে।

```v
$if windows {
    const os_name = 'Windows'
} $else $if macos {
    const os_name = 'macOS'
} $else $if linux {
    const os_name = 'Linux'
} $else {
    const os_name = 'Unknown'
}

fn main() {
    println('Running on ${os_name}')
}
```

### $for

কম্পাইল টাইমে অ্যারে, struct ফিল্ড বা রেঞ্জের উপর পুনরাবৃত্তি করে। পুনরাবৃত্তিমূলক কোড তৈরিতে কার্যকর।

```v
const platforms = ['windows', 'linux', 'macos']

fn is_platform(name string) bool {
    return name in platforms
}

fn main() {
    println(is_platform('windows'))
    println(is_platform('linux'))
    println(is_platform('macos'))
    println(is_platform('freebsd'))
}
```

### $assert

কম্পাইল-টাইম অ্যাসারশন যা শর্ত মিথ্যা হলে কম্পাইলেশন বন্ধ করে।

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## অপারেটর ওভারলোডিং

V ব্যবহারকারী-সংজ্ঞায়িত টাইপে অপারেটরের জন্য কাস্টম আচরণ সংজ্ঞায়িত করতে দেয়। প্রতিটি অপারেটর একটি নির্দিষ্ট সিগনেচার সহ একটি মেথডের সাথে ম্যাপ করা হয়।

### পাঙ্কিতিক অপারেটর

```v
struct Vec2 {
    x f64
    y f64
}

fn (a Vec2) + (b Vec2) Vec2 {
    return Vec2{x: a.x + b.x, y: a.y + b.y}
}

fn (a Vec2) - (b Vec2) Vec2 {
    return Vec2{x: a.x - b.x, y: a.y - b.y}
}

fn (a Vec2) * (b Vec2) Vec2 {
    return Vec2{x: a.x * b.x, y: a.y * b.y}
}

fn (a Vec2) / (b Vec2) Vec2 {
    return Vec2{x: a.x / b.x, y: a.y / b.y}
}

fn main() {
    a := Vec2{x: 10, y: 20}
    b := Vec2{x: 2, y: 4}
    sum := a + b
    diff := a - b
    prod := a * b
    quot := a / b
    println('Sum: ${sum.x}, ${sum.y}')
    println('Diff: ${diff.x}, ${diff.y}')
    println('Prod: ${prod.x}, ${prod.y}')
    println('Quot: ${quot.x}, ${quot.y}')
}
```

### তুলনামূলক অপারেটর

```v
struct Money {
    amount   f64
    currency string
}

fn (a Money) == (b Money) bool {
    return a.amount == b.amount && a.currency == b.currency
}

fn main() {
    a := Money{amount: 10.0, currency: 'USD'}
    b := Money{amount: 10.0, currency: 'USD'}
    c := Money{amount: 20.0, currency: 'USD'}
    println(a == b)
    println(a == c)
}
```

### ইনডেক্স অপারেটর

```v
struct Grid {
    data [][]int
}

fn (g Grid) row_count() int {
    return g.data.len
}

fn (g Grid) get(row int, col int) int {
    return g.data[row][col]
}

fn main() {
    g := Grid{
        data: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    }
    println(g.row_count())
    println(g.get(1, 2))
}
```

## কম্পাইল-টাইম রিফ্লেকশন

V-এর `$for` কনস্ট্রাক্ট কম্পাইল টাইমে struct ফিল্ডের উপর পুনরাবৃত্তি করতে পারে, যা স্বয়ংক্রিয় সিরিয়ালাইজেশন, যাচাইকরণ ইত্যাদি সক্ষম করে।

### struct ফিল্ডের উপর পুনরাবৃত্তি

```v
struct User {
    id    int
    name  string
    email string
    age   int
}

fn main() {
    u := User{
        id: 1
        name: 'Alice'
        email: 'alice@example.com'
        age: 30
    }
    $for field in User.fields {
        $if field.typ is string {
            println('${field.name} is a string field')
        } $else $if field.typ is int {
            println('${field.name} is an int field')
        }
    }
    println('${u.name} is ${u.age} years old')
}
```

### যাচাইকরণ কোড তৈরি

```v
struct Config {
    host    string
    port    int
    timeout f64
}

fn validate_config(c Config) ! {
    $for field in Config.fields {
        $if field.typ is string {
            if c.$(field.name).len == 0 {
                return error('${field.name} must not be empty')
            }
        } $else $if field.typ is int {
            if c.$(field.name) <= 0 {
                return error('${field.name} must be positive')
            }
        }
    }
}

fn main() {
    cfg := Config{
        host: 'localhost'
        port: 8080
        timeout: 30.0
    }
    validate_config(cfg) or {
        println('Config invalid: ${err}')
        return
    }
    println('Config is valid')
}
```

## সারসংক্ষেপ

এই অধ্যায়ে আপনি অ্যাট্রিবিউট, কম্পাইল-টাইম কোড, অপারেটর ওভারলোডিং এবং কম্পাইল-টাইম রিফ্লেকশন সম্পর্কে শিখেছেন। এই ফিচারগুলো শক্তিশালী মেটাপ্রোগ্রামিং প্যাটার্ন এবং কম্পাইলেশনের উপর সূক্ষ্ম নিয়ন্ত্রণ সক্ষম করে। পরবর্তী অধ্যায়ে আমরা মেমোরি ম্যানেজমেন্ট গভীরে শিখব।
