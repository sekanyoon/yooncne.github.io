#!/usr/bin/env bash
# GitHub Pages ??: https://github.com/sekanyoon/yooncne.github.io
set -euo pipefail
cd "$(dirname "$0")"

REMOTE="https://github.com/sekanyoon/yooncne.github.io.git"

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  git init
fi

git remote remove origin 2>/dev/null || true
git remote add origin "$REMOTE"
git branch -M main

if ! git rev-parse HEAD >/dev/null 2>&1; then
  git add index.html css/ js/ assets/ .nojekyll README.md .gitignore
  git commit -m "Add static portfolio site"
fi

echo "? GitHub? push ?..."
git push -u origin main

echo ""
echo "??. GitHub?? Pages ??? ?????:"
echo "  https://github.com/sekanyoon/yooncne.github.io/settings/pages"
echo "  Source: Deploy from a branch ? main ? / (root)"
echo ""
echo "??? URL (???? 1~2?):"
echo "  https://sekanyoon.github.io/yooncne.github.io/"
