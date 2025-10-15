# Return immediately if uv is not found
if (( ! ${+commands[uv]} )); then
  return
fi

# If the completion file doesn't exist yet, we need to autoload it and
# bind it. Otherwise, compinit will have already done that.
if [[ ! -f "$ZCOMPDIR/_uv" ]]; then
  typeset -g -A _comps
  autoload -Uz _uv
  _comps[uv]=_uv
fi

if [[ ! -f "$ZCOMPDIR/_uvx" ]]; then
  typeset -g -A _comps
  autoload -Uz _uvx
  _comps[uvx]=_uvx
fi

# uv and uvx are installed together (uvx is an alias to `uv tool run`)
# Overwrites the file each time as completions might change with uv versions.
uv generate-shell-completion zsh >| "$ZCOMPDIR/_uv" &|
uvx --generate-shell-completion zsh >| "$ZCOMPDIR/_uvx" &|
