# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# zsh custom functions
fpath+=${ZDOTDIR:-~}/.zsh_functions

# fzf settings
export FZF_BASE="$(which fzf)"
# export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
# export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Load Antigen
source "/home/linhns/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found
antigen bundle rust
antigen bundle fzf

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Extra completions
antigen bundle zsh-users/zsh-completions

# Enable fish-like autosuggestions
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
# antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply

# Use bat as pager for man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Load starship
# export STARSHIP_CONFIG=/home/linhns/dotfiles/starship.toml
eval "$(starship init zsh)"
