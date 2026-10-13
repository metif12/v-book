module main

import strings

// backtick is the Markdown code span delimiter. It is written as a number
// because a backtick rune literal is not valid V syntax.
const backtick = 96

// Block kinds recognised by the renderer.
enum BlockKind {
	heading
	paragraph
	code
	list_ul
	list_ol
	table
	quote
	hr
	roadmap
}

struct Block {
	kind BlockKind
	// heading level, or the code fence language
	level int
	lang  string
	// text lines, or the raw code body for code blocks
	lines []string
}

// render_markdown turns book Markdown into HTML.
//
// The book uses a deliberately small subset of Markdown, and this renderer
// covers exactly that subset: ATX headings, paragraphs, fenced code blocks,
// unordered and ordered lists, pipe tables, horizontal rules, and the inline
// forms (code spans, bold, italic, links).
pub fn render_markdown(src string) string {
	blocks := parse_blocks(src)
	mut b := strings.new_builder(1024)
	for block in blocks {
		b.write_string(render_block(block))
	}
	return b.str()
}

fn parse_blocks(src string) []Block {
	lines := src.replace('\r\n', '\n').split('\n')
	mut blocks := []Block{}
	mut i := 0
	for i < lines.len {
		line := lines[i]
		trimmed := line.trim_space()
		if trimmed == '' {
			i++
			continue
		}
		if trimmed.starts_with('```') {
			lang := trimmed[3..].trim_space()
			mut body := []string{}
			i++
			for i < lines.len && !lines[i].trim_space().starts_with('```') {
				body << lines[i]
				i++
			}
			i++ // closing fence
			if lang == roadmap_fence {
				blocks << Block{
					kind:  .roadmap
					lines: body
				}
				continue
			}
			blocks << Block{
				kind:  .code
				lang:  lang
				lines: body
			}
			continue
		}
		if trimmed.starts_with('#') {
			mut level := 0
			for level < trimmed.len && trimmed[level] == `#` {
				level++
			}
			text := trimmed[level..].trim_space()
			blocks << Block{
				kind:  .heading
				level: level
				lines: [text]
			}
			i++
			continue
		}
		if is_table_row(trimmed) {
			mut rows := []string{}
			for i < lines.len && is_table_row(lines[i].trim_space()) {
				rows << lines[i].trim_space()
				i++
			}
			blocks << Block{
				kind:  .table
				lines: rows
			}
			continue
		}
		if is_ul_row(trimmed) {
			mut items := []string{}
			for i < lines.len && is_ul_row(lines[i].trim_space()) {
				items << lines[i].trim_space()[2..].trim_space()
				i++
			}
			blocks << Block{
				kind:  .list_ul
				lines: items
			}
			continue
		}
		if is_ol_row(trimmed) {
			mut items := []string{}
			for i < lines.len && is_ol_row(lines[i].trim_space()) {
				raw := lines[i].trim_space()
				dot := raw.index('.') or { -1 }
				if dot >= 0 && dot + 1 <= raw.len {
					items << raw[dot + 1..].trim_space()
				} else {
					items << raw
				}
				i++
			}
			blocks << Block{
				kind:  .list_ol
				lines: items
			}
			continue
		}
		// Quote: gather the lines that carry the marker, then split them into
		// paragraphs on the blank quote lines, the way mdBook did.
		if trimmed.starts_with('>') {
			mut items := []string{}
			for i < lines.len {
				mut q := lines[i].trim_space()
				if q.starts_with('>') {
					q = q[1..].trim_space()
					items << q
					i++
				} else if q == '' {
					break
				} else {
					items << lines[i]
					i++
				}
			}
			blocks << Block{
				kind:  .quote
				lines: items
			}
			continue
		}
		if is_hr(trimmed) {
			blocks << Block{
				kind: .hr
			}
			i++
			continue
		}
		// Paragraph: gather until a blank line or a line that starts a new block.
		mut para := []string{}
		for i < lines.len {
			next := lines[i].trim_space()
			if next == '' || next.starts_with('#') || next.starts_with('```')
				|| is_table_row(next) || is_ul_row(next) || is_ol_row(next) || is_hr(next) {
				break
			}
			para << lines[i]
			i++
		}
		blocks << Block{
			kind:  .paragraph
			lines: para
		}
	}
	return blocks
}

