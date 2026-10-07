# التثبيت

## Windows

### المُثبِّت

حمّل أحدث مُثبِّت من [vlang.io/install](https://vlang.io/install.html) وشغّله.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### يدوياً

1. حمّل أحدث إصدار من [إصدارات GitHub](https://github.com/vlang/v/releases).
2. استخرج ملف zip.
3. أضف مجلد `v` إلى مسار PATH الخاص بك.

## macOS

### Homebrew

```bash
brew install vlang
```

### سكربت التثبيت

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### سكربت التثبيت

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## من المصدر

لبناء V من المصدر، تحتاج إلى مُصرِّف C (gcc أو clang):

```bash
git clone https://github.com/vlang/v
cd v
make
```

على Windows، استخدم `win.bat` بدلاً من `make`.

## التحقق

```bash
v version
```

## التالي

[مرحباً، عالم!](ch01-02-hello-world.md)
