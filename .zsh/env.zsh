# rbenv
if [[ -d "/home/linhns/.rbenv" ]]; then
    eval "$(/home/linhns/.rbenv/bin/rbenv init - zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "/home/linhns/.ghcup/env" ] && source "/home/linhns/.ghcup/env" # ghcup-env

