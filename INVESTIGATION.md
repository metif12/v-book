# Investigation Results

## Existing V Resources

### tour-of-v
- **Path**: `D:\MyProjects\tour-of-v\`
- **Description**: Interactive tour of V, modelled on "A Tour of Go"
- **Features**: 8 lessons, 61 pages, 66 examples, 16 locales
- **Architecture**: V-native, content compiled into binary, veb-served
- **Code execution**: Sandboxed with ioi/isolate (Linux namespaces, cgroups, seccomp)
- **i18n**: 16 locale files (en, zh, hi, es, fa, ar, fr, bn, pt, ru, ur, id, de, ja, tr, ko)
- **RTL support**: fa, ar, ur

### vlang-website
- **Path**: `D:\MyProjects\vlang-website\`
- **Description**: Official vlang.io website
- **Translations**: 10 languages (en, ru, es, fr, ja, zh, tr, pt-br, fa)

### V Documentation
- **URL**: https://docs.vlang.io
- **Source**: `vlang/v` repo, `doc/docs.md` (11,350 lines)
- **Format**: Single-page HTML, not book-format

### Published Books
- **"Getting Started with V Programming"** (Packt, 2021) — Outdated (V 0.2/0.3 era)
- **"Randomness Revisited"** (Nova) — Specialized academic focus

## Rust Book Analysis

### Structure
- 21 chapters + 7 appendices
- Progressive learning path
- Two capstone projects (CLI tool, web server)

### Code Testing
- `mdbook test` compiles and runs all code blocks
- Custom `trpl` crate for shared library code
- Listings extracted to `listings/` directory
- CI runs `mdbook test` + `cargo test` on tools

### Translations
- 25+ languages
- Separate GitHub repos per language
- Community-driven coordination
- Appendix F indexes all translations

### Tooling
- mdBook v0.5.1
- 4 custom preprocessors (notes, listings, headings, figures)
- Ferris the crab mascot
- Graphviz diagrams

## Key Findings

### What exists
- Comprehensive V documentation (docs.vlang.io)
- Interactive tour (tour-of-v) with 16 locales
- Active V community (GitHub, Discord, Telegram)

### What's missing
- Comprehensive book-format tutorial for V 0.4/0.5
- Tested code examples in a book format
- 16-language translations of a comprehensive V book
- Rust Book-quality resource for V

### Opportunities
- Leverage tour-of-v's i18n patterns and locale list
- Follow Rust Book's proven structure and tooling
- Build on V's existing documentation
- Community-driven translation model

## Technical Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Book format | mdBook | Rust Book standard, familiar, good i18n |
| Code testing | Custom `mdbook-v-test` | Follows Rust Book's `mdbook test` pattern |
| Code storage | `listings/` directory | Separates code from prose, enables testing |
| Translation model | Directory-per-language | Simple, works with mdBook i18n |
| Content language | English canonical | Matches Rust Book, easiest to maintain |
| License | MIT | Matches V and tour-of-v |
| RTL support | CSS `direction: rtl` | Proven pattern from tour-of-v |

## Language Selection (16 languages)

Based on tour-of-v's existing locales and world's largest languages by speakers:

1. English (en) — canonical
2. Chinese Simplified (zh) — 1.1B speakers
3. Hindi (hi) — 600M speakers
4. Spanish (es) — 550M speakers
5. Persian/Farsi (fa) — 110M speakers, RTL
6. Arabic (ar) — 420M speakers, RTL
7. French (fr) — 300M speakers
8. Bengali (bn) — 270M speakers
9. Portuguese (pt) — 260M speakers
10. Russian (ru) — 260M speakers
11. Urdu (ur) — 230M speakers, RTL
12. Indonesian (id) — 200M speakers
13. German (de) — 130M speakers
14. Japanese (ja) — 125M speakers
15. Turkish (tr) — 85M speakers
16. Korean (ko) — 80M speakers

## References

- [The Rust Book](https://doc.rust-lang.org/book/)
- [rust-lang/book](https://github.com/rust-lang/book)
- [tour-of-v](https://github.com/vlang/tour-of-v)
- [V Documentation](https://docs.vlang.io)
- [vlang.io](https://vlang.io)
- [mdBook](https://rust-lang.github.io/mdBook/)
