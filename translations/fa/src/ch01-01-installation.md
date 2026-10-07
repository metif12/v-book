# نصب

## ویندوز

### نصب‌کننده

آخرین نصب‌کننده را از [vlang.io/install](https://vlang.io/install.html) دانلود و اجرا کنید.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### دستی

1. آخرین نسخه را از [نسخه‌های GitHub](https://github.com/vlang/v/releases) دانلود کنید.
2. فایل zip را استخراج کنید.
3. دایرکتوری `v` را به PATH خود اضافه کنید.

## macOS

### Homebrew

```bash
brew install vlang
```

### اسکریپت نصب

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## لینوکس

### اسکریپت نصب

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### آرچ لینوکس

```bash
yay -S vlang
```

## از سورس

برای ساخت V از سورس، به یک کامپایلر C (gcc یا clang) نیاز دارید:

```bash
git clone https://github.com/vlang/v
cd v
make
```

در ویندوز، به جای `make` از `win.bat` استفاده کنید.

## تأیید

```bash
v version
```

## بعدی

[سلام، دنیا!](ch01-02-hello-world.md)
