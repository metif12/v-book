module main

import strings
import veb

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

// PageData is what the page shell template receives. Every string that carries
// HTML is a veb.RawHtml, so the template emits it verbatim, and everything the
// reader can write — a title, a label — is escaped in V before it lands here.
struct PageData {
	lang               string
	dir                string
	title              string
	description        string
	base               string
	site_name          string
	site_tagline       string
	repo_url           string
	repo_label         string
	license            string
	edit_url           string
	search_placeholder string
	search_close       string
	search_index_path  string
	ui_contents        string
	ui_language        string
	ui_theme           string
	ui_source          string
	ui_edit            string
	ui_previous        string
	ui_next            string
	toc                veb.RawHtml
	body               veb.RawHtml
	lang_menu          veb.RawHtml
	pager              veb.RawHtml
}

// render_page wraps rendered content in the shared page shell.
//
// The shell lives in site/templates/page.html, so the markup can be edited as
// HTML instead of as V string concatenation.
pub fn render_page(opts PageOpts) string {
	locale := opts.locale
	ui := ui_for(locale)
	prev_link := pager_link(opts.prev_url, opts.prev_text, 'prev-page', ui.previous, 'prev')
	next_link := pager_link(opts.next_url, opts.next_text, 'next-page', ui.next, 'next')
	page := PageData{
		lang:               escape_attr(locale.code)
		dir:                escape_attr(locale.dir)
		title:              escape_attr(opts.title)
		description:        escape_attr(opts.description)
		base:               base_path.trim_right('/')
		site_name:          escape_text(site_name)
		site_tagline:       escape_text(site_tagline)
		repo_url:           escape_attr(repo_url)
		repo_label:         escape_text(repo_url.replace('https://', ''))
		license:            escape_text(opts.license_src)
		edit_url:           escape_attr(opts.edit_url)
		search_placeholder: escape_attr(ui.search)
		search_close:       escape_attr(ui.close_search)
		search_index_path:  '${locale_dir(locale)}search-index.js'
		ui_contents:        escape_attr(ui.contents)
		ui_language:        escape_attr(ui.language)
		ui_theme:           escape_attr(ui.theme)
		ui_source:          escape_attr(ui.source)
		ui_edit:            escape_attr(ui.edit)
		ui_previous:        escape_attr(ui.previous)
		ui_next:            escape_attr(ui.next)
		toc:                veb.RawHtml(opts.toc)
		body:               veb.RawHtml(opts.body)
		lang_menu:          veb.RawHtml(lang_menu(locale.code, opts.page_href))
		pager:              veb.RawHtml(prev_link + '<span class="counter">${escape_text(opts.counter)}</span>' +
			next_link)
	}
	return $tmpl('templates/page.html', page)
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
