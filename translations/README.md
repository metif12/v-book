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

## How to contribute

1. Create a new locale directory:

```bash
v run scripts/new_locale.vsh <code> <english-name> <native-name> [--rtl]
```

2. Copy the English source:

```bash
cp -r src/ translations/<code>/src/
```

3. Translate `SUMMARY.md` first, then chapters progressively.

4. Untranslated chapters fall back to English automatically.

## Translation guidelines

- Code blocks are never translated — only prose.
- Keep `${...}` interpolation syntax intact.
- Keep V keywords and syntax as-is.
- Use `v ignore` for code blocks that are pseudocode.
- Test your translation: `cd translations/<code> && mdbook build`
