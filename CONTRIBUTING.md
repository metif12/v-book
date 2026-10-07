# Contributing

Thank you for your interest in contributing to The V Programming Language Book!

## How to contribute

### Reporting issues

- Check if the issue already exists before opening a new one.
- Include the chapter number and a clear description.
- For code examples, include the expected vs actual behavior.

### Translating

See [translations/README.md](translations/README.md).

### Adding content

1. Fork the repository.
2. Create a branch: `git checkout -b feat/my-chapter`
3. Write your content following the style guide.
4. Test code examples: `v run tools/mdbook-v-test .`
5. Build the book: `mdbook build`
6. Open a pull request.

## Style guide

### Code examples

- All V code blocks must compile and run.
- Use `v ignore` for pseudocode or incomplete examples.
- Use `v no_run` for examples that would block (e.g., waiting for input).
- Keep examples short and focused on the concept being taught.
- Use meaningful variable names.

### Prose

- Write clearly and concisely.
- Assume the reader is new to V but has programming experience.
- Use "you" to address the reader.
- Prefer active voice.
- Keep paragraphs short.

### Formatting

- Use `v fmt` on all V code.
- Use Markdown formatting consistently.
- Code blocks use triple backticks with language annotation.

## Code of conduct

Be respectful and constructive. We follow the [Contributor Covenant](https://www.contributor-covenant.org/).
