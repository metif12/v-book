# انسٹالیشن

## Windows

### انسٹالر

[vlang.io/install](https://vlang.io/install.html) سے تازہ ترین انسٹالر ڈاؤن لوڈ کریں اور چلائیں۔

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### دستی

1. [GitHub releases](https://github.com/vlang/v/releases) سے تازہ ترین رلیز ڈاؤن لوڈ کریں۔
2. zip فائل کو نکالیں۔
3. `v` ڈائریکٹری کو اپنے PATH میں شامل کریں۔

## macOS

### Homebrew

```bash
brew install vlang
```

### انسٹالر اسکرپٹ

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### انسٹالر اسکرپٹ

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## ماخذ سے

ماخذ سے V بنانے کے لیے، آپ کو ایک C کمپائلر (gcc یا clang) کی ضرورت ہے:

```bash
git clone https://github.com/vlang/v
cd v
make
```

Windows پر، `make` کے بجائے `win.bat` استعمال کریں۔

## تصدیق

```bash
v version
```

## اگلا

[ہیلو، ورلڈ!](ch01-02-hello-world.md)
