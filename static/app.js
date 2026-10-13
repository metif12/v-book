/* The V Book — browser behaviour.
 *
 * The tour's behaviour, kept where a book needs it: a resolved theme, a table of
 * contents that becomes a drawer on a narrow screen, a language menu, keyboard
 * navigation between pages, and a full text search over the index that ships
 * with the page. No network calls, so the book works from any static host.
 */
(function () {
	'use strict';

	var doc = document;
	var root = doc.documentElement;
	var THEME_KEY = 'vbook-theme';

	/* Theme ------------------------------------------------------------- */

	function storedTheme() {
		try {
			var t = window.localStorage.getItem(THEME_KEY);
			if (t === 'light' || t === 'dark' || t === 'auto') return t;
		} catch (e) { /* storage blocked, fall through to the system setting */ }
		return null;
	}

	function systemDark() {
		return !!(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches);
	}

	// The stylesheet is keyed on the resolved value, so "auto" is resolved here
	// once and written to the document element.
	function applyTheme(pref) {
		var resolved = pref === 'dark' || (pref !== 'light' && systemDark()) ? 'dark' : 'light';
		root.setAttribute('data-theme', resolved);
		try {
			window.localStorage.setItem(THEME_KEY, pref || 'auto');
		} catch (e) { /* ignore */ }
		var toggle = doc.getElementById('theme-toggle');
		if (toggle) toggle.setAttribute('aria-pressed', String(resolved === 'dark'));
	}

	function toggleTheme() {
		applyTheme(root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark');
	}

	/* Panels ------------------------------------------------------------ */

	function show(el, on) {
		if (!el) return;
		el.hidden = !on;
	}

	function setExpanded(el, open) {
		if (el) el.setAttribute('aria-expanded', String(open));
	}

	var toc = doc.getElementById('toc');
	var catcher = doc.getElementById('toc-catcher');
	var langMenu = doc.getElementById('lang-menu');
	var langToggle = doc.getElementById('lang-toggle');
	var tocToggle = doc.getElementById('toc-toggle');

	function closeMenus() {
		show(langMenu, false);
		setExpanded(langToggle, false);
		closeSearch();
	}

	if (tocToggle) {
		tocToggle.addEventListener('click', function () {
			var open = toc.classList.toggle('open');
			show(catcher, open);
			setExpanded(tocToggle, open);
		});
	}

	if (catcher) {
		catcher.addEventListener('click', function () {
			toc.classList.remove('open');
			show(catcher, false);
			setExpanded(tocToggle, false);
		});
	}

	if (langToggle) {
		langToggle.addEventListener('click', function (e) {
			e.stopPropagation();
			var open = langMenu.hidden;
			show(langMenu, open);
			setExpanded(langToggle, open);
		});
	}

	doc.addEventListener('click', function (e) {
		if (langMenu.hidden) return;
		if (langMenu.contains(e.target) || e.target === langToggle) return;
		show(langMenu, false);
		setExpanded(langToggle, false);
	});

	var themeToggle = doc.getElementById('theme-toggle');
	if (themeToggle) themeToggle.addEventListener('click', toggleTheme);

	if (window.matchMedia) {
		var mq = window.matchMedia('(prefers-color-scheme: dark)');
		var onSystemChange = function () {
			if ((storedTheme() || 'auto') === 'auto') applyTheme('auto');
		};
		if (mq.addEventListener) mq.addEventListener('change', onSystemChange);
		else if (mq.addListener) mq.addListener(onSystemChange);
	}

	/* Keyboard navigation between pages --------------------------------- */

	var prevLink = doc.querySelector('.pager a.prev-page');
	var nextLink = doc.querySelector('.pager a.next-page');

	doc.addEventListener('keydown', function (e) {
		if (e.target && /^(INPUT|TEXTAREA|SELECT)$/.test(e.target.tagName)) return;
		if (e.key === 'PageDown' && nextLink) { e.preventDefault(); window.location.href = nextLink.href; }
		if (e.key === 'PageUp' && prevLink) { e.preventDefault(); window.location.href = prevLink.href; }
	});

	/* Search ------------------------------------------------------------ */

	var input = doc.getElementById('search-input');
	var panel = doc.getElementById('search-panel');
	var form = doc.getElementById('search-form');
	var searchToggle = doc.getElementById('search-toggle');
	var scrim = doc.getElementById('search-scrim');
	var searchClose = doc.getElementById('search-close');
	var index = window.SEARCH_INDEX || [];
	var results = [];
	var active = -1;
	var timer = 0;

	// On a narrow screen the form is a full screen overlay. openSearchSheet
	// shows the scrim with it, and closeSearchSheet takes both away.
	function openSearchSheet() {
		if (form) form.classList.add('open');
		if (scrim) scrim.hidden = false;
		if (searchToggle) searchToggle.setAttribute('aria-expanded', 'true');
	}

	function closeSearchSheet() {
		if (form) form.classList.remove('open');
		if (scrim) scrim.hidden = true;
		if (searchToggle) searchToggle.setAttribute('aria-expanded', 'false');
	}

	if (searchToggle) {
		searchToggle.addEventListener('click', function () {
			openSearchSheet();
			if (input) {
				input.focus();
				input.select();
			}
		});
	}

	// The close button and the scrim both take the overlay away, and the focus
	// goes back to the button that opened it.
	if (searchClose) {
		searchClose.addEventListener('click', function () {
			closeSearch();
			closeSearchSheet();
			if (searchToggle) searchToggle.focus();
		});
	}

	if (scrim) {
		scrim.addEventListener('click', function () {
			closeSearch();
			closeSearchSheet();
		});
	}

	function escapeHtml(s) {
		return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
			.replace(/"/g, '&quot;');
	}

	function escapeRegExp(s) {
		return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
	}

	// highlight escapes first and then wraps each term, so a term is never
	// treated as markup.
	function highlight(text, terms) {
		var out = escapeHtml(text);
		for (var i = 0; i < terms.length; i++) {
			if (!terms[i]) continue;
			out = out.replace(new RegExp('(' + escapeRegExp(terms[i]) + ')', 'gi'), '<mark>$1</mark>');
		}
		return out;
	}

	// score ranks a document: a hit in the title outweighs any number of hits in
	// the body, a phrase hit outweighs the sum of its words, and an early word
	// boundary hit outweighs a hit inside a longer word.
	function score(doc, terms, phrase) {
		var title = doc.title.toLowerCase();
		var text = doc.text.toLowerCase();
		var part = (doc.part || '').toLowerCase();
		var s = 0;
		for (var i = 0; i < terms.length; i++) {
			var t = terms[i];
			if (!t) continue;
			if (title === t) { s += 26; continue; }
			var at = title.indexOf(t);
			if (at !== -1) {
				s += 14;
				if (at === 0 || /[^a-z0-9]/.test(title.charAt(at - 1))) s += 6;
			}
			var first = text.indexOf(t);
			if (first === -1) return -1;
			var count = 0;
			var from = 0;
			for (;;) {
				var at2 = text.indexOf(t, from);
				if (at2 === -1) break;
				count++;
				from = at2 + t.length;
				if (count > 40) break;
			}
			s += Math.min(count, 20);
			var before = text.charAt(first - 1);
			if (first === 0 || /[^a-z0-9]/.test(before)) s += 4;
		}
		if (phrase.length > 1 && text.indexOf(phrase) !== -1) s += 18;
		if (part && phrase && part.indexOf(phrase) !== -1) s += 6;
		return s;
	}

	function snippet(text, terms) {
		var lower = text.toLowerCase();
		var at = -1;
		for (var i = 0; i < terms.length; i++) {
			if (!terms[i]) continue;
			at = lower.indexOf(terms[i]);
			if (at !== -1) break;
		}
		var from = at === -1 ? 0 : Math.max(0, at - 60);
		var raw = text.substr(from, 260);
		if (raw.length === 260) raw = raw.replace(/\s+\S*$/, '') + '…';
		return (from > 0 ? '…' : '') + highlight(raw, terms);
	}

	function render() {
		var q = input.value.trim().toLowerCase();
		var terms = q.split(/\s+/).filter(Boolean);
		results = [];
		if (terms.length === 0) { closeSearch(); return; }
		for (var i = 0; i < index.length; i++) {
			var s = score(index[i], terms, q);
			if (s > 0) results.push({ doc: index[i], score: s });
		}
		results.sort(function (a, b) { return b.score - a.score; });
		results = results.slice(0, 25);
		active = -1;

		if (results.length === 0) {
			panel.innerHTML = '<div class="search-empty">No pages match</div>';
			show(panel, true);
			return;
		}
		var html = '<div class="search-head"><span class="search-count">' +
			results.length + (results.length === 1 ? ' result' : ' results') +
			'</span><span class="search-hint">↑↓ move · Enter open · Esc close</span></div>';
		for (var k = 0; k < results.length; k++) {
			var d = results[k].doc;
			html += '<a class="search-result" role="option" href="' + d.url + '">';
			html += '<span class="search-result-part">' + escapeHtml(d.part || 'Book') + '</span>';
			html += '<span class="search-result-title">' + highlight(d.title, terms) + '</span>';
			html += '<span class="search-result-snippet">' + snippet(d.text, terms) + '</span>';
			html += '</a>';
		}
		panel.innerHTML = html;
		show(panel, true);
	}

	function closeSearch() {
		show(panel, false);
		active = -1;
		results = [];
	}

	function focusSearch() {
		if (!input) return;
		openSearchSheet();
		input.focus();
		input.select();
		if (input.value.trim() !== '') show(panel, true);
	}

	if (input) {
		input.addEventListener('input', function () {
			window.clearTimeout(timer);
			var self = this;
			timer = window.setTimeout(function () { render.call(self); }, 60);
		});
		input.addEventListener('keydown', function (e) {
			var items = panel.querySelectorAll('.search-result');
			if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
				e.preventDefault();
				if (items.length === 0) return;
				active = e.key === 'ArrowDown'
					? Math.min(active + 1, items.length - 1)
					: Math.max(active - 1, 0);
				for (var i = 0; i < items.length; i++) items[i].classList.toggle('active', i === active);
				items[active].scrollIntoView({ block: 'nearest' });
			} else if (e.key === 'Enter') {
				if (active >= 0 && results[active]) {
					e.preventDefault();
					window.location.href = results[active].doc.url;
				}
			} else if (e.key === 'Escape') {
				if (panel.hidden) { closeSearchSheet(); this.blur(); return; }
				closeSearch();
				closeSearchSheet();
				this.blur();
			}
		});
	}

	// Anything outside the overlay (including the scrim, which has its own
	// handler) takes it away, so a stray result never keeps the screen.
	doc.addEventListener('click', function (e) {
		if (!form || !form.classList.contains('open')) return;
		if (form.contains(e.target) || e.target === searchToggle) return;
		closeSearch();
		closeSearchSheet();
	});

	doc.addEventListener('click', function (e) {
		if (panel.hidden) return;
		if (panel.contains(e.target) || e.target === input) return;
		closeSearch();
	});

	// Ctrl+K (or Cmd+K) is the shortcut the header advertises; "/" is the one
	// people reach for anyway.
	doc.addEventListener('keydown', function (e) {
		if (!input) return;
		var isFind = (e.ctrlKey || e.metaKey) && (e.key === 'k' || e.key === 'K');
		if (isFind) { e.preventDefault(); focusSearch(); return; }
		if (e.key === '/' && doc.activeElement !== input) {
			e.preventDefault();
			focusSearch();
		}
	});

	/* Code blocks ------------------------------------------------------- */

	var blocks = doc.querySelectorAll('textarea.code-source');
	for (var i = 0; i < blocks.length; i++) {
		var ta = blocks[i];
		var shell = ta.parentNode;
		var code = ta.value;
		if (typeof CodeMirror === 'undefined') {
			// Without CodeMirror the block still has to be readable, so the
			// textarea becomes a plain pre rather than staying invisible.
			var pre = doc.createElement('pre');
			pre.className = 'code-fallback';
			pre.textContent = code;
			shell.replaceChild(pre, ta);
			continue;
		}
		var copy = doc.createElement('button');
		copy.type = 'button';
		copy.className = 'code-copy';
		copy.textContent = 'copy';
		// CodeMirror replaces the textarea, so the source is captured before
		// the conversion and the button copies what it captured.
		copy.addEventListener('click', function () {
			var label = this;
			var done = function () { label.textContent = 'copied'; };
			if (navigator.clipboard && navigator.clipboard.writeText) {
				navigator.clipboard.writeText(code).then(done, function () {});
			} else {
				var scratch = doc.createElement('textarea');
				scratch.value = code;
				doc.body.appendChild(scratch);
				scratch.select();
				try { doc.execCommand('copy'); done(); } catch (e) { /* ignore */ }
				doc.body.removeChild(scratch);
			}
		});
		shell.appendChild(copy);
		CodeMirror.fromTextArea(ta, {
			mode: 'vlang',
			readOnly: true,
			lineNumbers: true,
			viewportMargin: Infinity,
			lineWrapping: true
		});
	}

	/* The roadmap ------------------------------------------------------- */

	// Each node links to a chapter, so the diagram doubles as a progress map:
	// the reader's browser remembers which chapters have been opened, and this
	// page marks them. Nothing leaves the browser.
	var READ_KEY = 'vbook-read';

	function readPages() {
		try {
			var raw = window.localStorage.getItem(READ_KEY);
			var list = raw ? JSON.parse(raw) : [];
			return Array.isArray(list) ? list : [];
		} catch (e) {
			return [];
		}
	}

	function markRead(href) {
		var pages = readPages();
		var same = window.location.pathname;
		if (href === same) return; // the page the reader is on
		var base = root.getAttribute('data-base') || '/';
		if (href.indexOf(base) !== 0) return; // another language, or a link off-site
		if (pages.indexOf(href) !== -1) return;
		pages.push(href);
		try {
			window.localStorage.setItem(READ_KEY, JSON.stringify(pages));
		} catch (e) { /* storage blocked, the map just stays empty */ }
	}

	function relFromAbs(href) {
		var a = document.createElement('a');
		a.href = href;
		return a.pathname;
	}

	var roadmap = document.querySelector('.roadmap');
	if (roadmap) {
		var progress = document.getElementById('roadmap-progress');
		var reset = document.getElementById('roadmap-reset');
		var pages = readPages();
		var total = 0;
		var done = 0;
		var nodes = roadmap.querySelectorAll('.roadmap-link[href]');
		for (var i = 0; i < nodes.length; i++) {
			var rel = relFromAbs(nodes[i].getAttribute('href'));
			var node = nodes[i].parentNode;
			total++;
			if (pages.indexOf(rel) !== -1) {
				node.classList.add('is-read');
				done++;
			}
			if (window.location.pathname === rel) {
				node.classList.add('is-current');
				done++;
			}
		}
		if (progress) {
			progress.hidden = false;
			progress.textContent = done + ' of ' + total + ' opened';
		}
		if (reset) {
			reset.hidden = false;
			reset.addEventListener('click', function () {
				try {
					window.localStorage.removeItem(READ_KEY);
				} catch (e) { /* ignore */ }
				var all = roadmap.querySelectorAll('.roadmap-node');
				for (var j = 0; j < all.length; j++) {
					all[j].classList.remove('is-read');
				}
				if (progress) progress.textContent = '0 of ' + total + ' opened';
			});
		}
		markRead(window.location.pathname);
	}

	/* Start ------------------------------------------------------------- */

	applyTheme(storedTheme() || 'auto');

	/* Offline ----------------------------------------------------------- */

	// A book is read on a train, so the shell is cached and the pages the
	// reader opened stay readable without a connection. The worker is
	// registered from the page's base path, which the shell writes on <html>.
	if ('serviceWorker' in navigator && location.protocol !== 'file:') {
		var pwaBase = root.getAttribute('data-base') || '/';
		window.addEventListener('load', function () {
			var sw = navigator.serviceWorker;
			if (!sw) return;
			sw.register(pwaBase + 'sw.js').catch(function () {
				// No worker, no offline mode, nothing else changes.
			});
		});
	}
})();
