# ইনস্টলেশন

## Windows

### ইনস্টলার

[vlang.io/install](https://vlang.io/install.html) থেকে সর্বশেষ ইনস্টলার ডাউনলোড করে চালান।

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### ম্যানুয়াল

1. [GitHub releases](https://github.com/vlang/v/releases) থেকে সর্বশেষ রিলিজ ডাউনলোড করুন।
2. zip ফাইল এক্সট্রাক্ট করুন।
3. আপনার PATH-এ `v` ডিরেক্টরি যোগ করুন।

## macOS

### Homebrew

```bash
brew install vlang
```

### ইনস্টলার স্ক্রিপ্ট

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### ইনস্টলার স্ক্রিপ্ট

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## সোর্স থেকে

সোর্স থেকে V বিল্ড করতে আপনাকে একটি C কম্পাইলার (gcc বা clang) প্রয়োজন:

```bash
git clone https://github.com/vlang/v
cd v
make
```

Windows-এ `make` এর বদলে `win.bat` ব্যবহার করুন।

## যাচাই

```bash
v version
```

## পরবর্তী

[Hello, World!](ch01-02-hello-world.md)
