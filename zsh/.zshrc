export HOMEBREW_PREFIX="$(brew --prefix)"

export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

bindkey -v
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Added by Antigravity
export PATH="/Users/hiskelkelemework/.antigravity/antigravity/bin:$PATH"

# setup fzf file find and open in nvim
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'

source <(fzf --zsh)

export XDG_CONFIG_HOME="$HOME/.config"
