# Instalasi

## Windows

### Installer

Unduh installer terbaru dari [vlang.io/install](https://vlang.io/install.html) dan jalankan.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### Manual

1. Unduh rilis terbaru dari [GitHub releases](https://github.com/vlang/v/releases).
2. Ekstrak file zip.
3. Tambahkan direktori `v` ke PATH Anda.

## macOS

### Homebrew

```bash
brew install vlang
```

### Skrip installer

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### Skrip installer

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## Dari sumber

Untuk membangun V dari sumber, Anda memerlukan kompiler C (gcc atau clang):

```bash
git clone https://github.com/vlang/v
cd v
make
```

Di Windows, gunakan `win.bat` sebagai ganti `make`.

## Memverifikasi

```bash
v version
```

## Berikutnya

[Hello, World!](ch01-02-hello-world.md)
