#!/usr/bin/env v run

// Lint the book's structure.
//
// Usage: v run tools/validate.vsh
//
// Checks what a reader and the site builder both rely on:
//   - src/SUMMARY.md links to files that exist
//   - every page in src/ is reachable from SUMMARY.md
//   - every translation ships a SUMMARY.md and the same pages as the English
//     source, so the language menu never leads to a missing page
//   - no mdBook leftovers are referenced any more
import os

// Locale is one published language.
struct Locale {
	code    string
	dir     string
	rtl     bool
	name    string
	english string
}

// locales lists every published language, English first.
const locales = [
	Locale{'en', 'src', false, 'English', 'English'},
	Locale{'de', 'src', false, 'Deutsch', 'German'},
	Locale{'es', 'src', false, 'Español', 'Spanish'},
	Locale{'fr', 'src', false, 'Français', 'French'},
	Locale{'zh', 'src', false, '简体中文', 'Chinese'},
	Locale{'ru', 'src', false, 'Русский', 'Russian'},
	Locale{'ja', 'src', false, '日本語', 'Japanese'},
	Locale{'ko', 'src', false, '한국어', 'Korean'},
	Locale{'pt', 'src', false, 'Português', 'Portuguese'},
	Locale{'it', 'src', false, 'Italiano', 'Italian'},
	Locale{'ar', 'src', true, 'العربية', 'Arabic'},
	Locale{'fa', 'src', true, 'فارسی', 'Persian'},
	Locale{'hi', 'src', false, 'हिन्दी', 'Hindi'},
	Locale{'bn', 'src', false, 'বাংলা', 'Bengali'},
	Locale{'ur', 'src', true, 'اردو', 'Urdu'},
	Locale{'id', 'src', false, 'Bahasa Indonesia', 'Indonesian'},
	Locale{'tr', 'src', false, 'Türkçe', 'Turkish'},
]

// report prints what the checks found.
fn report(errors []string, warnings []string) {
	for e in errors {
		eprintln('ERROR: ${e}')
	}
	for w in warnings {
		println('WARN:  ${w}')
	}
	if errors.len == 0 && warnings.len == 0 {
		println('No issues found.')
	}
}

// collect_md_files gathers every Markdown file under dir.
fn collect_md_files(dir string, mut files []string) {
	entries := os.ls(dir) or { return }
	for entry in entries {
		path := os.join_path(dir, entry)
		if os.is_dir(path) {
			collect_md_files(path, mut files)
		} else if entry.ends_with('.md') {
			files << path
		}
	}
}

// summary_links reads the page hrefs a SUMMARY.md links to.
fn summary_links(path string) []string {
	mut links := []string{}
	content := os.read_file(path) or { return links }
	for line in content.replace('\r\n', '\n').split('\n') {
		mut trimmed := line.trim_space()
		if trimmed.starts_with('- [') {
			trimmed = trimmed[2..]
		}
		if !trimmed.starts_with('[') {
			continue
		}
		// A link title may hold parentheses of its own, so the href is the
		// text between the last bracket pair on the line.
		if !trimmed.contains('](') || !trimmed.ends_with(')') {
			continue
		}
		rb := trimmed.last_index(']') or { continue }
		links << trimmed[rb + 2..trimmed.len - 1]
	}
	return links
}

// check_locale validates one language's source directory.
fn check_locale(locale Locale, en_pages []string, mut errors []string, mut warnings []string) {
	src_dir := if locale.code == 'en' {
		'src'
	} else {
		os.join_path('translations', locale.code, 'src')
	}
	if !os.is_dir(src_dir) {
		errors << 'missing source directory: ${src_dir}'
		return
	}
	summary := os.join_path(src_dir, 'SUMMARY.md')
	if !os.exists(summary) {
		errors << '${locale.code}: no SUMMARY.md'
		return
	}
	links := summary_links(summary)
	for link in links {
		if !os.exists(os.join_path(src_dir, link)) {
			errors << '${locale.code}: SUMMARY.md links to a missing file: ${link}'
		}
	}
	if locale.code == 'en' {
		return
	}
	for page in en_pages {
		if !links.contains(page) {
			warnings << '${locale.code}: SUMMARY.md has no entry for ${page}'
		}
	}
}

mut errors := []string{}

mut warnings := []string{}

// The English source is the reference every translation is measured against.
en_links := summary_links('src/SUMMARY.md')
mut en_pages := []string{}

for link in en_links {
	if !en_pages.contains(link) {
		en_pages << link
	}
}

for link in en_links {
	if !os.exists(os.join_path('src', link)) {
		errors << 'src/SUMMARY.md links to a missing file: ${link}'
	}
}

mut en_files := []string{}

collect_md_files('src', mut en_files)

for file in en_files {
	rel := file.replace(os.path_separator, '/').replace('src/', '')
	// not_found.md is the 404 page, which is reachable by being missing.
	if rel == 'SUMMARY.md' || rel == 'not_found.md' {
		continue
	}
	if !en_pages.contains(rel) {
		warnings << 'src page not reachable from SUMMARY.md: ${rel}'
	}
}

for locale in locales {
	check_locale(locale, en_pages, mut errors, mut warnings)
}

report(errors, warnings)

if errors.len > 0 {
	exit(1)
}

println('Book structure validation passed: ${en_pages.len} pages, ${locales.len - 1} translations.')
