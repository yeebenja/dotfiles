# Dotfiles

## Configured Programs
ghostty
kitty
neovim
z-shell (with .zshrc)

## Kitty and Neovim Install
```bash
brew install kitty neovim 
brew install --cask ghostty
```

## GNU Stow Install
GNU Stow is a symbol farm manager. This makes managing my dotfiles easier.
```bash
brew install stow 
```

## Steps
First, create backups of your current config files. For example, rename ~/.zshrc to ~/.zshrc_backup. Do this for all of your current config files.
```bash
git clone https://github.com/yeebenja/dotfiles.git
cd dotfiles
brew install stow
stow .
```

## Fonts
Make sure to install fonts. fonts are in .config/nvim/fonts/

## DS_Store Being Annoying?
```bash
vim ~/.stow-global-ignore
```
Add the following line
```
\.DS_Store
```