fn render_block(block Block) string {
	match block.kind {
		.heading {
			id := slugify(block.lines[0])
			anchor := if block.level >= 2 {
				'<a class="heading-anchor" href="#${id}" aria-hidden="true">#</a>'
			} else {
				''
			}
			return '<h${block.level} id="${id}">${render_inline(block.lines[0])}${anchor}</h${block.level}>\n'
		}
		.roadmap {
			// The diagram itself comes from the template; the figure around it,
			// the caption with its progress line, and the text form below are
			// the page's own furniture.
			mut sb := strings.new_builder(4096)
			sb.write_string('<figure class="roadmap-figure">\n')
			sb.write_string('<div class="roadmap" role="group" aria-label="The V roadmap">\n')
			sb.write_string(render_roadmap(block.lines))
			sb.write_string('</div>\n')
			sb.write_string('<figcaption class="roadmap-caption">A node fills in once the chapter it links to has been opened. <span class="roadmap-progress" id="roadmap-progress" hidden></span><button class="roadmap-reset" type="button" id="roadmap-reset" hidden>Start over</button></figcaption>\n')
			sb.write_string('<details class="roadmap-source">\n<summary>The path as text</summary>\n')
			for line in block.lines {
				t := line.trim_space()
				if t == '' {
					continue
				}
				node_class := if line.starts_with(' ') || line.starts_with('\t') {
					' is-node'
				} else {
					''
				}
				sb.write_string('<p class="roadmap-source-line${node_class}">${escape_text(t)}</p>\n')
			}
			sb.write_string('</details>\n')
			sb.write_string('</figure>\n')
			return sb.str()
		}
		.quote {
			return render_quote(block.lines)
		}
		.paragraph {
			return '<p>${render_inline(block.lines.join(' '))}</p>\n'
		}
		.code {
			return render_code_block(block.lang, block.lines)
		}
		.list_ul {
			mut sb := strings.new_builder(256)
			sb.write_string('<ul>\n')
			for item in block.lines {
				sb.write_string('<li>${render_inline(item)}</li>\n')
			}
			sb.write_string('</ul>\n')
			return sb.str()
		}
		.list_ol {
			mut sb := strings.new_builder(256)
			sb.write_string('<ol>\n')
			for item in block.lines {
				sb.write_string('<li>${render_inline(item)}</li>\n')
			}
			sb.write_string('</ol>\n')
			return sb.str()
		}
		.table {
			return render_table(block.lines)
		}
		.hr {
			return '<hr>\n'
		}
	}
}

// render_code_block emits a code block. V code is wrapped in a textarea so the
// client can hand it to CodeMirror read-only, which is what gives the page the
// same highlighting as the editor in the tour.
fn render_code_block(lang string, lines []string) string {
	body := lines.join('\n')
	mut sb := strings.new_builder(512)
	sb.write_string('<div class="code-block" data-lang="${escape_attr(lang)}">\n')
	match lang {
		'v', 'v ignore', 'v no_run' {
			sb.write_string('<textarea class="code-source">${escape_html(body)}</textarea>\n')
		}
		'bash', 'sh', 'powershell', 'console' {
			sb.write_string('<pre class="shell"><code>${escape_html(body)}</code></pre>\n')
		}
		else {
			sb.write_string('<pre><code>${escape_html(body)}</code></pre>\n')
		}
	}
	sb.write_string('</div>\n')
	return sb.str()
}

// render_quote turns a quoted block into a callout, splitting the paragraphs on
// the blank quote lines between them.
fn render_quote(lines []string) string {
	mut paragraphs := []string{}
	mut current := []string{}
	for line in lines {
		if line.trim_space() == '' {
			paragraphs << current.join(' ')
			current = []string{}
			continue
		}
		current << line
	}
	paragraphs << current.join(' ')
	mut sb := strings.new_builder(256)
	sb.write_string('<blockquote>\n')
	for p in paragraphs {
		if p.trim_space() == '' {
			continue
		}
		sb.write_string('<p>${render_inline(p)}</p>\n')
	}
	sb.write_string('</blockquote>\n')
	return sb.str()
}

fn render_table(rows []string) string {
	if rows.len < 2 {
		return ''
	}
	header := split_row(rows[0])
	mut sb := strings.new_builder(512)
	sb.write_string('<table>\n<thead>\n<tr>\n')
	for cell in header {
		sb.write_string('<th>${render_inline(cell)}</th>\n')
	}
	sb.write_string('</tr>\n</thead>\n<tbody>\n')
	for row in rows[2..] {
		cells := split_row(row)
		sb.write_string('<tr>\n')
		for j, cell in cells {
			if j >= header.len {
				break
			}
			sb.write_string('<td>${render_inline(cell)}</td>\n')
		}
		sb.write_string('</tr>\n')
	}
	sb.write_string('</tbody>\n</table>\n')
	return sb.str()
}

