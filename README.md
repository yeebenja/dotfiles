# Dotfiles

## Configured Programs
```
ghostty
kitty
neovim
z-shell
pdbpp
```

## Neovim and Ghostty Install
ripgrep is for Spectre neovim plugin
```bash
brew install kitty neovim 
brew install --cask ghostty
brew install ripgrep
```

## GNU Stow Install
GNU Stow is a symbol farm manager. This makes managing my dotfiles easier.
```bash
brew install stow 
```

## Steps
First, create backups of your current config files. For example, rename ~/.zshrc to ~/.zshrc_backup. Do this for all of your current config files.
```bash
cd ~
git clone https://github.com/yeebenja/dotfiles.git
cd dotfiles
brew install stow
stow .
```

## Fonts
If you want to install custom fonts, make sure to install them. Fonts are in .config/nvim/fonts/
```bash
cd ~
cd dotfiles/.config/nvim/fonts/
ls
```

## DS_Store Being Annoying?
```bash
vim ~/.stow-global-ignore
```
Add the following line
```
\.DS_Store
```
## Map Caps Lock to Control (^) on Mac
Go to System Settings -> Keyboard -> Keyboard Shortcuts...
