# truecolor support
export COLORTERM=truecolor
# rg settings
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Use bat as pager for man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# fzf settings
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

export FZF_DEFAULT_OPTS="
    --layout=reverse
    --height ~50%
    --no-scrollbar
    --border
    --preview-window=right,50%,border-none,border-line
    --bind 'shift-page-up:preview-page-up,shift-page-down:preview-page-down'
    --bind 'ctrl-/:toggle-preview'
"

export FZF_ALT_C_OPTS="
    --preview 'tree -C {}'
    --preview-window '~1'
"

export FZF_CTRL_T_OPTS="
    --preview 'if [[ -d {} ]]; then tree -C {}; else bat --color=always --style=plain --line-range :100 {}; fi'
"

export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window down:3:hidden:wrap
    --bind '?:toggle-preview'
    --bind 'ctrl-y:execute(echo -n {2..} | pbcopy)+abort'
"

