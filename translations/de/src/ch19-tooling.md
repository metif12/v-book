# Kapitel 19: Tooling

## v fmt

Formatiert V-Quellcode nach dem offiziellen Stilhandbuch. Verwenden Sie `-w`, um Änderungen direkt zu schreiben.

```bash
v fmt -w .
```

### Eine einzelne Datei formatieren

```bash
v fmt -w main.v
```

### Formatierung prüfen ohne zu schreiben

```bash
v fmt -check .
```

## v doc

Generiert Dokumentation aus V-Quellcodedateien. Gibt standardmäßig HTML aus.

```bash
v doc .
```

### Ein bestimmtes Modul dokumentieren

```bash
v doc -o docs/ .
```

## v profiler

Erstellt ein Profil der Programmausführung, um Leistungsengpässe zu identifizieren.

```bash
v -profile profile.txt run main.v
```

### Profilausgabe analysieren

```bash
v profile profile.txt
```

## v test

Führt Unit-Tests im aktuellen Verzeichnis oder in einer angegebenen Datei aus.

```bash
v test .
```

### Einen bestimmten Test ausführen

```bash
v test -run TestName .
```

### Tests mit Coverage ausführen

```bash
v test -cover .
```

## v check

Führt statische Analyse von V-Code durch und prüft auf Fehler, Warnungen und Stilprobleme.

```bash
v check .
```

### Eine einzelne Datei prüfen

```bash
v check main.v
```

## Cross-Kompilierung

V kann Code von einem einzigen Rechner aus für verschiedene Betriebssysteme und Architekturen kompilieren.

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### Architektur angeben

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### Cross-Kompilierung für eingebettete Ziele

```bash
v -os embedded -arch arm main.v
```

## v doctor

Zeigt Diagnoseinformationen über die V-Installation an, einschließlich Compiler-Version, Betriebssystem und Konfiguration.

```bash
v doctor
```

## v up

Aktualisiert den V-Compiler auf die neueste Version.

```bash
v up
```

### Auf eine bestimmte Version aktualisieren

```bash
v up --version 0.5.2
```

## Zusammenfassung

In diesem Kapitel haben Sie das Tooling-Ökosystem von V kennengelernt: `v fmt` für Formatierung, `v doc` für Dokumentation, `v profiler` für Leistungsanalyse, `v test` für Testen, `v check` für statische Analyse, Cross-Kompilierung, `v doctor` für Diagnostik und `v up` für Selbstaktualisierung. Im nächsten Kapitel bauen wir ein Abschlussprojekt.
