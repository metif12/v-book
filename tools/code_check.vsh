#!/usr/bin/env v run

// Compile and run every V code block in the book.
//
// Usage: v run tools/code_check.vsh [dir ...]
//
// Without arguments the English src/ is checked, because every translation
// reuses the same code blocks. Pass a directory to check a translation:
// `v run tools/code_check.vsh translations/zh/src`.
//
// Each block is written to its own temporary main.v and compiled in isolation,
// which is why every example in the book has to be self contained.
import os

struct CodeBlock {
	lang string
	code string
	line int
	file string
}

struct Failure {
	file    string
	line    int
	message string
}

fn collect_md_files(dir string, mut files []string) {
	entries := os.ls(dir) or { return }
	for entry in entries {
		if entry.starts_with('.') {
			continue
		}
		path := os.join_path(dir, entry)
		if os.is_dir(path) {
			collect_md_files(path, mut files)
		} else if entry.ends_with('.md') && entry != 'SUMMARY.md' {
			files << path
		}
	}
}

fn extract_v_code_blocks(content string, file string) []CodeBlock {
	mut blocks := []CodeBlock{}
	lines := content.replace('\r\n', '\n').split('\n')
	mut in_block := false
	mut lang := ''
	mut code := []string{}
	mut start := 0
	for i, line in lines {
		trimmed := line.trim_space()
		if trimmed.starts_with('```') {
			if !in_block {
				in_block = true
				lang = trimmed[3..].trim_space()
				code = []string{}
				start = i + 1
			} else {
				in_block = false
				if lang == 'v' || lang == 'v no_run' {
					blocks << CodeBlock{
						lang: lang
						code: code.join('\n') + '\n'
						line: start
						file: file
					}
				}
			}
			continue
		}
		if in_block {
			code << line
		}
	}
	return blocks
}

fn run_block(block CodeBlock) (bool, string) {
	if block.lang == 'v ignore' {
		return true, 'skipped'
	}
	tmp_dir := os.join_path(os.vtmp_dir(), 'vbook-code-${os.getpid()}')
	os.mkdir_all(tmp_dir) or {}
	tmp_file := os.join_path(tmp_dir, 'main.v')
	os.write_file(tmp_file, block.code) or { return false, 'cannot write temp file' }
	// The block runs with its own directory as the working directory, so an
	// example that writes a file does not drop it into the repository.
	tool := if block.lang == 'v no_run' { '-check' } else { 'run' }
	mut res := os.Result{}
	if os.user_os() == 'windows' {
		res = os.exec(['cmd', '/c', 'cd /d ${tmp_dir} && v ${tool} main.v'])
	} else {
		res = os.exec(['sh', '-c', 'cd ${tmp_dir} && v ${tool} main.v'])
	}
	if res.exit_code != 0 {
		return false, res.output
	}
	return true, 'ok'
}

fn main() {
	// With no arguments the English source is checked, because every
	// translation reuses the same code blocks. Pass a translation's src
	// directory to check that language on its own.
	args := os.args[1..]
	dirs := if args.len == 0 { ['src'] } else { args }
	mut total := 0
	mut passed := 0
	mut skipped := 0
	mut failures := []Failure{}
	for dir in dirs {
		if !os.is_dir(dir) {
			eprintln('code_check: no such directory: ${dir}')
			continue
		}
		mut files := []string{}
		collect_md_files(dir, mut files)
		for file in files.sorted() {
			content := os.read_file(file) or { continue }
			seen := total
			for block in extract_v_code_blocks(content, file) {
				total++
				ok, msg := run_block(block)
				if ok {
					passed++
					if msg == 'skipped' {
						skipped++
					}
				} else {
					failures << Failure{
						file:    file
						line:    block.line
						message: msg
					}
				}
			}
			// Progress per page, so a hang or a slow block has a name.
			if total > seen {
				println('code_check: ${file}: ${total} blocks checked')
			}
		}
		println('code_check: ${dir}: ${total} blocks seen so far')
	}
	println('')
	println('V code blocks: ${passed}/${total} passed (${skipped} skipped, ${failures.len} failed)')
	for f in failures {
		eprintln('FAIL ${f.file}:${f.line}')
		eprintln('${f.message}')
	}
	if failures.len > 0 {
		exit(1)
	}
}
