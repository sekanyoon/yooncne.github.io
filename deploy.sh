#!/usr/bin/env bash
# GitHub Pages ??: https://github.com/sekanyoon/yooncne.github.io
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
export PATH="$ROOT/.local/bin:$PATH"

REMOTE="https://github.com/sekanyoon/yooncne.github.io.git"

# GitHub CLI ??? ??
if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI? ????. ?? ???? ???? ?????:"
  echo "  ./setup-github-login.sh"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub? ????? ?? ????."
  echo "  ./setup-github-login.sh"
  echo "? ??? ? ?? ?????."
  exit 1
fi

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  git init
fi

git remote remove origin 2>/dev/null || true
git remote add origin "$REMOTE"
git branch -M main

echo "? GitHub? push ?..."
git push -u origin main

echo ""
echo "??. Pages ??:"
echo "  https://github.com/sekanyoon/yooncne.github.io/settings/pages"
echo "  (main ??? / root)"
echo ""
echo "??? URL:"
echo "  https://sekanyoon.github.io/yooncne.github.io/"
