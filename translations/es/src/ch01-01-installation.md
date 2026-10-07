# Instalación

## Windows

### Instalador

Descarga el instalador más reciente desde [vlang.io/install](https://vlang.io/install.html) y ejecútalo.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### Manual

1. Descarga la versión más reciente desde [GitHub releases](https://github.com/vlang/v/releases).
2. Extrae el archivo zip.
3. Agrega el directorio `v` a tu PATH.

## macOS

### Homebrew

```bash
brew install vlang
```

### Script de instalación

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### Script de instalación

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## Desde el código fuente

Para compilar V desde el código fuente, necesitas un compilador de C (gcc o clang):

```bash
git clone https://github.com/vlang/v
cd v
make
```

En Windows, usa `win.bat` en lugar de `make`.

## Verificación

```bash
v version
```

## Siguiente

[¡Hola, Mundo!](ch01-02-hello-world.md)
