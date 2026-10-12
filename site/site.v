module main

import strings

// base_path is where the book is published, including the leading slash. It is
// the project subdirectory GitHub Pages serves the book under.
const base_path = '/v-book/'

// site_name is what the header shows next to the logo.
const site_name = 'The V Book'

// site_tagline sits under the name in the header, the way the tour labels its
// edition.
const site_tagline = 'V 0.5.2+'

// repo_url is where the sources live.
const repo_url = 'https://github.com/metif12/v-book'

// NavEntry is one link in the table of contents.
struct NavEntry {
	title string
	href  string // 'ch01-getting-started.md', or '' for a part heading
	part  string // the part heading this entry sits under, '' for the front matter
	depth int
}

// Locale describes one language the book is published in.
struct Locale {
	code    string // 'en', 'de', ...
	name    string // native name
	english string // English name
	dir     string // 'ltr' or 'rtl'
}

// locales is every published language, English first.
const locales = [
	Locale{'en', 'English', 'English', 'ltr'},
	Locale{'de', 'Deutsch', 'German', 'ltr'},
	Locale{'es', 'Español', 'Spanish', 'ltr'},
	Locale{'fr', 'Français', 'French', 'ltr'},
	Locale{'zh', '简体中文', 'Chinese', 'ltr'},
	Locale{'ru', 'Русский', 'Russian', 'ltr'},
	Locale{'ja', '日本語', 'Japanese', 'ltr'},
	Locale{'ko', '한국어', 'Korean', 'ltr'},
	Locale{'pt', 'Português', 'Portuguese', 'ltr'},
	Locale{'it', 'Italiano', 'Italian', 'ltr'},
	Locale{'ar', 'العربية', 'Arabic', 'rtl'},
	Locale{'fa', 'فارسی', 'Persian', 'rtl'},
	Locale{'hi', 'हिन्दी', 'Hindi', 'ltr'},
	Locale{'bn', 'বাংলা', 'Bengali', 'ltr'},
	Locale{'ur', 'اردو', 'Urdu', 'rtl'},
	Locale{'id', 'Bahasa Indonesia', 'Indonesian', 'ltr'},
	Locale{'tr', 'Türkçe', 'Turkish', 'ltr'},
]

// parse_summary reads SUMMARY.md into navigation entries.
//
// Part headings become entries with an empty href, so the table of contents can
// group the chapters under them.
pub fn parse_summary(src string) []NavEntry {
	mut out := []NavEntry{}
	mut part := ''
	for line in src.replace('\r\n', '\n').split('\n') {
		mut s := line.trim_space()
		if s == '' {
			continue
		}
		mut depth := 0
		for depth < s.len && s[depth] == ` ` {
			depth++
		}
		// A list marker ('-' or '*') followed by a space.
		if s.len > depth + 1 && (s[depth] == `-` || s[depth] == `*`) && s[depth + 1] == ` ` {
			s = s[depth + 1..].trim_space()
			depth = (depth / 2) + 1
		} else if s.starts_with('#') {
			title := s.trim_string_left('#').trim_space()
			if title == '' || title == 'Summary' {
				continue
			}
			part = title
			out << NavEntry{
				title: title
				href:  ''
				part:  ''
				depth: 0
			}
			continue
		} else {
			depth = 1
		}
		if !s.starts_with('[') {
			continue
		}
		// The link text may itself contain parentheses — several translations
		// put the English term in brackets after the translated one — so the
		// href is taken between the *last* bracket pair on the line.
		rb := s.last_index(']') or { continue }
		if !s[rb..].starts_with('](') {
			continue
		}
		rp := s.last_index(')') or { continue }
		title := s[..rb].trim_string_left('[').trim_space()
		href := s[rb + 2..rp]
		out << NavEntry{
			title: title
			href:  href
			part:  part
			depth: depth
		}
	}
	return out
}

// pages_only drops the part headings from the navigation.
fn pages_only(entries []NavEntry) []NavEntry {
	mut out := []NavEntry{}
	for e in entries {
		if e.href != '' {
			out << e
		}
	}
	return out
}

// page_url is the address of one page in one language.
pub fn page_url(locale Locale, href string) string {
	file := href.replace('.md', '.html')
	if locale.code == 'en' {
		return base_path + file
	}
	return base_path + locale.code + '/' + file
}

// locale_dir is the directory a language is published in, '' for English.
pub fn locale_dir(locale Locale) string {
	return if locale.code == 'en' { '' } else { locale.code + '/' }
}

// locale_root is the first page of a language.
pub fn locale_root(locale Locale, entries []NavEntry) string {
	for e in entries {
		if e.href != '' {
			return page_url(locale, e.href)
		}
	}
	return base_path
}

