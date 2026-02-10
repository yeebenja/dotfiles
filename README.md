# Dotfiles

## Configured Programs
```
neovim
tmux
kitty
ghostty
zsh
```

## Install Programs and Plugins
```bash
brew install neovim 
brew install --cask kitty
brew install --cask ghostty
brew install starship        # CLI Plugin
brew install ripgrep
brew install zsh
brew install fzf             # For fuzzy search in command line
brew install fd              # For better file searching in snacks.picker
brew install mermaid-cli     # For Mermaid diagrams in snacks.image
brew install tectonic        # For LaTeX rendering in snacks.image
brew install ghostscript     # PDF rendering for snacks.image
brew install imagemagick     # For image.nvim

# Node is needed for some LSPs in nvim
brew install node
# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Oh-my-zsh plugins
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Goofing off
brew tap real-aazam/homebrew-aazam
brew install hollywood
# npm dependencies
npm install -g markdownlint-cli # for linting markdown files
# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# for tmux-session-dispensary
brew install fd sk
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
Use OpenCode
```bash
brew install opencode
```

## Browser Extensions
* [Redux DevTools][redux-devtools]

[redux-devtools]: https://chromewebstore.google.com/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en

## Remapping MacBook Internal Keyboard
* [hidutil key remapping generator for MacOS][keyboard-remap-website]

[keyboard-remap-website]: https://hidutil-generator.netlify.app

I have mine set as:
```
left cmd -> left ctrl
left ctrl -> left cmd
```

## tmux
* Within a tmux session, use prefix + I to install all tmux plugins
- Allow permissions to run tmux-session-dispensary.sh
```bash
chmod +x ~/.config/scripts/tmux-session-dispensary.sh

```

## Keyboard Layout
I currently use Colemak DH Matrix (a.k.a Ortholinear)
![Screenshot](images/colemak_dh_main_iso.png)
Install the keyboard layout:
```bash
brew install --cask colemak-dh
```

## Add Mac Shortcuts
- Navigate to Keyboard > Keyboard Shortcuts.
- Click on App Shortcuts in the sidebar.
- Hit the + button to add a new shortcut.
- Set:
- Application: You can choose “All Applications” or a specific one (like Google Chrome, Mail, etc.).
- Menu Title: Type exactly this: Paste and Match Style (case-sensitive!).
- Keyboard Shortcut: Pick something unique like Command + Shift + V or a combination of your choice
- Click Add and you’re good to go
