# 90-starship.zsh — initialize Starship prompt
# Skip via STARSHIP_DISABLED=1

emulate -L zsh

# Allow disabling: STARSHIP_DISABLED=1 zsh
if [[ -n ${STARSHIP_DISABLED:-} ]]; then
  return 0
fi

# Prevent double init if this file is re-sourced for any reason
if [[ -n ${_STARSHIP_INIT_DONE:-} ]]; then
  return 0
fi

# XDG: set explicit cache dir
: ${XDG_CACHE_HOME:=$HOME/.cache}
export STARSHIP_CACHE="${STARSHIP_CACHE:-$XDG_CACHE_HOME/starship}"

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
  typeset -g _STARSHIP_INIT_DONE=1
else
  print -u2 "[warn] starship not found; using default Zsh prompt"
fi