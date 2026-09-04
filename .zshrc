# .zshrc
setopt IGNORE_EOF # prevents from automatically exiting shell

# Aliases and Cmds:
# --- cd ---
alias cd="z"
# --- vim ---
alias vi="nvim"
alias vim="nvim"
alias vilazyclear="rm -rf ~/.local/share/nvim/lazy; rm -rf ~/.local/state/nvim/lazy; rm -rf ~/.cache/nvim; rm -rf ~/.local/share/nvim/mason; rm -rf ~/.local/share/nvim/site" # clean all lazy plugins
alias vilazy="rm -rf ~/.local/share/nvim/lazy; rm -rf ~/.local/state/nvim/lazy; rm -rf ~/.cache/nvim; rm -rf ~/.local/share/nvim/mason; rm -rf ~/.local/share/nvim/site; nvim" # clean all lazy plugins and enter neovim
# instantly edit my nvim configuation
viedit() {
    cd ~/dotfiles/.config/nvim || return
    vi
}
# instantly cd into nvim config
vigo() {
    cd ~/dotfiles/.config/nvim || return
}
# --- dotfiles ---
# instantly edit dotfiles
dotedit() {
    cd ~/dotfiles || return
    vi
}
# instantly cd into dotfiles
dotgo() {
    cd ~/dotfiles || return
}
# -- zsh ---
# instantly edit .zshrc
zedit() {
    cd ~/dotfiles || return
    vi .zshrc
}
# --- git ---
alias gitl="nvim -c \"lua require('gitgraph').draw({}, { all = true, max_count = 5000 })\""
alias gitl1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"
alias gitl2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
alias gitl3="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'"
alias gits="git status"
alias gitf="git fetch"
alias gitb="git branch"
alias ghd="gh dash"
# --- opencode ---
alias oc="opencode"
alias occ="opencode run --agent build \"commit staged\""
# --- tmux ---
alias tmuxs="tmux source-file ~/.tmux.conf" 
alias tmuxq="tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/save.sh && tmux kill-server" # save tmux sessions and kill tmux server
# --- tmuxp ---
# NOTE:
# tmuxp freeze (saves current session)
# tmuxp load session_name.yaml (loads session)
alias tp="tmuxp"
# instantly cd into ~/dotfiles/.tmuxp/
tpgo() {
    cd ~/dotfiles/.tmuxp/ || return
}

# -- github ---
# prints current repo link and copies to clipboard
ghrepo() {
  local url=$(gh repo view --json url -q .url)
  echo "$url" | pbcopy
  echo "$url"
}

# --- leetcode ---
# leetcode scratchpad
leet(){
  cd ~/dotfiles/leet || return
  vi
}

export ZSH="$HOME/.oh-my-zsh" # Path to your Oh My Zsh installation.
ZSH_THEME="clean"
HIST_STAMPS="mm/dd/yyyy"
plugins=(zsh-completions zsh-autosuggestions fast-syntax-highlighting bd git-extras copypath fzf-tab)
source $ZSH/oh-my-zsh.sh

 
# --- fzf ---
[ -f "$(brew --prefix fzf)/shell/completion.zsh" ] && source "$(brew --prefix fzf)/shell/completion.zsh"
zstyle ':completion:*' menu no # required for fzf-tab to actually activate
setopt globdots # include hidden files/dirs in completion

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

# --- atuin ---
eval "$(atuin init zsh)"

# --- starship ---
eval "$(starship init zsh)"

# --- zoxide ---
eval "$(zoxide init zsh)"

# --- exports ---
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR='nvim'
export OPENCODE_ENABLE_EXA=1 # Enable Exa search tools for opencode
export OPENCODE_EXPERIMENTAL_LSP_TOOL=true # Enable experimental LSP tool for opencode
