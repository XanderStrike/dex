
self.addEventListener('install', function (e) {
  e.waitUntil(
    caches.open('dex').then(function (cache) {
      return cache.addAll([
        '/',
        '/colors.css',
        '/favicon.ico',
        '/icon.png',
        '/index.html',
        '/mustache.min.js',
        '/names.json',
        '/weaknesses.json',
      ]);
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.open('dex').then(function (cache) {
      return cache.match(event.request).then(function (response) {
        return response || fetch(event.request).then(function (response) {
          cache.put(event.request, response.clone());
          return response;
        });
      });
    })
  );
});
