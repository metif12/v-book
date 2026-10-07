# فصل ۱: شروع کار

بیایید سفر V خود را شروع کنید! چیزهای زیادی برای یادگیری وجود دارد، اما هر سفری با یک قدم کوچک شروع می‌شود. در این فصل، یاد می‌گیرید که چگونه:

- V را روی سیستم خود نصب کنید
- یک برنامه "سلام، دنیا!" بنویسید
- از کامپایلر V و دستورهای آن استفاده کنید
- یک پروژه V ایجاد کنید

## نصب

V را می‌توان روی ویندوز، macOS و لینوکس نصب کرد. ساده‌ترین راه استفاده از اسکریپت نصب است:

### ویندوز

نصب‌کننده را از [vlang.io/install](https://vlang.io/install.html) دانلود و اجرا کنید، یا از PowerShell استفاده کنید:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

یا از اسکریپت نصب استفاده کنید:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### لینوکس

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### از سورس

برای ساخت V از سورس:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## تأیید نصب

پس از نصب، بررسی کنید که V کار می‌کند:

```bash
v version
```

خروجی باید به این شکل باشد:

```
V 0.5.2
```

## سلام، دنیا!

حالا بیایید اولین برنامه V خود را بنویسیم. یک فایل به نام `main.v` ایجاد کنید:

```v
fn main() {
    println('Hello, World!')
}
```

آن را اجرا کنید:

```bash
v run main.v
```

خروجی:

```
Hello, World!
```

آفرین! شما اولین برنامه V خود را نوشته و اجرا کرده‌اید.

## سلام، V!

بیایید یک نمونه جالب‌تر را بررسی کنیم:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

آن را اجرا کنید:

```bash
v run main.v
```

خروجی:

```
Hello, V!
V is a great language.
```

## کامپایلر V

کامپایلر V با دستور `v` فراخوانی می‌شود. دستورهای رایج:

| دستور | توضیح |
|---------|-------------|
| `v run file.v` | کامپایل و اجرای یک فایل V |
| `v file.v` | کامپایل یک فایل V به یک فایل اجرایی |
| `v fmt file.v` | قالب‌بندی یک فایل V |
| `v test .` | اجرای تست‌ها در دایرکتوری فعلی |
| `v doc .` | تولید مستندات |
| `v doctor` | تشخیص نصب V |

## خلاصه

در این فصل، یاد گرفتید که چگونه V را نصب کنید، یک برنامه "سلام، دنیا!" بنویسید و از کامپایلر V استفاده کنید. در فصل بعد، به نحوه ساختار یک پروژه V می‌پردازیم.
