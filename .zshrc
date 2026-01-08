# Ben's .zshrc File

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
 
# NOTE: Aliases:
alias neobean='NVIM_APPNAME=linkarzu/dotfiles-latest/neovim/neobean nvim'
alias vi="nvim"
alias vim="nvim"
alias lgit="lazygit"
alias ldocker="lazydocker"
# alias gitl = 'git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)''
alias gitl="nvim -c \"lua require('gitgraph').draw({}, { all = true, max_count = 5000 })\""
alias gitl1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"
alias gitl2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
alias gitl3="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'"
alias gits="git status"

alias tm="tmux"

alias opc="opencode"

# nukes nvim cache and removes all swap files
alias nuke="rm -rfv ~/.local/state/nvim/swap/*"

# clean all lazy plugins
alias vilazyclear="rm -rf ~/.local/share/nvim/lazy; rm -rf ~/.local/state/nvim/lazy; rm -rf ~/.cache/nvim;"
# clean all lazy plugins and enter neovim
alias vilazy="rm -rf ~/.local/share/nvim/lazy; rm -rf ~/.local/state/nvim/lazy; rm -rf ~/.cache/nvim; nvim"

# NOTE: Instantly edit my nvim configuation
viedit() {
    cd ~/dotfiles/.config/nvim || return
    vi
}

# instantly edit dotfiles
dotedit() {
    cd ~/dotfiles || return
    vi
}

# leetcode scratchpad
leet(){
  cd ~/dotfiles/leet || return
  vi
}

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$PATH"
export PATH=$PATH:/opt/homebrew/bin
 
# NOTE: ZSH Theme:
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="clean"
 
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
 
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
 
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
 
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
 
# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13
 
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
 
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
 
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
 
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
 
# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"
 
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
 
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"
 
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
 
# NOTE:: Plugins
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autocomplete zsh-autosuggestions zsh-syntax-highlighting macos)
 
source $ZSH/oh-my-zsh.sh
 
# User configuration
 
# export MANPATH="/usr/local/man:$MANPATH"
 
# You may need to manually set your language environment
# export LANG=en_US.UTF-8
 
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
 
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
 
# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# NOTE:: Path variable for brew package manager
export PATH=$PATH:/opt/homebrew/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source virtual environment shortcut
function act() {
  if [ -d "$1/bin" ]; then
    source "$1/bin/activate"
  else
    echo "No virtual environment found at '$1'"
  fi
}

# Show IP Address and copy to clipboard
function getip() {
  ip=$(ipconfig getifaddr en0)
  printf "%s" "$ip" | tee >(pbcopy)
}

# Show Seal's static IP Address for Backend server and copy to clipboard
function sealip() {
  ip=10.1.1.242
  printf "%s" "$ip" | tee >(pbcopy)
}

# pve alias creates python virtual environment
# EXAMPLE: "pve venv" will create a virtual environment called venv in python3
pve() {
  if [ -z "$1" ]; then
    echo "Usage: pve <env_name>"
    return 1
  fi
  python3 -m venv "$1"
}

pve311() {
  if [ -z "$1" ]; then
    echo "Usage: pve311 <env_name>"
    return 1
  fi
  python3.11 -m venv "$1"
}

# gitw -> runs "git worktree list"
# gitw (arguments) -> runs "git worktree (with arguments)"
gitw() {
    if [[ $# -eq 0 ]]; then
        git worktree list
    else
        git worktree "$@"
    fi
}

# starship
eval "$(starship init zsh)"
