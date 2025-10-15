if (( ! ${+commands[gh]} )); then
  return
fi

if [[ ! -f "$ZCOMPDIR/_gh" ]]; then
  typeset -g -A _comps
  autoload -Uz _gh
  _comps[gh]=_gh
fi

gh completion --shell zsh >| "$ZCOMPDIR/_gh" &|
