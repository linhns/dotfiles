# rg settings
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Use bat as pager for man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# fzf settings
export FZF_DEFAULT_OPTS="
    --height 50%
    --layout reverse-list
    --no-scrollbar
    --border
    --preview-window 50%
"

export FZF_ALT_C_OPTS="
    --preview 'tree -C {}'
    --preview-window '~1'
    --preview-label 'Directory Preview'
"

export FZF_CTRL_T_OPTS="
    --preview 'if [[ -d {} ]]; then tree -C {}; else bat --color=always {} --line-range :100; fi'
    --preview-label 'Preview'
"

export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window down:3:hidden:wrap
    --bind '?:toggle-preview'
"