// build_toc renders the sidebar for one page.
pub fn build_toc(entries []NavEntry, locale Locale, current string) string {
	mut sb := strings.new_builder(4096)
	sb.write_string('<nav class="toc" id="toc" aria-label="Contents">\n')
	sb.write_string('<div class="toc-head">\n')
	sb.write_string('<a class="toc-home" href="${base_path}">\n')
	sb.write_string('<img class="toc-logo" src="${base_path}logo.svg" alt="" width="22" height="22">\n')
	sb.write_string('<span class="toc-title">${site_name}</span>\n</a>\n')
	sb.write_string('<p class="toc-sub">${site_tagline}</p>\n')
	sb.write_string('</div>\n')
	sb.write_string('<div class="toc-scroll">\n')
	for e in entries {
		if e.href == '' {
			sb.write_string('<p class="toc-part">${escape_text(e.title)}</p>\n')
			continue
		}
		cls := if e.href == current { 'toc-link current' } else { 'toc-link' }
		indent := if e.depth > 1 { ' toc-nested' } else { '' }
		sb.write_string('<a class="${cls}${indent}" href="${page_url(locale, e.href)}">${escape_text(e.title)}</a>\n')
	}
	sb.write_string('</div>\n')
	sb.write_string('</nav>\n')
	return sb.str()
}

// lang_menu renders the language switcher.
//
// Switching language keeps the reader on the same page, which is the behaviour
// the selector in the header promises.
pub fn lang_menu(current string, href string) string {
	mut sb := strings.new_builder(2048)
	sb.write_string('<div class="lang-menu" id="lang-menu" hidden>\n')
	sb.write_string('<p class="lang-menu-title">Language</p>\n')
	file := href.replace('.md', '.html')
	for l in locales {
		target := if l.code == 'en' { base_path + file } else { base_path + l.code + '/' + file }
		mark := if l.code == current { ' aria-current="true"' } else { '' }
		cls := if l.code == current { 'lang-item current' } else { 'lang-item' }
		sb.write_string('<a class="${cls}" href="${target}"${mark} lang="${l.code}" dir="${l.dir}">\n')
		sb.write_string('<span class="lang-native">${escape_text(l.name)}</span>\n')
		sb.write_string('<span class="lang-english">${escape_text(l.english)}</span>\n')
		sb.write_string('</a>\n')
	}
	sb.write_string('</div>\n')
	return sb.str()
}

// ui holds the chrome labels, which change with the language.
struct Ui {
	search       string
	close_search string
	contents     string
	language     string
	theme        string
	edit         string
	source       string
	previous     string
	next         string
	no_results   string
	result_count string
}

// ui_en is the English chrome copy.
fn ui_en() Ui {
	return Ui{
		search:       'Search the book'
		close_search: 'Close search'
		contents:     'Contents'
		language:     'Language'
		theme:        'Toggle theme'
		edit:         'Edit this page on GitHub'
		source:       'Source on GitHub'
		previous:     'Previous'
		next:         'Next'
		no_results:   'No pages match'
		result_count: 'result'
	}
}

// ui_for picks the chrome copy for a locale. Every language shows the English
// label until a translation ships, and the fallback is visible in the menu.
fn ui_for(locale Locale) Ui {
	match locale.code {
		'de' {
			return Ui{
				search:       'Buch durchsuchen'
				close_search: 'Suche schließen'
				contents:     'Inhalt'
				language:     'Sprache'
				theme:        'Design wechseln'
				edit:         'Diese Seite auf GitHub bearbeiten'
				source:       'Quellcode auf GitHub'
				previous:     'Zurück'
				next:         'Weiter'
				no_results:   'Keine Treffer'
				result_count: 'Treffer'
			}
		}
		'zh' {
			return Ui{
				search:       '搜索本书'
				close_search: '关闭搜索'
				contents:     '目录'
				language:     '语言'
				theme:        '切换主题'
				edit:         '在 GitHub 上编辑此页'
				source:       'GitHub 源码'
				previous:     '上一页'
				next:         '下一页'
				no_results:   '没有匹配的页面'
				result_count: '条结果'
			}
		}
		else {
			return ui_en()
		}
	}
}

