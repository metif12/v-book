module main

import os

struct CodeBlock {
	lang   string
	code   string
	line   int
	file   string
}

struct TestResult {
	file    string
	line    int
	passed  bool
	message string
}

fn main() {
	if os.args.len < 2 {
		println('Usage: mdbook-v-test <book-dir>')
		exit(1)
	}

	book_dir := os.args[1]
	src_dir := os.join_path(book_dir, 'src')

	if !os.is_dir(src_dir) {
		println('No src directory found, skipping V code tests')
		exit(0)
	}

	mut results := []TestResult{}
	mut total := 0
	mut passed := 0

	md_files := find_md_files(src_dir)
	for file in md_files {
		content := os.read_file(file) or { continue }
		blocks := extract_v_code_blocks(content, file)
		for block in blocks {
			total++
			result := test_code_block(block)
			if result.passed {
				passed++
			} else {
				results << result
				println('FAIL: ${result.file}:${result.line}')
				println('  ${result.message}')
			}
		}
	}

	println('')
	println('V Code Block Tests: ${passed}/${total} passed')

	if results.len > 0 {
		println('')
		println('Failures:')
		for r in results {
			println('  ${r.file}:${r.line}: ${r.message}')
		}
		exit(1)
	}
}

fn find_md_files(dir string) []string {
	mut files := []string{}
	entries := os.ls(dir) or { return files }
	for entry in entries {
		path := os.join_path(dir, entry)
		if os.is_dir(path) {
			files << find_md_files(path)
		} else if entry.ends_with('.md') {
			files << path
		}
	}
	return files
}

fn extract_v_code_blocks(content string, file string) []CodeBlock {
	mut blocks := []CodeBlock{}
	lines := content.split('\n')
	mut in_block := false
	mut block_lang := ''
	mut block_code := ''
	mut block_line := 0

	for i, line in lines {
		trimmed := line.trim_space()
		if trimmed.starts_with('```') {
			if !in_block {
				in_block = true
				block_lang = trimmed[3..].trim_space()
				block_code = ''
				block_line = i + 1
			} else {
				in_block = false
				if block_lang in ['v', 'v ignore', 'v no_run'] {
					blocks << CodeBlock{
						lang: block_lang
						code: block_code
						line: block_line
						file: file
					}
				}
			}
		} else if in_block {
			block_code += line + '\n'
		}
	}

	return blocks
}

fn test_code_block(block CodeBlock) TestResult {
	if block.lang == 'v ignore' || block.lang == 'v no_run' {
		return TestResult{
			file: block.file
			line: block.line
			passed: true
			message: 'skipped'
		}
	}

	tmp_dir := os.vtmp_dir()
	tmp_file := os.join_path(tmp_dir, 'main.v')
	os.write_file(tmp_file, block.code) or {
		return TestResult{
			file: block.file
			line: block.line
			passed: false
			message: 'failed to write temp file'
		}
	}

	res := os.execute('v run ${tmp_file}')
	if res.exit_code != 0 {
		return TestResult{
			file: block.file
			line: block.line
			passed: false
			message: 'compilation or runtime error: ${res.output}'
		}
	}

	return TestResult{
		file: block.file
		line: block.line
		passed: true
		message: 'ok'
	}
}
