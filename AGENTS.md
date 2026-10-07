# AGENTS.md

## Project

mdBook-based book for the V programming language. Targets V 0.5.2+. Source is Markdown in `src/`, code examples in `listings/`.

## Commands

```bash
mdbook build                        # Build the book
v run tools/mdbook-v-test .         # Test all V code blocks compile + run
v test .                            # Run V unit tests
v run tools/validate.vsh            # Lint book structure (CI references this)
```

## Code example conventions

- `v` — compiled and run in CI (must pass)
- `v ignore` — not compiled (pseudocode, incomplete)
- `v no_run` — compiled but not run (blocking examples)

The test tool (`tools/mdbook-v-test/main.v`) extracts fenced code blocks from `src/*.md` and runs each `v` block through `v run`. A failing block fails CI. It runs as a standalone CI step, not as a registered mdBook preprocessor.

## Structure

- `src/` — English Markdown (canonical source)
- `listings/` — V code examples organized by chapter
- `translations/<code>/` — 15 language dirs, all content TODO
- `tools/mdbook-v-test/` — custom mdBook preprocessor (V module)
- `theme/` — mdBook theme (CSS, JS, templates)
- `book.toml` — mdBook config; preprocessor registered as `[preprocessor.v-test]`

## Gotchas

- `tools/validate.vsh` is referenced in CI (`.github/workflows/main.yml`) but does not exist — creating it is pending.
- V code blocks must be self-contained (each block is written to a temp `main.v` and run independently).
- String interpolation in V uses `${...}` inside single-quoted strings.
- The `v` code block language must be exactly `v`, `v ignore`, or `v no_run` — the preprocessor matches on these literals.
