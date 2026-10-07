# Kapitel 1: Erste Schritte

Beginnen Sie Ihre V-Reise! Es gibt viel zu lernen, aber jede Reise beginnt mit einem kleinen Schritt. In diesem Kapitel lernen Sie, wie Sie:

- V auf Ihrem System installieren
- Ein "Hallo, Welt!"-Programm schreiben
- Den V-Compiler und seine Befehle verwenden
- Ein V-Projekt erstellen

## Installation

V kann auf Windows, macOS und Linux installiert werden. Der einfachste Weg ist die Verwendung des Installationsskripts:

### Windows

Laden Sie den Installer von [vlang.io/install](https://vlang.io/install.html) herunter und führen Sie ihn aus, oder verwenden Sie PowerShell:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

Oder verwenden Sie das Installationsskript:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Aus dem Quellcode

Um V aus dem Quellcode zu kompilieren:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## Installation überprüfen

Nach der Installation überprüfen Sie, ob V funktioniert:

```bash
v version
```

Sie sollten eine Ausgabe wie folgt sehen:

```
V 0.5.2
```

## Hallo, Welt!

Nun schreiben wir unser erstes V-Programm. Erstellen Sie eine Datei namens `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Führen Sie es aus:

```bash
v run main.v
```

Sie sollten folgendes sehen:

```
Hello, World!
```

Herzlichen Glückwunsch! Sie haben Ihr erstes V-Programm geschrieben und ausgeführt.

## Hallo, V!

Betrachten wir ein etwas interessanteres Beispiel:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Führen Sie es aus:

```bash
v run main.v
```

Ausgabe:

```
Hello, V!
V is a great language.
```

## Der V-Compiler

Der V-Compiler wird mit dem Befehl `v` aufgerufen. Häufige Befehle:

| Befehl | Beschreibung |
|---------|-------------|
| `v run file.v` | Eine V-Datei kompilieren und ausführen |
| `v file.v` | Eine V-Datei zu einer ausführbaren Datei kompilieren |
| `v fmt file.v` | Eine V-Datei formatieren |
| `v test .` | Tests im aktuellen Verzeichnis ausführen |
| `v doc .` | Dokumentation generieren |
| `v doctor` | Ihre V-Installation diagnostizieren |

## Zusammenfassung

In diesem Kapitel haben Sie gelernt, wie Sie V installieren, ein "Hallo, Welt!"-Programm schreiben und den V-Compiler verwenden. Im nächsten Kapitel werden wir uns ansehen, wie man ein V-Projekt strukturiert.
