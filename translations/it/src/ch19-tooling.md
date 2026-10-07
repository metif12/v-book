# Capitolo 19: Tooling

## v fmt

Formatta il codice sorgente V secondo la guida di stile ufficiale. Usa `-w` per scrivere le modifiche in loco.

```bash
v fmt -w .
```

### Formattare un singolo file

```bash
v fmt -w main.v
```

### Verificare la formattazione senza scrivere

```bash
v fmt -check .
```

## v doc

Genera documentazione dai file sorgente V. Produce HTML per impostazione predefinita.

```bash
v doc .
```

### Documentare un modulo specifico

```bash
v doc -o docs/ .
```

## v profiler

Esegue il profiling dell'esecuzione del programma per identificare colli di bottiglia delle prestazioni.

```bash
v -profile profile.txt run main.v
```

### Analizzare l'output del profile

```bash
v profile profile.txt
```

## v test

Esegue test unitari nella directory corrente o nel file specificato.

```bash
v test .
```

### Eseguire un test specifico

```bash
v test -run TestName .
```

### Eseguire i test con coverage

```bash
v test -cover .
```

## v check

Esegue analisi statica sul codice V, verificando errori, avvisi e problemi di stile.

```bash
v check .
```

### Verificare un singolo file

```bash
v check main.v
```

## Cross-compilazione

V può compilare codice per diversi sistemi operativi e architetture da una singola macchina.

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### Specificare l'architettura

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### Cross-compilare per target embedded

```bash
v -os embedded -arch arm main.v
```

## v doctor

Mostra informazioni diagnostiche sull'installazione V, inclusi versione del compilatore, OS e configurazione.

```bash
v doctor
```

## v up

Aggiorna il compilatore V all'ultima versione.

```bash
v up
```

### Aggiornare a una versione specifica

```bash
v up --version 0.5.2
```

## Riassunto

In questo capitolo, hai imparato l'ecosistema di tooling di V: `v fmt` per la formattazione, `v doc` per la documentazione, `v profiler` per l'analisi delle prestazioni, `v test` per il testing, `v check` per l'analisi statica, la cross-compilazione, `v doctor` per la diagnostica e `v up` per l'auto-aggiornamento. Nel prossimo capitolo, costruiremo un progetto finale.
