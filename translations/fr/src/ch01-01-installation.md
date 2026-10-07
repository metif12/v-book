# Installation

## Windows

### Programme d'installation

Téléchargez le dernier programme d'installation depuis [vlang.io/install](https://vlang.io/install.html) et exécutez-le.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### Manuelle

1. Téléchargez la dernière version depuis [GitHub releases](https://github.com/vlang/v/releases).
2. Extrayez le fichier zip.
3. Ajoutez le répertoire `v` à votre PATH.

## macOS

### Homebrew

```bash
brew install vlang
```

### Script d'installation

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### Script d'installation

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## Depuis les sources

Pour compiler V depuis les sources, vous avez besoin d'un compilateur C (gcc ou clang) :

```bash
git clone https://github.com/vlang/v
cd v
make
```

Sur Windows, utilisez `win.bat` au lieu de `make`.

## Vérification

```bash
v version
```

## Suivant

[Bonjour, le Monde !](ch01-02-hello-world.md)
