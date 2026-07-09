# .zshrc

# prevents from automatically exiting shell
setopt IGNORE_EOF

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
 
# NOTE: Aliases:
alias vi="nvim"
alias vim="nvim"
# alias gitl = 'git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)''
alias gitl="nvim -c \"lua require('gitgraph').draw({}, { all = true, max_count = 5000 })\""
alias gitl1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"
alias gitl2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
alias gitl3="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'"
alias gits="git status"
alias gitf="git fetch"
alias tm="tmux"
alias tmuxs="tmux source-file ~/.tmux.conf" 
# save tmux sessions and kill tmux server
alias tmuxq="tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/save.sh && tmux kill-server"
alias oc="opencode"
alias tmuxdot="chmod +x $HOME/dotfiles/tmux-scripts/tmux-dotfiles; $HOME/dotfiles/tmux-scripts/tmux-dotfiles"

# clean all lazy plugins
alias vilazyclear="rm -rf ~/.local/share/nvim/lazy; rm -rf ~/.local/state/nvim/lazy; rm -rf ~/.cache/nvim; rm -rf ~/.local/share/nvim/mason; rm -rf ~/.local/share/nvim/site"
# clean all lazy plugins and enter neovim
alias vilazy="rm -rf ~/.local/share/nvim/lazy; rm -rf ~/.local/state/nvim/lazy; rm -rf ~/.cache/nvim; rm -rf ~/.local/share/nvim/mason; rm -rf ~/.local/share/nvim/site; nvim"

# create simple react project quickly
alias create-react="npm create vite@latest -- --template react-ts"


# instantly edit my nvim configuation
viedit() {
    cd ~/dotfiles/.config/nvim || return
    vi
}

# instantly edit dotfiles
dotedit() {
    cd ~/dotfiles || return
    vi
}

# instantly edit .zshrc
zedit() {
    cd ~/dotfiles || return
    vi .zshrc
}

# instantly cd into dotfiles
dotgo() {
    cd ~/dotfiles || return
}

# instantly cd into nvim config
vigo() {
    cd ~/dotfiles/.config/nvim || return
}

# leetcode scratchpad
leet(){
  cd ~/dotfiles/leet || return
  vi
}

# Enable Exa search tools for opencode
export OPENCODE_ENABLE_EXA=1
# Enable experimental LSP tool for opencode
export OPENCODE_EXPERIMENTAL_LSP_TOOL=true

export PATH="/opt/homebrew/bin:$PATH"
export EDITOR='nvim'

# ── Zinit ──────────────────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Bootstrap zinit if not installed
if [[ ! -d "${ZINIT_HOME}" ]]; then
    echo "Installing zinit to ${ZINIT_HOME}..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/main/scripts/install.sh)"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# OMZ git plugin: loads synchronously so git aliases are always available
zinit snippet OMZP::git

# Turbo mode: deferred after prompt — shell feels instant
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull"zinit creinstall -q ." \
    zsh-users/zsh-completions \
  Aloxaf/fzf-tab

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
export PATH="$HOME/.local/bin:$PATH"
