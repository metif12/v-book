# The V Programming Language Book

A comprehensive book for the [V programming language](https://vlang.io), inspired by [The Rust Book](https://doc.rust-lang.org/book/).

## Project Goals

- **Comprehensive**: Cover V from installation to advanced topics
- **Tested**: Every code example compiled and run in CI
- **Accessible**: Available in 16 languages including Farsi (fa), Arabic (ar), and Urdu (ur)
- **Community-driven**: Open to contributions from the V community
- **Modern**: Targets V 0.5.2+

## Current Status

| Component | Status |
|-----------|--------|
| Project structure | Complete |
| Theme/CSS | Complete |
| CI pipeline | Complete |
| Code testing preprocessor | Complete |
| Chapters 0-12 | Written |
| Chapters 13-20 | Written |
| Appendices A-G | Written |
| Translations (15 languages) | Infrastructure ready, content TODO |

## Quick Start

### Prerequisites

- [V](https://vlang.io) 0.5.2+
- [mdBook](https://rust-lang.github.io/mdBook/) 0.4.40+

### Build

```bash
mdbook build
```

### Test code examples

```bash
v run tools/mdbook-v-test .
```

### Run tests

```bash
v test .
```

## Project Structure

```
v-book/
├── src/                    # Markdown source (English, canonical)
│   ├── SUMMARY.md
│   ├── ch00-introduction.md
│   ├── ch01-getting-started.md
│   ├── ...
│   └── appendix-g-how-v-is-made.md
├── listings/               # V code examples
│   ├── ch01-hello-world/
│   ├── ch01-hello-v/
│   └── ...
├── theme/                  # CSS, JS, templates
│   ├── index.hbs
│   ├── favicon.svg
│   ├── css/
│   └── js/
├── tools/
│   └── mdbook-v-test/      # Custom preprocessor for code testing
├── translations/           # 16 language translations
│   ├── README.md
│   ├── zh/
│   ├── fa/
│   └── ...
├── ci/                     # CI scripts
├── scripts/                # Scaffolding scripts
│   ├── new_chapter.vsh
│   └── new_locale.vsh
├── .github/workflows/
│   └── main.yml
├── book.toml               # mdBook config
├── v.mod                   # V module
└── CONTRIBUTING.md
```

## Chapters

### Part I: Getting Started
- **Chapter 0**: Introduction
- **Chapter 1**: Getting Started (Installation, Hello World, Hello V)
- **Chapter 2**: Building a Project (v.mod, v fmt, v test)

### Part II: Common Programming Concepts
- **Chapter 3**: Common Concepts (variables, types, functions, control flow)
- **Chapter 4**: Ownership and Memory (stack/heap, GC, autofree, references)
- **Chapter 5**: Structs (definition, methods, embedding, access modifiers)
- **Chapter 6**: Enums and Sum Types (enums, sum types, pattern matching)
- **Chapter 7**: Modules and Packages (module system, visibility, VPM)
- **Chapter 8**: Collections (arrays, maps, strings)
- **Chapter 9**: Error Handling (Option, Result, custom errors)

### Part III: Intermediate V
- **Chapter 10**: Generics
- **Chapter 11**: Testing
- **Chapter 12**: I/O Project (CLI tool capstone)
- **Chapter 13**: Functional Features (closures, higher-order functions)
- **Chapter 14**: Concurrency (goroutines, channels, shared state)
- **Chapter 15**: Veb Web Framework
- **Chapter 16**: C Interop
- **Chapter 17**: Advanced Features (attributes, comptime, operator overloading)
- **Chapter 18**: Memory Management Deep Dive
- **Chapter 19**: Tooling
- **Chapter 20**: Final Project (web application capstone)

### Appendices
- **Appendix A**: Keywords
- **Appendix B**: Operators
- **Appendix C**: V Syntax Reference
- **Appendix D**: Standard Library Overview
- **Appendix E**: V and C Interop Reference
- **Appendix F**: Translations
- **Appendix G**: How V is Made

## Translations

This book is available in 16 languages:

| Code | Language | Status |
|------|----------|--------|
| en | English | Complete (canonical) |
| zh | 简体中文 | TODO |
| hi | हिन्दी | TODO |
| es | Español | TODO |
| fa | فارسی | TODO |
| ar | العربية | TODO |
| fr | Français | TODO |
| bn | বাংলা | TODO |
| pt | Português | TODO |
| ru | Русский | TODO |
| ur | اردو | TODO |
| id | Bahasa Indonesia | TODO |
| de | Deutsch | TODO |
| ja | 日本語 | TODO |
| tr | Türkçe | TODO |
| ko | 한국어 | TODO |

See [translations/README.md](translations/README.md) for how to contribute.

## Code Examples

Code examples follow these conventions:

- `v` — compiled and run in CI
- `v ignore` — not compiled (pseudocode, incomplete examples)
- `v no_run` — compiled but not run (blocking examples)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT
