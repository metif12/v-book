# Chapitre 1 : Premiers pas

Commençons votre parcours V ! Il y a beaucoup à apprendre, mais chaque voyage commence par un petit pas. Dans ce chapitre, vous apprendrez à :

- Installer V sur votre système
- Écrire un programme « Bonjour, le Monde ! »
- Utiliser le compilateur V et ses commandes
- Créer un projet V

## Installation

V peut être installé sur Windows, macOS et Linux. La méthode la plus simple est d'utiliser le script d'installation :

### Windows

Téléchargez et exécutez le programme d'installation depuis [vlang.io/install](https://vlang.io/install.html), ou utilisez PowerShell :

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

Ou utilisez le script d'installation :

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Depuis les sources

Pour compiler V depuis les sources :

```bash
git clone https://github.com/vlang/v
cd v
make
```

## Vérifier l'installation

Après l'installation, vérifiez que V fonctionne :

```bash
v version
```

Vous devriez voir une sortie comme :

```
V 0.5.2
```

## Bonjour, le Monde !

Écrivons maintenant notre premier programme V. Créez un fichier appelé `main.v` :

```v
fn main() {
    println('Hello, World!')
}
```

Exécutez-le :

```bash
v run main.v
```

Vous devriez voir :

```
Hello, World!
```

Félicitations ! Vous avez écrit et exécuté votre premier programme V.

## Bonjour, V !

Regardons un exemple un peu plus intéressant :

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Exécutez-le :

```bash
v run main.v
```

Sortie :

```
Hello, V!
V is a great language.
```

## Le compilateur V

Le compilateur V est invoqué avec la commande `v`. Commandes courantes :

| Commande | Description |
|---------|-------------|
| `v run file.v` | Compiler et exécuter un fichier V |
| `v file.v` | Compiler un fichier V en exécutable |
| `v fmt file.v` | Formater un fichier V |
| `v test .` | Exécuter les tests dans le répertoire courant |
| `v doc .` | Générer la documentation |
| `v doctor` | Diagnostiquer votre installation V |

## Résumé

Dans ce chapitre, vous avez appris à installer V, à écrire un programme « Bonjour, le Monde ! » et à utiliser le compilateur V. Dans le chapitre suivant, nous verrons comment structurer un projet V.
