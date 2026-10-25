#!/usr/bin/env bash
# builds the home screen web app into site/ (github pages deploys that folder)
# wheel.html stays headless because it's also the artifact page, so the <head> bits for iOS get wrapped on here

set -euo pipefail
cd "$(dirname "$0")"
rm -rf site && mkdir -p site
cp icons/*.png site/

cat > site/manifest.webmanifest <<'JSON'
{
  "name": "OSRS Task Wheel",
  "short_name": "Task Wheel",
  "start_url": "./",
  "display": "standalone",
  "background_color": "#241e16",
  "theme_color": "#241e16",
  "icons": [
    { "src": "icon-192.png", "sizes": "192x192", "type": "image/png" },
    { "src": "icon-512.png", "sizes": "512x512", "type": "image/png" }
  ]
}
JSON

{
  cat <<'HEAD'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="Task Wheel">
<meta name="theme-color" content="#241e16">
<link rel="manifest" href="manifest.webmanifest">
<link rel="apple-touch-icon" href="icon-180.png">
<link rel="icon" href="icon-192.png">
<style>[hidden]{display:none!important} body{margin:0}</style>
</head>
<body>
HEAD
  cat wheel.html
  printf '\n</body>\n</html>\n'
} > site/index.html
echo "built site/"
