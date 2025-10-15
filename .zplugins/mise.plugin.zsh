if (( ! ${+commands[mise]} )); then
  return
fi

if [[ ! -f "$ZCOMPDIR/_mise" ]]; then
  typeset -g -A _comps
  autoload -Uz _mise
  _comps[mise]=_mise
fi

mise completion zsh >| "$ZCOMPDIR/_mise" &|
