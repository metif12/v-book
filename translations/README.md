# Translations

This directory contains translations of The V Programming Language Book.

## Available translations

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

## Quick start for translators

```bash
# 1. Create a new locale directory
v run scripts/new_locale.vsh <code> <english-name> <native-name> [--rtl]

# 2. Copy the English source
cp -r src/ translations/<code>/src/

# 3. Translate SUMMARY.md first, then chapters progressively

# 4. Build and verify
cd translations/<code>
mdbook build
```

## Translation workflow

1. **Start with `SUMMARY.md`** — translate chapter titles and structure.
2. **Translate chapters progressively** — untranslated chapters fall back to English automatically.
3. **Code blocks are never translated** — only prose around them.
4. **Keep V syntax intact** — keywords, `${...}` interpolation, and code stay as-is.
5. **Test your translation** — `cd translations/<code> && mdbook build`

## File structure per translation

```
translations/<code>/
├── book.toml          # Per-locale mdBook config
├── SUMMARY.md         # Translated table of contents
└── src/               # Translated Markdown files
    ├── ch00-introduction.md
    ├── ch01-getting-started.md
    └── ...
```

## Guidelines

- Use `v ignore` for code blocks that are pseudocode or incomplete.
- Use `v no_run` for examples that would block (e.g., waiting for input).
- Keep the same file structure as `src/` — only translate the prose.
- Do not modify code examples unless fixing bugs.
- Run `v run tools/mdbook-v-test .` from the repo root to verify code blocks still compile.

## RTL languages

For RTL languages (fa, ar, ur), pass `--rtl` when creating the locale:

```bash
v run scripts/new_locale.vsh fa Persian فارسی --rtl
```

This sets `dir="rtl"` in the page template.
