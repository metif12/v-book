# अध्याय 17: एडवांस्ड फ़ीचर्स

## एट्रिब्यूट्स

एट्रिब्यूट्स घोषणाओं से पहले रखे गए मेटाडेटा एनोटेशन हैं। ये कंपाइलर व्यवहार, ऑप्टिमाइज़ेशन संकेत और API लाइफसाइकल को नियंत्रित करते हैं।

### [deprecated]

फ़ंक्शन या टाइप को डिप्रिकेटेड के रूप में चिह्नित करता है। आइटम के उपयोग पर कंपाइलर एक चेतावनी देता है।

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

कंपाइलर को कॉल साइट पर फ़ंक्शन को इनलाइन करने का संकेत देता है, कॉल ओवरहेड को समाप्त करता है। छोटे, बार-बार कॉल किए जाने वाले फ़ंक्शन के लिए सबसे अच्छा।

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

फ़ंक्शन को असुरक्षित के रूप में चिह्नित करता है, जिससे कॉलर को भी असुरक्षित चिह्नित किए बिना `unsafe` ब्लॉक का उपयोग करने की अनुमति मिलती है।

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

कंपाइल टाइम पर सशर्त कंपाइलेशन। ब्लॉक केवल तब शामिल होता है जब शर्त सत्य हो।

```v
$if debug {
    println('Debug mode enabled')
} $else {
    println('Release mode')
}
```

## कंपाइल-टाइम कोड

V कई कंपाइल-टाइम कंस्ट्रक्ट प्रदान करता है जो कंपाइलेशन के दौरान निष्पादित होते हैं, मेटाप्रोग्रामिंग और शून्य-लागत एब्सट्रैक्शन को सक्षम करते हैं।

### $if

कंपाइल टाइम पर शर्तों का मूल्यांकन करता है। प्लेटफ़ॉर्म डिटेक्शन, आर्किटेक्चर जांच और कस्टम फ़्लैग को सपोर्ट करता है।

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

कंपाइल टाइम पर ऐरे, struct फ़ील्ड्स या रेंज पर पुनरावृत्ति करता है। दोहराए जाने वाले कोड को जनरेट करने के लिए उपयोगी।

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

कंपाइल-टाइम असर्शन जो शर्त गलत होने पर कंपाइलेशन को रोक देते हैं।

```v
$assert sizeof(int) == 8 || sizeof(int) == 4
$assert @VMOD_FILE.len > 0

fn main() {
    println('Assertions passed')
}
```

## ऑपरेटर ओवरलोडिंग

V यूज़र-डिफाइंड टाइप्स पर ऑपरेटर के लिए कस्टम व्यवहार परिभाषित करने की अनुमति देता है। प्रत्येक ऑपरेटर एक विशिष्ट सिग्नेचर वाले मेथड से मैप होता है।

### अंकगणित ऑपरेटर

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

### तुलना ऑपरेटर

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

### इंडेक्स ऑपरेटर

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

## कंपाइल-टाइम रिफ्लेक्शन

V का `$for` कंस्ट्रक्ट कंपाइल टाइम पर struct फ़ील्ड्स पर पुनरावृत्ति कर सकता है, ऑटोमैटिक सीरियलाइज़ेशन, वैलिडेशन आदि को सक्षम करता है।

### struct फ़ील्ड्स पर पुनरावृत्ति

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

### वैलिडेशन कोड जनरेट करना

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

## सारांश

इस अध्याय में, आपने एट्रिब्यूट्स, कंपाइल-टाइम कोड, ऑपरेटर ओवरलोडिंग और कंपाइल-टाइम रिफ्लेक्शन के बारे में सीखा। ये फ़ीचर्स शक्तिशाली मेटाप्रोग्रामिंग पैटर्न और कंपाइलेशन पर सूक्ष्म नियंत्रण को सक्षम करते हैं। अगले अध्याय में, हम मेमोरी मैनेजमेंट को गहराई से जानेंगे।
