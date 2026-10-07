# Installation

## Windows

### Installer

Laden Sie den neuesten Installer von [vlang.io/install](https://vlang.io/install.html) herunter und führen Sie ihn aus.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### Manuell

1. Laden Sie die neueste Version von [GitHub Releases](https://github.com/vlang/v/releases) herunter.
2. Entpacken Sie die ZIP-Datei.
3. Fügen Sie das `v`-Verzeichnis zu Ihrem PATH hinzu.

## macOS

### Homebrew

```bash
brew install vlang
```

### Installationsskript

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### Installationsskript

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## Aus dem Quellcode

Um V aus dem Quellcode zu kompilieren, benötigen Sie einen C-Compiler (gcc oder clang):

```bash
git clone https://github.com/vlang/v
cd v
make
```

Unter Windows verwenden Sie statt `make` die Datei `win.bat`.

## Überprüfung

```bash
v version
```

## Weiter

[Hallo, Welt!](ch01-02-hello-world.md)
