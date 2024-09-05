# If you come from bash you might have to change your $PATH.

source $HOME/.zsh/pathmod.zsh
# Export Go-related variables

GOROOT="/usr/local/go"

if [[ -d "$GOROOT" ]]; then
    path_append "$GOROOT/bin"
fi

path_append "$HOME/.local/bin"

export PATH

# Load Antigen
[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle docker
antigen bundle command-not-found
antigen bundle rust
antigen bundle golang
antigen bundle heroku
antigen bundle taskwarrior
antigen bundle npm
antigen bundle cabal
antigen bundle dircycle
antigen bundle copyfile
antigen bundle copybuffer
antigen bundle copypath

# Extra completions
antigen bundle zsh-users/zsh-completions

# Enable fish-like autosuggestions
antigen bundle zsh-users/zsh-autosuggestions

# Z for frecency-based navigation
antigen bundle agkozak/zsh-z

# timewarrior
antigen bundle svenXY/timewarrior

# Load the theme.
# antigen theme robbyrussell

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

source ~/.zsh/options.zsh

source ~/.zsh/styles.zsh

source ~/.zsh/keybindings.zsh

source ~/.zsh/fzf.zsh

source ~/.zsh/external.zsh

source ~/.zsh/aliases.zsh

# External plugins (initialized after)
source ~/.zsh/plugins_after.zsh

source ~/.zsh/env.zsh

# zsh custom functions
fpath=( ${ZDOTDIR:-~}/.zsh/functions ${ZDOTDIR:-~}/.zsh/completions ${fpath[@]} )
autoload -Uz $fpath[1]/*(.:t)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load starship
eval "$(starship init zsh)"
