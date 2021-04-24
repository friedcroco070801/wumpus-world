'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "2d90a829402afe885e74e4edc127506b",
"assets/assets/fonts/rainyhearts.ttf": "069fb64d1f685b25507f0ece8707f4ab",
"assets/assets/images/ButtonArrow.png": "8b27149c744e8a485607676ddd6a9d34",
"assets/assets/images/ButtonArrowDisable.png": "087db7aa885a83b1891770d610ed29e8",
"assets/assets/images/Buttond.png": "d13905fe230d05d540525b4088a6b6d1",
"assets/assets/images/ButtondDisable.png": "5bd692c5df019a5e9a171915f72da624",
"assets/assets/images/Buttonl.png": "590df9b5318900d58c39ea1e1ffa014d",
"assets/assets/images/ButtonlDisable.png": "81e3de099ed9cc95ce876a37fe1624b8",
"assets/assets/images/Buttonr.png": "a720f5a9e52093a64093ac92ee3a5956",
"assets/assets/images/ButtonrDisable.png": "0b3ce287c037cf6ac0783a8a6494cfb4",
"assets/assets/images/ButtonReturn.png": "4c209df7333d377598007518a8c9da56",
"assets/assets/images/ButtonReturnDisable.png": "b8fc0116851c77752d06bb1c7d521091",
"assets/assets/images/Buttonu.png": "46ed078fdbee7ef447ea6f0744368e73",
"assets/assets/images/ButtonuDisable.png": "f181bfb24c2fc028d1d2419701ce15b1",
"assets/assets/images/DeadBody.png": "e953fd7fb2dde06f4ee7629b1e76629a",
"assets/assets/images/Door.png": "ad165b715a3d27ea54ba50d63d165559",
"assets/assets/images/Goal.png": "dd77992bc4ad705bcee267d3ab8328d2",
"assets/assets/images/Pit.png": "9b3e57e51c9ad5863be8cbc60a07aaa4",
"assets/assets/images/Player.png": "9600f5ca45e21944c259d2ca8afc3601",
"assets/assets/images/PlayerArrowd0.png": "b7b5ed26daf46204d24fd3bddbd596dc",
"assets/assets/images/PlayerArrowd1.png": "469a7b1bf43b2ee616b0f6e6e49e8a0f",
"assets/assets/images/PlayerArrowd2.png": "469a7b1bf43b2ee616b0f6e6e49e8a0f",
"assets/assets/images/PlayerArrowd3.png": "f23e610f26644c1a926c15cf393e22ca",
"assets/assets/images/PlayerArrowl0.png": "2da61ccbb93541f9faf6a57340c94197",
"assets/assets/images/PlayerArrowl1.png": "75fb3e577b4e636852b1d33ccdb97d21",
"assets/assets/images/PlayerArrowl2.png": "a19bc0967b1cd2b43914ec5df9559964",
"assets/assets/images/PlayerArrowl3.png": "0c96a7e3dc1ab3751318b437d69526a6",
"assets/assets/images/PlayerArrowr0.png": "6f3baee544a3af5ec17fd7f2fef65c12",
"assets/assets/images/PlayerArrowr1.png": "62dd4d347c78f2b0780a5872f4da6da3",
"assets/assets/images/PlayerArrowr2.png": "05d2c62ca353ce6417569f73a4531a02",
"assets/assets/images/PlayerArrowr3.png": "cc6a25a0f912e9746e3f5444fd5360c4",
"assets/assets/images/PlayerArrowu0.png": "9a1ae33fbef03d2a71e19016667584a2",
"assets/assets/images/PlayerArrowu1.png": "3378bbebe728f65ed9ec8674464fda6b",
"assets/assets/images/PlayerArrowu2.png": "3378bbebe728f65ed9ec8674464fda6b",
"assets/assets/images/PlayerArrowu3.png": "573ade4471b54e3587bec4465d56d7a1",
"assets/assets/images/Playerd0.png": "d83997034b3b63bd60eefbe5820d4e38",
"assets/assets/images/Playerd1.png": "9600f5ca45e21944c259d2ca8afc3601",
"assets/assets/images/Playerd2.png": "28e52d306651641b9ad1062b6314bc79",
"assets/assets/images/Playerd3.png": "9600f5ca45e21944c259d2ca8afc3601",
"assets/assets/images/Playerl0.png": "abcd8b7db3f1bff3f8d2f85fa779719a",
"assets/assets/images/Playerl1.png": "81ad4e8ca05d012ea14aaceaef4493d5",
"assets/assets/images/Playerl2.png": "056a5a51466f2b17f27346628a63bdbe",
"assets/assets/images/Playerl3.png": "81ad4e8ca05d012ea14aaceaef4493d5",
"assets/assets/images/Playerr0.png": "5ab97b8efaad64c81b7ed526b161cfea",
"assets/assets/images/Playerr1.png": "59d1473406f6f8ca87e5e44b9992db91",
"assets/assets/images/Playerr2.png": "0f94e8cf42d12617ce799ecda8ae94a3",
"assets/assets/images/Playerr3.png": "59d1473406f6f8ca87e5e44b9992db91",
"assets/assets/images/Playeru0.png": "4e796e6b529b7d5801084e81524ec946",
"assets/assets/images/Playeru1.png": "15ea0d5772fe64fc44f2b302ec11e4be",
"assets/assets/images/Playeru2.png": "374e67c992f646c7099dbb8f57fcba3c",
"assets/assets/images/Playeru3.png": "15ea0d5772fe64fc44f2b302ec11e4be",
"assets/assets/images/Sound.png": "c02d808c409247fd3bc78c01e9c88a99",
"assets/assets/images/TutorialArrow.png": "84a767531c776bcc288980c28e72f805",
"assets/assets/images/TutorialDeadBody.png": "9808920c4c09adb6c29514f427d4af58",
"assets/assets/images/TutorialGoal.png": "e040af7881381695c8c2842331a59e32",
"assets/assets/images/TutorialPit.png": "9cd50fe9e5fb3a907ebbd8fc867b481b",
"assets/assets/images/TutorialSound.png": "8104397950864650ede51d719d0abb3f",
"assets/assets/images/TutorialWumpus.png": "a3b5c84e2c8b4d80b4d8fc6abba29e62",
"assets/assets/images/Walld.png": "0745936378510bb136d8a53bec33913d",
"assets/assets/images/Walldl.png": "5d242a05d9ed2a69bb529512c6018dbd",
"assets/assets/images/Walldr.png": "9b5f400b1c96edb2e2395d82c2e274c8",
"assets/assets/images/Walll.png": "e37a55cfeb2c25c2f320c32e4b91cfe4",
"assets/assets/images/Wallr.png": "494a951e1bb8ba12c6b531751c6dcc35",
"assets/assets/images/Wallu.png": "539b0654f528f6e4e9e7703c79802c44",
"assets/assets/images/Wallul.png": "0575a9f926a14efdb88e6af2292e033f",
"assets/assets/images/Wallur.png": "1840f8802ccd4f1b50e82bddc2132dbb",
"assets/assets/images/Wumpus.png": "fdd88bdefe11246718ca43bef657484a",
"assets/assets/images/WumpusBlack.png": "a3b5c84e2c8b4d80b4d8fc6abba29e62",
"assets/assets/images/WumpusDead.png": "5338234096791693b5b771d79c7b375d",
"assets/assets/images/WumpusLose0.png": "c1f384915449ad5202286f204c6833fc",
"assets/assets/images/WumpusLose1.png": "4ac902dc2f0c3ea4299ba2d2c8f1c3c8",
"assets/FontManifest.json": "4c7acf7e8ba83f5ffa2b08d76ed743cf",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "e606e37dd608c5f541e2b1fd8307963c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "2c2723f979cd8149aef76d8fa19eab40",
"/": "2c2723f979cd8149aef76d8fa19eab40",
"main.dart.js": "20a07b8544574f0aa655aa5854c157cf",
"manifest.json": "feedc23aedf8ac9b769ce67b7663e2eb",
"version.json": "e30e90439590e73bf379b16095550d01"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
