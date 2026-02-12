#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.

export PATH="$PATH:$HOME/.local/bin"

ZCOMPDIR=${ZDOTDIR:-$HOME}/.zcompletions
mkdir -p $ZCOMPDIR
fpath=($ZCOMPDIR $fpath)

for _rc in ${ZDOTDIR:-$HOME}/.zplugins/*.zsh(N); do
  # Ignore tilde files.
  if [[ $_rc:t != '~'* ]]; then
    source "$_rc"
  fi
done
unset _rc


# Lazy-load (autoload) Zsh function files from a directory.
ZFUNCDIR=${ZDOTDIR:-$HOME}/.zfunctions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $ZFUNCDIR/*(:t)

# Set any zstyles you might use for configuration.
[[ ! -f ${ZDOTDIR:-$HOME}/.zstyles ]] || source ${ZDOTDIR:-$HOME}/.zstyles

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# Source anything in .zshrc.d.
for _rc in ${ZDOTDIR:-$HOME}/.zshrc.d/*.zsh; do
  # Ignore tilde files.
  if [[ $_rc:t != '~'* ]]; then
    source "$_rc"
  fi
done
unset _rc

# Setup mise
if (( $+commands[mise] )); then
    eval "$(mise activate zsh)"
    eval "$(mise hook-env -s zsh)"
fi

# Set up fzf key bindings and fuzzy completion
if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

# Setup zoxide
eval "$(zoxide init zsh)"

# if [ -f '/home/linhns/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/linhns/google-cloud-sdk/completion.zsh.inc'; fi
