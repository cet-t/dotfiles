#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── helpers ─────────────────────────────────────────────────────────
link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    echo "Backup: $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -s "$src" "$dst"
  echo "Linked: $src -> $dst"
}

install_pkg() {
  if command -v apt-get &>/dev/null; then
    sudo apt-get install -y "$@"
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y "$@"
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm "$@"
  else
    echo "Unknown package manager. Install manually: $*" && exit 1
  fi
}

# ── detect OS ───────────────────────────────────────────────────────
OS="$(uname -s)"
case "$OS" in
  Linux|Darwin) ;;
  MINGW*|CYGWIN*|MSYS*) echo "Windows: use install.ps1 instead" && exit 1 ;;
  *) echo "Unknown OS: $OS" && exit 1 ;;
esac

# ── packages ────────────────────────────────────────────────────────
echo "==> Installing packages..."

# zsh
if ! command -v zsh &>/dev/null; then
  install_pkg zsh
fi

# git
if ! command -v git &>/dev/null; then
  install_pkg git
fi

# neovim
if ! command -v nvim &>/dev/null; then
  echo "Installing Neovim..."
  if command -v apt-get &>/dev/null; then
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install -y neovim
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm neovim
  else
    echo "Install Neovim manually: https://neovim.io"
  fi
fi

# rust
if ! command -v cargo &>/dev/null; then
  echo "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# starship
if ! command -v starship &>/dev/null; then
  echo "Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# node (markdown-preview 用)
if ! command -v node &>/dev/null; then
  echo "Installing Node.js..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  install_pkg nodejs
fi

# ── symlinks ────────────────────────────────────────────────────────
echo "==> Creating symlinks..."

# nvim
link "$DOTFILES/nvim" "$HOME/.config/nvim"

# zsh
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

# wezterm (Linux desktop の場合)
if [ -n "${DISPLAY:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ]; then
  link "$DOTFILES/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"
fi

# ── set default shell to zsh ────────────────────────────────────────
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "==> Setting zsh as default shell..."
  chsh -s "$(which zsh)"
fi

echo ""
echo "Done! Start a new shell session, then run 'nvim' to install plugins."
