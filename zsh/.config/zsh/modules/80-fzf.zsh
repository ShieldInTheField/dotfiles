# 80-fzf.zsh — fzf keybindings (Ctrl-R, Ctrl-T, Alt-C)

emulate -L zsh

# Skip if not interactive
[[ -o interactive ]] || return 0

# Don’t source twice
[[ -n ${__FZF_KEYS_LOADED:-} ]] && return 0

# Common install locations
local -a _fzf_candidates=(
  "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"          # macOS ARM (Homebrew)
  "/usr/local/opt/fzf/shell/key-bindings.zsh"             # macOS Intel (Homebrew)
  "$HOME/.linuxbrew/opt/fzf/shell/key-bindings.zsh"       # Linuxbrew
  "$HOME/.fzf/shell/key-bindings.zsh"                     # upstream ~/.fzf installer
  "/usr/share/fzf/key-bindings.zsh"                       # distro packages
  "/usr/share/doc/fzf/examples/key-bindings.zsh"          # some distros
)

local _f
for _f in "${_fzf_candidates[@]}"; do
  if [[ -r "$_f" ]]; then
    source "$_f"
    typeset -g __FZF_KEYS_LOADED=1
    break
  fi
done

unset _fzf_candidates _f