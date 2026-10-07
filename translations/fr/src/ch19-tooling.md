# Chapitre 19 : Outillage

## v fmt

Formate le code source V selon le guide de style officiel. Utilisez `-w` pour écrire les modifications en place.

```bash
v fmt -w .
```

### Formater un seul fichier

```bash
v fmt -w main.v
```

### Vérifier le formatage sans écrire

```bash
v fmt -check .
```

## v doc

Génère la documentation à partir des fichiers source V. Produit du HTML par défaut.

```bash
v doc .
```

### Documenter un module spécifique

```bash
v doc -o docs/ .
```

## v profiler

Profile l'exécution du programme pour identifier les goulots d'étranglement de performance.

```bash
v -profile profile.txt run main.v
```

### Analyser la sortie du profile

```bash
v profile profile.txt
```

## v test

Exécute les tests unitaires dans le répertoire courant ou le fichier spécifié.

```bash
v test .
```

### Exécuter un test spécifique

```bash
v test -run TestName .
```

### Exécuter les tests avec couverture

```bash
v test -cover .
```

## v check

Effectue une analyse statique du code V, vérifiant les erreurs, les avertissements et les problèmes de style.

```bash
v check .
```

### Vérifier un seul fichier

```bash
v check main.v
```

## Compilation croisée

V peut compiler du code pour différents systèmes d'exploitation et architectures depuis une seule machine.

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### Spécifier l'architecture

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### Compilation croisée pour cibles embarquées

```bash
v -os embedded -arch arm main.v
```

## v doctor

Affiche les informations de diagnostic sur l'installation V, y compris la version du compilateur, le système d'exploitation et la configuration.

```bash
v doctor
```

## v up

Met à jour le compilateur V vers la dernière version.

```bash
v up
```

### Mettre à jour vers une version spécifique

```bash
v up --version 0.5.2
```

## Résumé

Dans ce chapitre, vous avez appris l'écosystème d'outillage de V : `v fmt` pour le formatage, `v doc` pour la documentation, `v profiler` pour l'analyse de performance, `v test` pour les tests, `v check` pour l'analyse statique, la compilation croisée, `v doctor` pour les diagnostics et `v up` pour les auto-mises à jour. Dans le chapitre suivant, nous créerons un projet final.
