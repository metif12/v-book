/* The V Book service worker.
 *
 * A book is read offline — on a train, on a plane — so the shell is precached,
 * pages are served from the cache and refreshed in the background, and the
 * search index each page loads is cached the first time it is asked for.
 *
 * Nothing here needs a build step: the scope the worker is registered under is
 * the book's base path, so the same file serves every language.
 */
var CACHE = 'vbook-v1';
var BASE = new URL(self.registration.scope).pathname;

function shellUrls() {
	return [
		BASE,
		'app.css',
		'book.css',
		'app.js',
		'logo.svg',
		'manifest.webmanifest',
		'icon-192.png',
		'icon-512.png',
		'og-image.png',
		'codemirror/lib/codemirror.css',
		'codemirror/lib/codemirror.js',
		'codemirror/mode/vlang/vlang.js'
	].map(function (p) {
		return BASE + p;
	});
}

self.addEventListener('install', function (event) {
	event.waitUntil(
		caches.open(CACHE)
			.then(function (cache) {
				// A missing icon should not fail the whole install, so the
				// shell is added one URL at a time.
				return shellUrls().reduce(function (chain, url) {
					return chain.then(function () {
						return cache.add(new Request(url, { cache: 'reload' })).catch(function () {});
					});
				}, Promise.resolve());
			})
			.then(function () {
				return self.skipWaiting();
			})
	);
});

self.addEventListener('activate', function (event) {
	event.waitUntil(
		caches.keys()
			.then(function (names) {
				return names.filter(function (name) {
					return name !== CACHE;
				}).map(function (name) {
					return caches.delete(name);
				});
			})
			.then(function () {
				return self.clients.claim();
			})
	);
});

// stale-while-revalidate: the reader gets the page they have, and the next read
// of it is one commit newer.
function fromCache(request) {
	return caches.open(CACHE).then(function (cache) {
		return cache.match(request).then(function (hit) {
			var fresh = fetch(request).then(function (response) {
				if (response && response.ok) {
					cache.put(request, response.clone());
				}
				return response;
			}).catch(function () {
				return hit;
			});
			return hit || fresh;
		});
	});
}

self.addEventListener('fetch', function (event) {
	var request = event.request;
	if (request.method !== 'GET' || new URL(request.url).origin !== self.location.origin) {
		return;
	}
	if (request.mode === 'navigate') {
		event.respondWith(
			fetch(request)
				.then(function (response) {
					var copy = response.clone();
					caches.open(CACHE).then(function (cache) {
						cache.put(request, copy);
					});
					return response;
				})
				.catch(function () {
					// Offline, and the page was never read. The book's cover is
					// better than the browser's error page.
					return caches.match(request).then(function (hit) {
						return hit || caches.match(BASE);
					});
				})
		);
		return;
	}
	event.respondWith(
		fromCache(request).catch(function () {
			return fetch(request);
		})
	);
});

// A new version of the worker takes over as soon as the page asks it to, so a
// deploy does not need a second visit.
self.addEventListener('message', function (event) {
	if (event.data === 'skipWaiting') {
		self.skipWaiting();
	}
});
