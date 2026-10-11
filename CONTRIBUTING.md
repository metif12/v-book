# Contributing

Thank you for your interest in contributing to The V Programming Language Book!

## Quick start

```bash
# Clone and setup
git clone https://github.com/metif12/v-book.git
cd v-book

# Verify everything works
v run tools/code_test.vsh        # Compile and run every V code block
v run tools/validate.vsh         # Validate book structure
v run site                       # Build the site into dist/
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
4. Test code examples: `v run tools/code_test.vsh`
5. Validate structure: `v run tools/validate.vsh`
6. Build the site: `v run site`
7. Open a pull request.

### Creating a new chapter

```bash
v run scripts/new_chapter.vsh <number> <title>
```

This creates a new chapter from a template. Add the chapter to `src/SUMMARY.md`
— the table of contents is what the site's sidebar, pager, search index and
sitemap are all built from.

## How the book is built

There is no mdBook here. `v run site` is a small V program that:

1. reads `src/SUMMARY.md` and every page it links to,
2. renders the Markdown to HTML (`site/markdown.v`),
3. wraps each page in the shared shell (`site/site.v`),
4. writes the tree into `dist/`, one directory per language,
5. writes a full text search index, a sitemap, `robots.txt` and a `404.html`.

`v run site serve` previews the result at
`http://localhost:8090/v-book/`, mounted the same way GitHub Pages serves it.

Pushing to `main` runs the code tests, the validator and the build, then
`pages.yml` deploys `dist/` to GitHub Pages.

## Project structure

```
src/                    # English Markdown (canonical source)
  SUMMARY.md            # Table of contents — add new chapters here
  ch00-introduction.md
  ch01-getting-started.md
  ...
static/                 # assets copied verbatim into dist/
  app.css               # chrome: top bar, search, table of contents, theme
  book.css              # prose typography
  app.js                # theme, search, panels, code blocks
  logo.svg              # the V logo
  codemirror/           # syntax highlighting
site/                   # the generator (pure V, plus veb for `serve`)
  main.v                # build, preview, sitemap, 404
  markdown.v            # Markdown renderer
  search.v              # full text search index
  site.v                # page shell, navigation, locales
translations/           # 15 language translations
  <code>/src/           # Translated content, mirror of src/
listings/               # V code examples by chapter
tools/
  code_test.vsh         # compiles and runs every v code block
  validate.vsh          # book structure validator
scripts/                # scaffolding scripts
  new_chapter.vsh
  new_locale.vsh
```

## Style guide

### Code examples

- All `v` code blocks must compile and run in CI.
- Use `v ignore` for pseudocode or incomplete examples.
- Use `v no_run` for examples that would block — for instance a server that
  never returns.
- Keep examples short and focused on the concept being taught.
- Use meaningful variable names.
- Each code block is self-contained — it is written to a temp `main.v` and run
  independently, so a block that needs a module or a template file has to be
  `v ignore` or `v no_run`.

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
- A heading becomes a sidebar anchor, so `##` and deeper are safe to link to.

## Code of conduct

Be respectful and constructive. We follow the [Contributor Covenant](https://www.contributor-covenant.org/).
