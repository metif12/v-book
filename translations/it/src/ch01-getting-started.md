# Capitolo 1: Per Iniziare

Iniziamo il tuo percorso con V! C'è molto da imparare, ma ogni viaggio inizia con un piccolo passo. In questo capitolo, imparerai come:

- Installare V sul tuo sistema
- Scrivere un programma "Ciao, Mondo!"
- Usare il compilatore V e i suoi comandi
- Creare un progetto V

## Installazione

V può essere installato su Windows, macOS e Linux. Il modo più semplice è usare lo script di installazione:

### Windows

Scarica ed esegui l'installer da [vlang.io/install](https://vlang.io/install.html), oppure usa PowerShell:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

Oppure usa lo script di installazione:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Dal sorgente

Per compilare V dal sorgente:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## Verifica dell'installazione

Dopo l'installazione, verifica che V funzioni:

```bash
v version
```

Dovresti vedere un output come:

```
V 0.5.2
```

## Ciao, Mondo!

Ora scriviamo il nostro primo programma V. Crea un file chiamato `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Eseguilo:

```bash
v run main.v
```

Dovresti vedere:

```
Hello, World!
```

Congratulazioni! Hai scritto ed eseguito il tuo primo programma V.

## Ciao, V!

Vediamo un esempio leggermente più interessante:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Eseguilo:

```bash
v run main.v
```

Output:

```
Hello, V!
V is a great language.
```

## Il compilatore V

Il compilatore V è invocato con il comando `v`. Comandi comuni:

| Comando | Descrizione |
|---------|-------------|
| `v run file.v` | Compila ed esegue un file V |
| `v file.v` | Compila un file V in un eseguibile |
| `v fmt file.v` | Formatta un file V |
| `v test .` | Esegue i test nella directory corrente |
| `v doc .` | Genera la documentazione |
| `v doctor` | Diagnostica l'installazione V |

## Riassunto

In questo capitolo, hai imparato come installare V, scrivere un programma "Ciao, Mondo!" e usare il compilatore V. Nel prossimo capitolo, vedremo come strutturare un progetto V.
