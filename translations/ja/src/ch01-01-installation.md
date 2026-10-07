# インストール

## Windows

### インストーラー

[vlang.io/install](https://vlang.io/install.html)から最新のインストーラーをダウンロードして実行します。

### PowerShell

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### 手動

1. [GitHub releases](https://github.com/vlang/v/releases)から最新リリースをダウンロードします。
2. zipファイルを展開します。
3. `v`ディレクトリをPATHに追加します。

## macOS

### Homebrew

```bash
brew install vlang
```

### インストーラースクリプト

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

## Linux

### インストーラースクリプト

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Arch Linux

```bash
yay -S vlang
```

## ソースからビルド

ソースからVをビルドするには、Cコンパイラ（gccまたはclang）が必要です：

```bash
git clone https://github.com/vlang/v
cd v
make
```

では、Vのインストールを確認します：

```bash
v version
```

## 次へ

[Hello, World!](ch01-02-hello-world.md)
