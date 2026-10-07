# Instalação

## Windows

### Instalador

Baixe o instalador mais recente de [vlang.io/install](https://vlang.io/install.html) e execute-o.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### Manual

1. Baixe a versão mais recente em [GitHub releases](https://github.com/vlang/v/releases).
2. Extraia o arquivo zip.
3. Adicione o diretório `v` ao seu PATH.

## macOS

### Homebrew

```bash
brew install vlang
```

### Script de instalação

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### Script de instalação

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## A partir do código-fonte

Para compilar V a partir do código-fonte, você precisa de um compilador C (gcc ou clang):

```bash
git clone https://github.com/vlang/v
cd v
make
```

No Windows, use `win.bat` em vez de `make`.

## Verificando

```bash
v version
```

## Próximo

[Olá, Mundo!](ch01-02-hello-world.md)
