alias rm='rm -iv'

# Set up aliases only when commands are available
typeset -A _aliases=(
  [python]=python3
  [vim]=nvim
)

for _alias _cmd in ${(kv)_aliases}; do
  if (( $+commands[$_cmd] )); then
    alias $_alias=$_cmd
  fi
done

unset _cmd _alias _aliases

