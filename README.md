# Dotfiles

## Configured Programs
```
ghostty
neovim
z-shell
```

## Install Programs and Plugins
```bash
brew install neovim 
brew install --cask ghostty
# (ripgrep is for Spectre neovim plugin)
brew install ripgrep
brew install zsh
brew install fastfetch
# Node is needed for some LSPs in nvim
brew install node
# Oh-my-zsh plugins
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Goofing off
brew tap real-aazam/homebrew-aazam
brew install hollywood
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
rm ~/.zshrc
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
## Map Caps Lock to Esc on Mac
Go to System Settings -> Keyboard -> Keyboard Shortcuts...

## LeetCode Practice
* Get cookie info by going in developer tools on browser (CMD + OPT + i)
* Then go to Storage > Cookies > leetcode.com (must on page leetcode.com)
* Get these two cookies: LEETCODE_SESSION and csrftoken
* When entering cookie for leetcode.nvim, make sure cookie is in this format:
```
LEETCODE_SESSION=abcdefghijk; csrftoken=abcdefghijk
```

## AI and LLMs CLI
Use gemini CLI
```
npm install -g @google/gemini-cli # or brew install gemini-cli
```
