# ~/.config/zsh/init.zsh

emulate -L zsh
setopt prompt_subst

# Resolve directory of THIS file even when sourced
local _self="${${(%):-%N}:A}"
local _base="${_self:h}"
local _mod_dir="${_base}/modules"

# Optional: trace module loading if ZSH_DIAG is set
if [[ -n ${ZSH_DIAG:-} ]]; then
  typeset -ga ZSH_MODULES_LOADED
fi

# Load modules in lexical order (skip example/template files)
for f in $_mod_dir/*.zsh(Nn); do
  [[ $f == *.example.zsh ]] && continue
  [[ -n ${ZSH_DIAG:-} ]] && print -r -- "[zsh] sourcing ${f:t}" >&2
  source "$f"
  [[ -n ${ZSH_DIAG:-} ]] && ZSH_MODULES_LOADED+=("${f:t}")
done

unset _self _base _mod_dir f
