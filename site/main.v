module main

import os
import time
import veb

// out_dir is where the static site is written.
const out_dir = 'dist'

// en_source is the canonical Markdown directory.
const en_source = 'src'

// serve_port is the local preview port.
const serve_port = 8090

// App serves the built book for local preview.
//
// The book is published under a subdirectory, so the static handler is mounted
// at that subdirectory rather than at the root, and the preview behaves like
// the deployed site.
struct App {
	veb.StaticHandler
}

// Context is the per-request state the veb router requires.
struct Context {
	veb.Context
}

// main builds the book, and previews it when asked to.
fn main() {
	mut args := os.args.clone()
	args.delete(0)
	mut target := out_dir
	mut serve_mode := false
	for arg in args {
		if arg == 'serve' {
			serve_mode = true
		} else if !arg.starts_with('-') {
			target = arg
		}
	}
	build(target)
	if serve_mode {
		serve(target)
	}
}

// build renders every locale into target.
fn build(target string) {
	start := time.ticks()
	if os.is_dir(target) {
		os.rmdir_all(target) or {}
	}
	os.mkdir_all(target) or { panic(err) }
	copy_dir('static', target) or { panic('copying static assets: ${err}') }
	mut total_pages := 0
	mut sitemap := []string{}
	for locale in locales {
		src_dir := if locale.code == 'en' { en_source } else { 'translations/${locale.code}/src' }
		if !os.is_dir(src_dir) {
			eprintln('site: no source for ${locale.code}, skipped')
			continue
		}
		n := build_locale(locale, src_dir, target) or {
			eprintln('site: ${locale.code}: ${err.msg()}')
			continue
		}
		total_pages += n
		sitemap << index_urls(locale, src_dir)
		println('site: ${locale.code}: ${n} pages')
	}
	write_root_index(target) or { panic(err) }
	write_seo(target, sitemap) or { panic(err) }
	elapsed := (time.ticks() - start) / 1000
	println('site: ${total_pages} pages written to ${target}/ in ${elapsed} ms')
}

// serve previews the built site at the same subdirectory it is published under.
fn serve(target string) {
	mut app := &App{}
	app.mount_static_folder_at(target, '/v-book') or {
		eprintln('serve: ${err.msg()}')
		return
	}
	println('serving ${base_path} on http://localhost:${serve_port}${base_path}')
	veb.run[App, Context](mut app, serve_port)
}

// build_locale renders one language into its own directory.
fn build_locale(locale Locale, src_dir string, target string) !int {
	summary := os.read_file(os.join_path(src_dir, 'SUMMARY.md'))!
	entries := parse_summary(summary)
	pages := pages_only(entries)
	sub := if locale.code == 'en' { target } else { os.join_path(target, locale.code) }
	os.mkdir_all(sub)!
	mut docs := [][]SearchDoc{}
	mut part := ''
	for i, page in pages {
		if page.part != '' {
			part = page.part
		}
		path := os.join_path(src_dir, page.href)
		raw := os.read_file(path) or {
			eprintln('site: ${locale.code}: missing ${page.href}')
			continue
		}
		body := render_markdown(raw)
		title := extract_title(raw, page.title)
		prev := if i > 0 { pages[i - 1] } else { NavEntry{} }
		next := if i < pages.len - 1 { pages[i + 1] } else { NavEntry{} }
		opts := PageOpts{
			locale:      locale
			title:       '${title} · ${site_name}'
			description: 'The V Programming Language Book: a practical, example first guide to V.'
			body:        body
			toc:         build_toc(entries, locale, page.href)
			prev_url:    if prev.href != '' { page_url(locale, prev.href) } else { '' }
			prev_text:   prev.title
			next_url:    if next.href != '' { page_url(locale, next.href) } else { '' }
			next_text:   next.title
			counter:     '${i + 1} / ${pages.len}'
			edit_url:    edit_target(locale, page.href)
			page_href:   page.href
		}
		out := render_page(opts)
		file := os.join_path(sub, page.href.replace('.md', '.html'))
		os.write_file(file, out)!
		docs << build_search_docs(title, page_url(locale, page.href), part, raw)
	}
	write_not_found(locale, src_dir, sub) or { eprintln('site: ${locale.code}: ${err.msg()}') }
	// The search index is language specific and sits beside the pages, so the
	// client fetches it with one relative request.
	os.write_file(os.join_path(sub, 'search-index.js'), build_search_index(flatten(docs)))!
	return pages.len
}

