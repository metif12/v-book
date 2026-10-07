# Installation

## Windows

### Installer

Download the latest installer from [vlang.io/install](https://vlang.io/install.html) and run it.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### Manual

1. Download the latest release from [GitHub releases](https://github.com/vlang/v/releases).
2. Extract the zip file.
3. Add the `v` directory to your PATH.

## macOS

### Homebrew

```bash
brew install vlang
```

### Installer script

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### Installer script

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## From source

To build V from source, you need a C compiler (gcc or clang):

```bash
git clone https://github.com/vlang/v
cd v
make
```

On Windows, use `win.bat` instead of `make`.

## Verifying

```bash
v version
```

## Next

[Hello, World!](ch01-02-hello-world.md)
