# Appendix F: Translations

This book is available in 16 languages. The English source is canonical: every
other language is a tree of Markdown that mirrors `src/` and is built from the
same table of contents.

| Code | Language | Direction | Status |
|------|----------|-----------|--------|
| en | English | LTR | Complete (canonical) |
| de | Deutsch | LTR | Complete |
| es | Español | LTR | Complete |
| fr | Français | LTR | Complete |
| zh | 简体中文 | LTR | Complete |
| ru | Русский | LTR | Complete |
| ja | 日本語 | LTR | Complete |
| ko | 한국어 | LTR | Complete |
| pt | Português | LTR | Complete |
| it | Italiano | LTR | Complete |
| ar | العربية | RTL | Complete |
| fa | فارسی | RTL | Complete |
| hi | हिन्दी | LTR | Complete |
| bn | বাংলা | LTR | Complete |
| ur | اردو | RTL | Complete |
| id | Bahasa Indonesia | LTR | Complete |
| tr | Türkçe | LTR | Complete |

The three right-to-left languages are the ones to watch when changing the site's
shell: `book.css` carries the RTL rules, and the page's `dir` attribute is what
switches the sidebar, the pager and the reading column.

## Pages that are still English

A lesson whose English source was rewritten leaves the translation describing a
command that no longer exists, so those lessons ship in English in every
language until a translator redoes them. The language menu still links to them
and the pager still walks through them:

| Page | Status |
|------|--------|
| Chapter 1: Getting Started | English after the install rewrite |
| Installation | English after the install rewrite |
| Chapter 2: Formatting with v fmt | English after the `v fmt` review |
| Chapter 7: VPM | English after the toolchain review |
| Chapter 11: Testing | English after the testing review |
| Chapter 19: Tooling | English after the toolchain review |
| Chapter 21: Cross-Compilation and Deployment | new |
| Chapter 22: Performance and Benchmarking | new |
| Appendix H: Exercises | new |

Everything else keeps its translation. The V code blocks inside a translation
always come from the English source, so no language can show code CI does not
compile.

## Building one language

Each language is a directory of the same shape:

```
translations/zh/src/SUMMARY.md
translations/zh/src/ch00-introduction.md
translations/zh/src/ch01-getting-started.md
```

`SUMMARY.md` drives the build: a page that is not in it is not in that
language's site. `tools/validate.vsh` checks that every translation lists every
page the English source lists, and reports the ones that do not.

```bash
v run tools/validate.vsh   # lists the pages a translation is missing
v run site                 # builds every language into dist/
```

## Contributing

See [translations/README.md](../translations/README.md) for how to contribute a translation.