// flatten turns the per page document lists into one index.
fn flatten(groups [][]SearchDoc) []SearchDoc {
	mut out := []SearchDoc{}
	for g in groups {
		out << g
	}
	return out
}

// write_not_found renders the 404 page from the locale's not_found.md.
fn write_not_found(locale Locale, src_dir string, sub string) ! {
	path := os.join_path(src_dir, 'not_found.md')
	if !os.exists(path) {
		return
	}
	raw := os.read_file(path)!
	title := strip_inline_marks(extract_title(raw, 'Page not found'))
	body := render_markdown(raw)
	opts := PageOpts{
		locale:      locale
		title:       '${title} · ${site_name}'
		description: 'That page does not exist.'
		body:        body
		toc:         '<nav class="toc" id="toc" aria-label="Contents"></nav>'
		counter:     ''
		edit_url:    edit_target(locale, 'not_found.md')
		page_href:   'not_found.md'
	}
	os.write_file(os.join_path(sub, '404.html'), render_page(opts))!
}

// write_root_index sends the site root to the first page of the English book.
//
// The card itself is site/templates/landing.html, so the landing page is HTML
// in the same place as the rest of the shell.
fn write_root_index(target string) ! {
	first := locales[0]
	content := os.read_file(os.join_path(en_source, 'SUMMARY.md'))!
	entries := parse_summary(content)
	root := locale_root(first, entries)
	landing := LandingData{
		first:     escape_attr(root)
		base:      base_path.trim_right('/')
		site_name: escape_text(site_name)
		langs:     veb.RawHtml(language_links())
	}
	os.write_file(os.join_path(target, 'index.html'), $tmpl('templates/landing.html', landing))!
}

// LandingData is what the landing template receives.
struct LandingData {
	first     string
	base      string
	site_name string
	langs     veb.RawHtml
}

// language_links renders the landing page language list.
fn language_links() string {
	mut sb := '<ul>'
	for l in locales {
		root := base_path + if l.code == 'en' { '' } else { l.code + '/' }
		sb += '<li><a href="${root}" lang="${l.code}" dir="${l.dir}">${escape_text(l.name)}</a></li>'
	}
	sb += '</ul>'
	return sb
}

// index_urls lists every page of a locale as a sitemap entry.
fn index_urls(locale Locale, src_dir string) string {
	content := os.read_file(os.join_path(src_dir, 'SUMMARY.md')) or { return '' }
	mut sb := ''
	for p in pages_only(parse_summary(content)) {
		sb += '  <url>\n    <loc>https://metif12.github.io${page_url(locale, p.href)}</loc>\n  </url>\n'
	}
	return sb
}

// write_seo writes robots.txt and a sitemap covering every published page.
fn write_seo(target string, sitemap []string) ! {
	os.write_file(os.join_path(target, 'robots.txt'), 'User-agent: *\nAllow: /\nSitemap: https://metif12.github.io${base_path}sitemap.xml\n')!
	mut xml := '<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
	for part in sitemap {
		xml += part
	}
	xml += '</urlset>\n'
	os.write_file(os.join_path(target, 'sitemap.xml'), xml)!
}

// edit_target is the GitHub edit URL for one page.
fn edit_target(locale Locale, href string) string {
	prefix := if locale.code == 'en' {
		'src/'
	} else {
		'translations/${locale.code}/src/'
	}
	return '${repo_url}/edit/main/${prefix}${href}'
}

// extract_title finds the first heading of a page, falling back to the summary
// entry when the page has no heading of its own.
fn extract_title(markdown string, fallback string) string {
	for line in markdown.replace('\r\n', '\n').split('\n') {
		t := line.trim_space()
		if t.starts_with('# ') {
			return strip_inline_marks(t[2..].trim_space())
		}
	}
	return strip_inline_marks(fallback)
}

// copy_dir copies a directory tree, creating destination parents as needed.
fn copy_dir(src string, dst string) ! {
	if !os.is_dir(src) {
		return error('not a directory: ${src}')
	}
	entries := os.ls(src)!
	for entry in entries {
		from := os.join_path(src, entry)
		to := os.join_path(dst, entry)
		if os.is_dir(from) {
			os.mkdir_all(to)!
			copy_dir(from, to)!
			continue
		}
		os.mkdir_all(os.dir(to))!
		os.cp(from, to)!
	}
}
