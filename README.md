# Dotfiles

## Configured Programs
kitty
neovim
z-shell (with .zshrc)

## Kitty and Neovim Install
```bash
brew install kitty neovim
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

## P.S.
Make sure to install fonts. fonts are in .config/nvim/fonts/

## DS_Store Being Annoying?
```bash
vim ~/.stow-global-ignore
```
Add the following line
```
\.DS_Store
```
## tmux
Make sure plugin manager is installed for tmux.
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf
```
After sourcing .tmux.conf, run <Prefix> + I to install tmux plugins.


