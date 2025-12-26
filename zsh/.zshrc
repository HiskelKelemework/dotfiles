export HOMEBREW_PREFIX="$(brew --prefix)"

export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

bindkey -v
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Added by Antigravity
export PATH="$HOME/.local/bin:$PATH"

# setup fzf file find and open in nvim
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'

source <(fzf --zsh)

export XDG_CONFIG_HOME="$HOME/.config"

alias vim='nvim'
alias lgit='lazygit'
alias ldock='lazydocker'

# [start] ------------ for customizing ps1 (shell prompt message) ------------
# Enable git branch info
autoload -Uz vcs_info
setopt PROMPT_SUBST

# Update vcs info before each prompt
precmd() {
  vcs_info
}

# Enable git only
zstyle ':vcs_info:*' enable git

# Git branch in RED
zstyle ':vcs_info:git:*' formats '%F{red}(%b)%f'

# Prompt
PROMPT='%F{green}%n%f %3~ %F{blue}git%f: ${vcs_info_msg_0_} %# '
# [end] ------------
