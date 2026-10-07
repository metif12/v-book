# Installazione

## Windows

### Installer

Scarica l'installer più recente da [vlang.io/install](https://vlang.io/install.html) ed eseguilo.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### Manuale

1. Scarica l'ultima release da [GitHub releases](https://github.com/vlang/v/releases).
2. Estrai il file zip.
3. Aggiungi la directory `v` al tuo PATH.

## macOS

### Homebrew

```bash
brew install vlang
```

### Script di installazione

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### Script di installazione

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## Dal sorgente

Per compilare V dal sorgente, è necessario un compilatore C (gcc o clang):

```bash
git clone https://github.com/vlang/v
cd v
make
```

Su Windows, usa `win.bat` invece di `make`.

## Verifica

```bash
v version
```

## Avanti

[Ciao, Mondo!](ch01-02-hello-world.md)
