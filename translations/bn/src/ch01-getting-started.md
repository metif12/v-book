# অধ্যায় 1: শুরু করা

আসুন আপনার V যাত্রা শুরু করি! শিখতে অনেক কিছু আছে, কিন্তু প্রতিটি যাত্রা একটি ছোট পদক্ষেপ দিয়ে শুরু হয়। এই অধ্যায়ে আপনি শিখবেন কীভাবে:

- আপনার সিস্টেমে V ইনস্টল করতে হয়
- একটি "Hello, World!" প্রোগ্রাম লিখতে হয়
- V কম্পাইলার এবং এর কমান্ড ব্যবহার করতে হয়
- একটি V প্রজেক্ট তৈরি করতে হয়

## ইনস্টলেশন

V ইনস্টল করা যায় Windows, macOS এবং Linux-এ। সবচেয়ে সহজ উপায় হল ইনস্টলার স্ক্রিপ্ট ব্যবহার করা:

### Windows

[vlang.io/install](https://vlang.io/install.html) থেকে ইনস্টলার ডাউনলোড করে চালান, অথবা PowerShell ব্যবহার করুন:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

অথবা ইনস্টলার স্ক্রিপ্ট ব্যবহার করুন:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### সোর্স থেকে

সোর্স থেকে V বিল্ড করতে:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## ইনস্টলেশন যাচাই

ইনস্টলেশনের পর, V ঠিকভাবে কাজ করছে কিনা যাচাই করুন:

```bash
v version
```

আপনাকে এমন আউটপুট দেখতে হবে:

```
V 0.5.2
```

## Hello, World!

এখন আসুন আমাদের প্রথম V প্রোগ্রাম লিখি। `main.v` নামে একটি ফাইল তৈরি করুন:

```v
fn main() {
    println('Hello, World!')
}
```

চালান:

```bash
v run main.v
```

আপনাকে দেখতে হবে:

```
Hello, World!
```

অভিনন্দন! আপনি আপনার প্রথম V প্রোগ্রাম লিখেছেন এবং চালিয়েছেন।

## Hello, V!

আসুন একটু বেশি আকর্ষণীয় উদাহরণ দেখি:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

চালান:

```bash
v run main.v
```

আউটপুট:

```
Hello, V!
V is a great language.
```

## V কম্পাইলার

V কম্পাইলার `v` কমান্ড দিয়ে চালানো হয়। সাধারণ কমান্ড:

| কমান্ড | বিবরণ |
|---------|-------------|
| `v run file.v` | একটি V ফাইল কম্পাইল করে চালায় |
| `v file.v` | একটি V ফাইল কম্পাইল করে এক্সিকিউটেবল তৈরি করে |
| `v fmt file.v` | একটি V ফাইল ফরম্যাট করে |
| `v test .` | বর্তমান ডিরেক্টরিতে টেস্ট চালায় |
| `v doc .` | ডকুমেন্টেশন তৈরি করে |
| `v doctor` | আপনার V ইনস্টলেশন নির্ণয় করে |

## সারসংক্ষেপ

এই অধ্যায়ে আপনি শিখেছেন কীভাবে V ইনস্টল করতে হয়, একটি "Hello, World!" প্রোগ্রাম লিখতে হয় এবং V কম্পাইলার ব্যবহার করতে হয়। পরবর্তী অধ্যায়ে আমরা দেখব কীভাবে একটি V প্রজেক্ট সাজাতে হয়।
