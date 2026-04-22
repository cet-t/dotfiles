#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_SRC="$DOTFILES/nvim"

# detect OS
case "$(uname -s)" in
  Linux|Darwin)
    NVIM_DST="$HOME/.config/nvim"
    ;;
  MINGW*|CYGWIN*|MSYS*)
    NVIM_DST="$APPDATA/../Local/nvim"
    ;;
  *)
    echo "Unknown OS: $(uname -s)" && exit 1
    ;;
esac

mkdir -p "$(dirname "$NVIM_DST")"

if [ -e "$NVIM_DST" ] || [ -L "$NVIM_DST" ]; then
  echo "Backup: $NVIM_DST -> ${NVIM_DST}.bak"
  mv "$NVIM_DST" "${NVIM_DST}.bak"
fi

ln -s "$NVIM_SRC" "$NVIM_DST"
echo "Linked: $NVIM_SRC -> $NVIM_DST"
echo "Done. Run 'nvim' to install plugins."
