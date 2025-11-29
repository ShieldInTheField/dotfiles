# 40-completions.zsh — zsh completion setup

emulate -L zsh

: ${XDG_CACHE_HOME:=$HOME/.cache}
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"

# Ensure cache dir exists
mkdir -p "${ZSH_COMPDUMP:h}"

# Load completion system
autoload -Uz compinit

# Fix/avoid "insecure directories" warnings by correcting perms once
# (Only operates on dirs compaudit actually flags.)
if typeset -f compaudit >/dev/null; then
  local -a _ca
  _ca=($(compaudit 2>/dev/null))
  (( ${#_ca} )) && chmod -R go-w -- $_ca 2>/dev/null
  unset _ca
fi

# Initialize completion, caching to XDG
compinit -d "$ZSH_COMPDUMP"

# Optional: nicer completion behavior (safe defaults)
zmodload -i zsh/complist 2>/dev/null
setopt completealiases          # allow completion after an alias
# bindkey '^i' complete-word     # you can add custom keybinds if you want