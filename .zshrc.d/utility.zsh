if ! (( $+commands[pbcopy] )); then
    if (( $+commands[clip.exe] )) && (( $+commands[powershell.exe] )); then
        function pbcopy() { cat "${1:-/dev/stdin}" | clip.exe; }
        function pbpaste() { powershell.exe -noprofile -command Get-Clipboard; }
    fi
fi
