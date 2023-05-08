# If you come from bash you might have to change your $PATH.
# Export Go-related variables
export GOROOT="/usr/local/go-1.20.1"
export GOPATH=$HOME/go

path+=("/home/linhns/.local/bin" "$GOPATH/bin" "$GOROOT/bin" "/usr/lib/llvm-15/bin")
if [[ -n $(ls /opt | grep -m 1 cmake) ]]; then
    path+=("/opt/$(ls /opt | grep -m 1 cmake)/bin")
fi

export PATH
# zsh custom functions
fpath+=${ZDOTDIR:-~}/.zsh_functions

autoload -Uz mans lfd

# fzf settings
export FZF_BASE="$(which fzf)"
# export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
# export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_ALT_C_OPTS="--preview 'exa --tree --level 2 {}'"

# rg settings
export RIPGREP_CONFIG_PATH="/home/linhns/.ripgreprc"

# Load Antigen
source "/home/linhns/antigen.zsh"

# Set Vim to be default editor
export EDITOR=vim

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle docker
antigen bundle command-not-found
antigen bundle rust
antigen bundle fzf
antigen bundle golang
antigen bundle gh
antigen bundle taskwarrior
antigen bundle fd

# Extra completions
antigen bundle zsh-users/zsh-completions

# Enable fish-like autosuggestions
antigen bundle zsh-users/zsh-autosuggestions

# Z for frecency-based navigation
antigen bundle agkozak/zsh-z

# Load the theme.
# antigen theme robbyrussell

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

# Use vim style navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Initialize editing command line
autoload -U edit-command-line && zle -N edit-command-line

# Enable interactive comments (# on the command line)
setopt interactivecomments

# Use vim style line editing in zsh
bindkey -v
# Movement
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history
# Undo
bindkey -a 'u' undo
bindkey -a '^R' redo
# Edit line
bindkey -a '^V' edit-command-line
# Backspace
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# Use bat as pager for man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

alias python=python3

# External plugins (initialized after)
source ~/.zsh/plugins_after.zsh

# Load starship
# export STARSHIP_CONFIG=/home/linhns/dotfiles/starship.toml
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


[ -f "/home/linhns/.ghcup/env" ] && source "/home/linhns/.ghcup/env" # ghcup-env
