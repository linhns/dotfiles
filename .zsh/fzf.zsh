# fzf settings
export FZF_BASE="$(which fzf)"
# export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files -g "!.git/"'
# export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse-list --no-scrollbar --border --preview-window=60%,'~3'"
export FZF_ALT_C_OPTS="--preview 'exa --tree --level 2 {}'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :100 {}'"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'exa -la {} | head -100'  "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}


