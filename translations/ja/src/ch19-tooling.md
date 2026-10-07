# 第19章：ツール

## v fmt

Vのソースコードを公式スタイルガイドに従ってフォーマットします。`-w`を使用して変更をその場に書き込みます。

```bash
v fmt -w .
```

### 単一ファイルのフォーマット

```bash
v fmt -w main.v
```

### 書き込みなしでフォーマットを確認

```bash
v fmt -check .
```

## v doc

Vのソースファイルからドキュメントを生成します。デフォルトでHTMLを出力します。

```bash
v doc .
```

### 特定のモジュールのドキュメント化

```bash
v doc -o docs/ .
```

## v profiler

プログラムの実行をプロファイリングし、パフォーマンスのボトルネックを特定します。

```bash
v -profile profile.txt run main.v
```

### プロファイル出力の分析

```bash
v profile profile.txt
```

## v test

現在のディレクトリまたは指定されたファイルでユニットテストを実行します。

```bash
v test .
```

### 特定のテストの実行

```bash
v test -run TestName .
```

### カバレッジ付きでテストを実行

```bash
v test -cover .
```

## v check

Vコードに対して静的解析を実行し、エラー、警告、スタイルの問題を確認します。

```bash
v check .
```

### 単一ファイルのチェック

```bash
v check main.v
```

## クロスコンパイル

Vは1つのマシンから異なるオペレーティングシステムとアーキテクチャ用にコードをコンパイルできます。

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### アーキテクチャの指定

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### 組み込みターゲット用クロスコンパイル

```bash
v -os embedded -arch arm main.v
```

## v doctor

コンパイラバージョン、OS、設定を含むVのインストールに関する診断情報を表示します。

```bash
v doctor
```

## v up

Vコンパイラを最新バージョンに更新します。

```bash
v up
```

### 特定のバージョンに更新

```bash
v up --version 0.5.2
```

## まとめ

この章では、Vのツールエコシステムについて学びました：`v fmt`（フォーマット）、`v doc`（ドキュメント）、`v profiler`（パフォーマンス分析）、`v test`（テスト）、`v check`（静的解析）、クロスコンパイル、`v doctor`（診断）、`v up`（自己更新）。次の章では、最終プロジェクトを構築します。
