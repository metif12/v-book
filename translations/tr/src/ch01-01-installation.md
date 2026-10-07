# Kurulum

## Windows

### Kurulum programı

[vlang.io/install](https://vlang.io/install.html) adresinden en güncel kurulum programını indirin ve çalıştırın.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### Manuel

1. [GitHub releases](https://github.com/vlang/v/releases) adresinden en güncel sürümü indirin.
2. Zip dosyasını çıkarın.
3. `v` dizinini PATH'inize ekleyin.

## macOS

### Homebrew

```bash
brew install vlang
```

### Kurulum betiği

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### Kurulum betiği

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## Kaynak koddan

V'yi kaynak koddan derlemek için bir C derleyicisine (gcc veya clang) ihtiyacınız var:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## Doğrulama

```bash
v version
```

## Sonraki

[Merhaba, Dünya!](ch01-02-hello-world.md)
