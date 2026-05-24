#!/usr/bin/env bash
# GitHub ???? ??? (?? ?? ?? ???)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
export PATH="$ROOT/.local/bin:$PATH"

install_gh() {
  if command -v gh >/dev/null 2>&1; then
    return
  fi
  if [ ! -x "$ROOT/.local/bin/gh" ]; then
    echo "? GitHub CLI ?? ?..."
    mkdir -p "$ROOT/.local/bin"
    ARCH=$(uname -m)
    case "$ARCH" in
      arm64) ZIP_ARCH="arm64" ;;
      x86_64) ZIP_ARCH="amd64" ;;
      *) echo "???? ?? ????: $ARCH"; exit 1 ;;
    esac
    TAG=$(curl -fsSL https://api.github.com/repos/cli/cli/releases/latest | sed -n 's/.*"tag_name": "v\(.*\)".*/\1/p')
    TMP=$(mktemp -d)
    curl -fsSL -o "$TMP/gh.zip" "https://github.com/cli/cli/releases/download/v${TAG}/gh_${TAG}_macOS_${ZIP_ARCH}.zip"
    unzip -qo "$TMP/gh.zip" -d "$TMP"
    cp "$TMP/gh_${TAG}_macOS_${ZIP_ARCH}/bin/gh" "$ROOT/.local/bin/gh"
    chmod +x "$ROOT/.local/bin/gh"
    rm -rf "$TMP"
  fi
  export PATH="$ROOT/.local/bin:$PATH"
}

install_gh

echo ""
echo "=========================================="
echo "  GitHub ???? ???"
echo "=========================================="
echo "  ? ????? ????, ?? ???"
echo "  https://github.com/login/device ? ?????."
echo "=========================================="
echo ""

gh auth login --web --git-protocol https --hostname github.com

# ? ?????? gh ?? ?? ?? (?? git config ?? ??)
GH_BIN="$ROOT/.local/bin/gh"
if ! command -v gh >/dev/null 2>&1; then
  GH_BIN=$(command -v gh)
fi

cd "$ROOT"
git config --local credential.helper ""
git config --local --add credential.helper "!\"$GH_BIN\" auth git-credential"

echo ""
echo "? ??? ??. ?? ./deploy.sh ? ???? ????? ?? ????."
gh auth status
