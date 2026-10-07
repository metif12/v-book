# Установка

## Windows

### Установщик

Скачайте последний установщик с [vlang.io/install](https://vlang.io/install.html) и запустите его.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### Вручную

1. Скачайте последний релиз со [страницы релизов GitHub](https://github.com/vlang/v/releases).
2. Распакуйте zip-файл.
3. Добавьте каталог `v` в переменную окружения PATH.

## macOS

### Homebrew

```bash
brew install vlang
```

### Установочный скрипт

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### Установочный скрипт

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## Из исходного кода

Чтобы собрать V из исходного кода, вам нужен компилятор C (gcc или clang):

```bash
git clone https://github.com/vlang/v
cd v
make
```

На Windows используйте `win.bat` вместо `make`.

## Проверка

```bash
v version
```

## Далее

[Привет, мир!](ch01-02-hello-world.md)
