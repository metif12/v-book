#!/usr/bin/env v run

if os.args.len < 3 {
	println('Usage: v run scripts/new_chapter.vsh <chapter-number> <chapter-title>')
	exit(1)
}

num := os.args[1]
title := os.args[2]
slug := title.to_lower().replace(' ', '-').replace(':', '').replace(',', '')

dir := os.join_path('src', 'ch${num}-${slug}')
os.mkdir(dir) or { panic(err) }

content := '# Chapter ${num}: ${title}\n\nTODO: Write chapter content.\n'

os.write_file(os.join_path(dir, 'index.md'), content) or { panic(err) }

println('Created ${dir}/index.md')
println('Add to src/SUMMARY.md:')
println('  - [Chapter ${num}: ${title}](ch${num}-${slug}/index.md)')
