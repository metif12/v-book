# 설치

## Windows

### 인스톨러

[vlang.io/install](https://vlang.io/install.html)에서 최신 인스톨러를 다운로드하여 실행하세요.

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### 수동 설치

1. [GitHub releases](https://github.com/vlang/v/releases)에서 최신 릴리스를 다운로드하세요.
2. zip 파일을 압축 해제하세요.
3. `v` 디렉터리를 PATH에 추가하세요.

## macOS

### Homebrew

```bash
brew install vlang
```

### 인스톨러 스크립트

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### 인스톨러 스크립트

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## 소스에서 빌드

소스에서 V를 빌드하려면 C 컴파일러(gcc 또는 clang)가 필요합니다:

```bash
git clone https://github.com/vlang/v
cd v
make
```

Windows에서는 `make` 대신 `win.bat`을 사용하세요.

## 설치 확인

```bash
v version
```

## 다음

[Hello, World!](ch01-02-hello-world.md)
