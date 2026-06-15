#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

command -v stow >/dev/null 2>&1 || { echo "stow kurulu değil. Kur: sudo pacman -S stow"; exit 1; }

cd "$DOTFILES_DIR"

PACKAGES=(niri waybar kitty fuzzel zsh)

for pkg in "${PACKAGES[@]}"; do
    echo "Linking: $pkg"
    stow --restow "$pkg"
done

echo "Bitti. Tüm config'ler symlink'lendi."