// render_page wraps rendered content in the shared page shell.
pub fn render_page(opts PageOpts) string {
	locale := opts.locale
	dir := locale.dir
	dir_prefix := locale_dir(locale)
	ui := ui_for(locale)
	mut out := strings.new_builder(8192)
	out.write_string('<!doctype html>\n<html lang="${locale.code}" dir="${dir}" data-theme="light">\n<head>\n')
	out.write_string('<meta charset="utf-8">\n')
	out.write_string('<meta name="viewport" content="width=device-width, initial-scale=1.0">\n')
	out.write_string('<title>${escape_attr(opts.title)}</title>\n')
	out.write_string('<meta name="description" content="${escape_attr(opts.description)}">\n')
	out.write_string('<link rel="stylesheet" href="${base_path}app.css">\n')
	out.write_string('<link rel="stylesheet" href="${base_path}book.css">\n')
	out.write_string('<link rel="stylesheet" href="${base_path}codemirror/lib/codemirror.css">\n')
	out.write_string('<link rel="icon" href="${base_path}logo.svg" type="image/svg+xml">\n')
	out.write_string('</head>\n<body>\n')
	// Header
	out.write_string('<header class="top-bar">\n')
	out.write_string('<button class="bar-button toc-button" id="toc-toggle" aria-label="${escape_attr(ui.contents)}" aria-expanded="false" aria-controls="toc">\n')
	out.write_string('<svg width="22" height="22" viewBox="0 0 24 24" aria-hidden="true"><path d="M3 6h18M3 12h18M3 18h18" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round"/></svg>\n')
	out.write_string('</button>\n')
	out.write_string('<a class="brand" href="${base_path}">\n')
	out.write_string('<img class="brand-logo" src="${base_path}logo.svg" alt="" width="26" height="26">\n')
	out.write_string('<span class="brand-text">\n<span class="brand-name">${site_name}</span>\n')
	out.write_string('<span class="brand-sub">${site_tagline}</span>\n</span>\n</a>\n')
	out.write_string('<div class="search-scrim" id="search-scrim" hidden></div>\n')
	out.write_string('<form class="search" id="search-form" role="search" autocomplete="off">\n')
	out.write_string('<div class="search-row">\n')
	out.write_string('<span class="search-icon" aria-hidden="true">\n<svg width="17" height="17" viewBox="0 0 24 24"><circle cx="10.5" cy="10.5" r="6.5" stroke="currentColor" stroke-width="2" fill="none"/><path d="M15.5 15.5L21 21" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>\n</span>\n')
	out.write_string('<input class="search-input" id="search-input" type="search" placeholder="${escape_attr(ui.search)}" aria-label="${escape_attr(ui.search)}" autocomplete="off" spellcheck="false">\n')
	out.write_string('<kbd class="search-kbd" aria-hidden="true">Ctrl K</kbd>\n')
	out.write_string('<button class="search-close" id="search-close" type="button" aria-label="${escape_attr(ui.close_search)}" title="${escape_attr(ui.close_search)}">\n<svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true"><path d="M6 6l12 12M18 6L6 18" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>\n</button>\n')
	out.write_string('</div>\n')
	out.write_string('<div class="search-panel" id="search-panel" role="listbox" aria-label="${escape_attr(ui.search)}" hidden></div>\n')
	out.write_string('</form>\n')
	out.write_string('<button class="bar-button search-toggle" id="search-toggle" aria-label="${escape_attr(ui.search)}" aria-expanded="false">\n')
	out.write_string('<svg width="21" height="21" viewBox="0 0 24 24" aria-hidden="true"><circle cx="10.5" cy="10.5" r="6.5" stroke="currentColor" stroke-width="2" fill="none"/><path d="M15.5 15.5L21 21" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>\n')
	out.write_string('</button>\n')
	out.write_string('<div class="top-bar-actions">\n')
	out.write_string('<a class="bar-button" href="${repo_url}" target="_blank" rel="noopener" title="${escape_attr(ui.source)}" aria-label="${escape_attr(ui.source)}">\n')
	out.write_string('<svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 .5A11.5 11.5 0 0 0 .5 12a11.5 11.5 0 0 0 7.86 10.92c.58.1.79-.25.79-.55v-2.1c-3.2.7-3.88-1.4-3.88-1.4-.53-1.32-1.28-1.68-1.28-1.68-1.05-.71.08-.7.08-.7 1.16.09 1.77 1.18 1.77 1.18 1.03 1.76 2.7 1.25 3.36.96.1-.75.4-1.25.73-1.54-2.55-.29-5.24-1.28-5.24-5.7 0-1.26.45-2.29 1.18-3.1-.12-.29-.51-1.46.11-3.05 0 0 .96-.3 3.15 1.18a10.9 10.9 0 0 1 5.74 0c2.18-1.48 3.14-1.18 3.14-1.18.63 1.59.24 2.76.12 3.05.74.81 1.18 1.84 1.18 3.1 0 4.43-2.7 5.4-5.26 5.69.41.36.78 1.06.78 2.14v3.17c0 .3.2.66.8.55A11.5 11.5 0 0 0 23.5 12A11.5 11.5 0 0 0 12 .5z" fill="currentColor"/></svg>\n')
	out.write_string('</a>\n')
	out.write_string('<a class="bar-button" href="${escape_attr(opts.edit_url)}" title="${escape_attr(ui.edit)}" aria-label="${escape_attr(ui.edit)}">\n')
	out.write_string('<svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true"><path d="M4 20h4l10-10-4-4L4 16v4z" stroke="currentColor" stroke-width="2" fill="none" stroke-linejoin="round"/><path d="M13.5 6.5l4 4" stroke="currentColor" stroke-width="2"/></svg>\n')
	out.write_string('</a>\n')
	out.write_string('<div class="menu-wrap">\n')
	out.write_string('<button class="bar-button" id="lang-toggle" aria-label="${escape_attr(ui.language)}" aria-expanded="false" aria-haspopup="true" aria-controls="lang-menu">\n')
	out.write_string('<svg width="22" height="22" viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="2" fill="none"/><path d="M3 12h18M12 3c2.6 2.8 2.6 15.2 0 18M12 3c-2.6 2.8-2.6 15.2 0 18" stroke="currentColor" stroke-width="2" fill="none"/></svg>\n')
	out.write_string('</button>\n')
	out.write_string('${lang_menu(locale.code, opts.page_href)}\n')
	out.write_string('</div>\n')
	out.write_string('<button class="bar-button" id="theme-toggle" aria-label="${escape_attr(ui.theme)}" aria-pressed="false">\n')
	out.write_string('<svg class="icon-theme-light" width="22" height="22" viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="4.5" fill="currentColor"/><path d="M12 2v2M12 20v2M2 12h2M20 12h2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M19.1 4.9l-1.4 1.4M6.3 17.7l-1.4 1.4" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round"/></svg>\n')
	out.write_string('<svg class="icon-theme-dark" width="22" height="22" viewBox="0 0 24 24" aria-hidden="true"><path d="M20 14.5A8.5 8.5 0 0 1 9.5 4a8.5 8.5 0 1 0 10.5 10.5z" fill="currentColor"/></svg>\n')
	out.write_string('</button>\n')
	out.write_string('</div>\n')
	out.write_string('</header>\n')
	// Layout
	out.write_string('<div class="layout">\n')
	out.write_string('${opts.toc}\n')
	out.write_string('<div class="click-catcher" id="toc-catcher" hidden></div>\n')
	out.write_string('<main class="content" id="content">\n')
	out.write_string('<div class="container" id="container">\n')
	out.write_string('<article class="prose" id="prose">\n')
	out.write_string('${opts.body}\n')
	out.write_string('</article>\n')
	out.write_string('<nav class="pager" aria-label="Page navigation">\n')
	out.write_string(pager_link(opts.prev_url, opts.prev_text, 'prev-page', ui.previous, 'prev'))
	out.write_string('<span class="counter">${escape_text(opts.counter)}</span>\n')
	out.write_string(pager_link(opts.next_url, opts.next_text, 'next-page', ui.next, 'next'))
	out.write_string('</nav>\n')
	out.write_string('<footer class="page-footer">\n')
	out.write_string('<span>${site_name} · <a href="${repo_url}" target="_blank" rel="noopener">${repo_url.replace('https://', '')}</a></span>\n')
	out.write_string('<span>${escape_text(opts.license_src)}</span>\n')
	out.write_string('</footer>\n')
	out.write_string('</div>\n')
	out.write_string('</main>\n')
	out.write_string('</div>\n')
	out.write_string('<script src="${base_path}codemirror/lib/codemirror.js"></script>\n')
	out.write_string('<script src="${base_path}codemirror/mode/vlang/vlang.js"></script>\n')
	out.write_string('<script src="${base_path}${dir_prefix}search-index.js"></script>\n')
	out.write_string('<script src="${base_path}app.js"></script>\n')
	out.write_string('</body>\n</html>\n')
	return out.str()
}

// PageOpts is everything a rendered page needs.
pub struct PageOpts {
	locale      Locale = Locale{'en', 'English', 'English', 'ltr'}
	title       string
	description string
	body        string
	toc         string
	prev_url    string
	prev_text   string
	next_url    string
	next_text   string
	counter     string
	edit_url    string
	license_src string = 'Released under the MIT license'
	page_href   string
}

fn pager_link(url string, text string, cls string, label string, dir string) string {
	if url == '' {
		return '<span class="pager-link ${cls} disabled" aria-disabled="true"></span>'
	}
	arrow := if dir == 'prev' { '←' } else { '→' }
	return '<a class="pager-link ${cls}" rel="${cls}" href="${url}" aria-label="${escape_attr(label)}">' +
		'<span class="pager-dir">${arrow}</span>' +
		'<span class="pager-text"><span class="pager-label">${escape_attr(label)}</span>' +
		'<span class="pager-title">${escape_text(text)}</span></span></a>'
}

// escape_text escapes text content.
pub fn escape_text(s string) string {
	return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
}

// escape_attr escapes a double quoted attribute value.
pub fn escape_attr(s string) string {
	return escape_text(s).replace('"', '&quot;')
}
