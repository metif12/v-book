#!/usr/bin/env v run

if os.args.len < 4 {
	println('Usage: v run scripts/new_locale.vsh <code> <english-name> <native-name> [--rtl]')
	exit(1)
}

code := os.args[1]
name := os.args[2]
native := os.args[3]
rtl := '--rtl' in os.args

dir := os.join_path('translations', code)
os.mkdir(dir) or { panic(err) }

summary := '# Summary\n\n'
summary += '[Introduction](../src/ch00-introduction.md)\n\n'
summary += 'TODO: Add translated chapter links.\n'

os.write_file(os.join_path(dir, 'SUMMARY.md'), summary) or { panic(err) }

book_toml := '[book]\ntitle = "The V Programming Language"\nauthors = ["The V Community"]\ndescription = "A comprehensive book for the V programming language"\nlanguage = "${code}"\nmultilingual = true\nsrc = "src"\n\n[build]\nbuild-dir = "book"\ncreate-missing = true\n'

os.write_file(os.join_path(dir, 'book.toml'), book_toml) or { panic(err) }

println('Created translation directory: ${dir}')
println('Language: ${name} (${native})')
if rtl {
	println('RTL: yes')
}
println('')
println('Next steps:')
println('1. Copy src/ to ${dir}/src/')
println('2. Translate SUMMARY.md')
println('3. Translate chapters progressively')