fn split_row(row string) []string {
	inner := row.trim_string_left('|').trim_string_right('|')
	mut cells := []string{}
	mut cur := []u8{}
	mut in_code := false
	for c in inner {
		if c == backtick {
			in_code = !in_code
			cur << u8(c)
			continue
		}
		if c == `|` && !in_code {
			cells << cur.bytestr().trim_space()
			cur = []u8{}
			continue
		}
		cur << u8(c)
	}
	cells << cur.bytestr().trim_space()
	return cells
}

// render_inline handles the inline Markdown forms used by the book.
//
// HTML is escaped first, so a code span holding a less-than or an ampersand
// stays safe, and the markers are then matched against the escaped text.
fn render_inline(text string) string {
	mut s := escape_html(text)
	s = replace_code_spans(s)
	s = replace_bold(s)
	s = replace_italic(s)
	s = replace_links(s)
	return s
}

fn replace_code_spans(s string) string {
	mut sb := strings.new_builder(s.len + 32)
	mut i := 0
	for i < s.len {
		if s[i] == backtick {
			end := s.index_after('`', i + 1) or {
				sb.write_u8(s[i])
				i++
				continue
			}
			code := s[i + 1..end]
			sb.write_string('<code>')
			sb.write_string(code)
			sb.write_string('</code>')
			i = end + 1
			continue
		}
		sb.write_u8(s[i])
		i++
	}
	return sb.str()
}

fn replace_bold(s string) string {
	mut out := s
	for {
		start := out.index('**') or { break }
		rest := out[start + 2..]
		stop := rest.index('**') or { break }
		inner := rest[..stop]
		out = out[..start] + '<strong>' + inner + '</strong>' + rest[stop + 2..]
	}
	return out
}

// replace_italic handles single asterisks. Bold runs are already gone by the
// time this runs, so a lone asterisk is safe to treat as emphasis.
fn replace_italic(s string) string {
	mut out := s
	mut i := 0
	for i < out.len {
		if out[i] == `*` && (i + 1 >= out.len || out[i + 1] != `*`) {
			end := index_of_byte_from(out, `*`, i + 1)
			if end == -1 {
				break
			}
			inner := out[i + 1..end]
			out = out[..i] + '<em>' + inner + '</em>' + out[end + 1..]
			i += 4 + inner.len + 5
			continue
		}
		i++
	}
	return out
}

fn replace_links(s string) string {
	mut out := s
	for {
		lb := out.index('[') or { break }
		rb := out.index_after(']', lb + 1) or { break }
		if rb + 1 >= out.len || out[rb + 1] != `(` {
			break
		}
		rp := out.index_after(')', rb + 2) or { break }
		text := out[lb + 1..rb]
		href := link_target(out[rb + 2..rp])
		out = out[..lb] + '<a href="${href}">' + text + '</a>' + out[rp + 1..]
	}
	return out
}

// link_target resolves a link target against the base path.
fn link_target(raw string) string {
	if raw.starts_with('http://') || raw.starts_with('https://')
		|| raw.starts_with('mailto:') || raw.starts_with('#') {
		return raw
	}
	if raw.ends_with('.md') {
		return base_path + raw.replace('.md', '.html')
	}
	return base_path + raw
}

fn index_of_byte_from(s string, c u8, from int) int {
	mut i := from
	for i < s.len {
		if s[i] == c {
			return i
		}
		i++
	}
	return -1
}

fn is_table_row(s string) bool {
	return s.starts_with('|') && s.len > 1
}

fn is_ul_row(s string) bool {
	return s.starts_with('- ') || s.starts_with('* ')
}

fn is_ol_row(s string) bool {
	if s.len < 3 {
		return false
	}
	mut i := 0
	for i < s.len && s[i] >= `0` && s[i] <= `9` {
		i++
	}
	return i > 0 && i < s.len && s[i] == `.` && i + 1 < s.len && s[i + 1] == ` `
}

fn is_hr(s string) bool {
	return s == '---' || s == '***'
}

fn escape_html(s string) string {
	return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
		.replace('"', '&quot;')
}

// slugify makes a heading anchor id.
fn slugify(text string) string {
	mut out := []u8{}
	mut prev_dash := false
	for c in text.runes() {
		if (c >= `a` && c <= `z`) || (c >= `0` && c <= `9`) {
			out << u8(c)
			prev_dash = false
			continue
		}
		if c >= `A` && c <= `Z` {
			out << u8(c - `A` + `a`)
			prev_dash = false
			continue
		}
		if c == ` ` || c == `-` || c == `_` {
			if !prev_dash {
				out << `-`
				prev_dash = true
			}
		}
	}
	return out.bytestr().trim_left('-').trim_right('-')
}
