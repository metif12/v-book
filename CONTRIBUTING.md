# Contributing

Thank you for your interest in contributing to The V Programming Language Book!

## Quick start

```bash
# Clone and setup
git clone https://github.com/metif12/v-book.git
cd v-book

# Verify everything works
v run tools/mdbook-v-test .    # Test all V code blocks compile
v run tools/validate.vsh        # Validate book structure
mdbook build                    # Build the book
```

## How to contribute

### Reporting issues

- Check if the issue already exists before opening a new one.
- Include the chapter number and a clear description.
- For code examples, include the expected vs actual behavior.

### Translating

See [translations/README.md](translations/README.md) for the full translation workflow.

### Adding or editing content

1. Fork the repository.
2. Create a branch: `git checkout -b feat/my-chapter`
3. Write your content following the style guide.
4. Test code examples: `v run tools/mdbook-v-test .`
5. Validate structure: `v run tools/validate.vsh`
6. Build the book: `mdbook build`
7. Open a pull request.

### Creating a new chapter

```bash
v run scripts/new_chapter.vsh <number> <title>
```

This creates a new chapter directory with a template file. Add the chapter to `src/SUMMARY.md`.

## Project structure

```
src/                    # English Markdown (canonical source)
  SUMMARY.md            # Table of contents — add new chapters here
  ch00-introduction.md
  ch01-getting-started.md
  ...
translations/           # 15 language translations
  <code>/src/           # Translated content
  <code>/book.toml      # Per-locale mdBook config
listings/               # V code examples by chapter
tools/
  mdbook-v-test/        # CI preprocessor — compiles every v block
  validate.vsh          # Book structure validator
theme/                  # mdBook theme (CSS, templates)
  index.hbs             # Page template with Edit on GitHub button
  css/
  js/
scripts/                # Scaffolding scripts
  new_chapter.vsh
  new_locale.vsh
```

## Style guide

### Code examples

- All `v` code blocks must compile and run in CI.
- Use `v ignore` for pseudocode or incomplete examples.
- Use `v no_run` for examples that would block (e.g., waiting for input).
- Keep examples short and focused on the concept being taught.
- Use meaningful variable names.
- Each code block is self-contained — it is written to a temp `main.v` and run independently.

### Prose

- Write clearly and concisely.
- Assume the reader is new to V but has programming experience.
- Use "you" to address the reader.
- Prefer active voice.
- Keep paragraphs short.

### Formatting

- Use `v fmt` on all V code.
- Use Markdown formatting consistently.
- Code blocks use triple backticks with language annotation (`v`, `v ignore`, or `v no_run`).

## Code of conduct

Be respectful and constructive. We follow the [Contributor Covenant](https://www.contributor-covenant.org/).
