#!/usr/bin/env v run

import os

fn collect_md_files(dir string, base string, mut files []string) {
	entries := os.ls(dir) or { return }
	for entry in entries {
		path := os.join_path(dir, entry)
		if os.is_dir(path) {
			collect_md_files(path, base, mut files)
		} else if entry.ends_with('.md') {
			files << path
		}
	}
}

fn print_errors(errors []string, warnings []string) {
	for e in errors {
		eprintln('ERROR: ${e}')
	}
	for w in warnings {
		eprintln('WARN:  ${w}')
	}
	if errors.len == 0 && warnings.len == 0 {
		println('No issues found.')
	}
}

mut errors := []string{}
mut warnings := []string{}

src_dir := 'src'
summary_path := os.join_path(src_dir, 'SUMMARY.md')

if !os.is_dir(src_dir) {
	errors << 'src/ directory not found'
}

if !os.exists(summary_path) {
	errors << 'src/SUMMARY.md not found'
	print_errors(errors, warnings)
	exit(1)
}

summary_content := os.read_file(summary_path) or {
	errors << 'Failed to read src/SUMMARY.md'
	print_errors(errors, warnings)
	exit(1)
}

mut linked_files := []string{}
for line in summary_content.split('\n') {
	mut trimmed := line.trim_space()
	if trimmed.starts_with('- [') {
		trimmed = trimmed[2..]
	}
	if trimmed.starts_with('[') {
		start := trimmed.index('(') or { continue }
		end := trimmed.index(')') or { continue }
		rel_path := trimmed[start + 1..end]
		linked_files << rel_path
	}
}

for rel_path in linked_files {
	full_path := os.join_path(src_dir, rel_path)
	if !os.exists(full_path) {
		errors << 'SUMMARY.md links to missing file: ${rel_path}'
	}
}

mut all_md_files := []string{}
collect_md_files(src_dir, src_dir, mut all_md_files)

	for file in all_md_files {
		rel := file.replace(src_dir + os.path_separator, '').replace('\\', '/')
	if rel == 'SUMMARY.md' {
		continue
	}
	mut found := false
	for linked in linked_files {
		if linked == rel {
			found = true
			break
		}
	}
	if !found {
		warnings << 'File not linked in SUMMARY.md: ${rel}'
	}
}

if !os.exists('book.toml') {
	errors << 'book.toml not found'
}

print_errors(errors, warnings)

if errors.len > 0 {
	exit(1)
}

println('Book structure validation passed.')
