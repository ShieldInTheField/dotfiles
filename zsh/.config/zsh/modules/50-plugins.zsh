# 50-plugins.zsh — load zsh plugins directly
# Order: autosuggestions -> syntax-highlighting

emulate -L zsh 

# Resolve Homebrew prefix if possible
local -a _bm_prefixes
if [[ -n ${HOMEBREW_PREFIX:-} ]]; then
  _bm_prefixes=("$HOMEBREW_PREFIX")
elif command -v brew >/dev/null 2>&1; then
  _bm_prefixes=("$(brew --prefix 2>/dev/null)")
else
  _bm_prefixes=()
fi
# Add common fallbacks; de-dup later
_bm_prefixes+=("/opt/homebrew" "/usr/local" "$HOME/.linuxbrew")
typeset -U _bm_prefixes

# Helper: source first readable file from args
_bm_source_first() {
  local f
  for f; do
    [[ -r "$f" ]] && { source "$f"; return 0; }
  done
  return 1
}

# ---- zsh-autosuggestions ----
# Optional: make ghost text subtle (comment to use defaults)
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

#_bm_source_first \
#  "$_bm_prefixes[1]/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
#  "$_bm_prefixes[2]/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
#  "$_bm_prefixes[3]/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
#  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
#  "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
#|| print -u2 "[warn] zsh-autosuggestions not found via Homebrew or system paths"

# ---- zsh-syntax-highlighting (must be last among plugins) ----
_bm_source_first \
  "$_bm_prefixes[1]/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "$_bm_prefixes[2]/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "$_bm_prefixes[3]/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
|| print -u2 "[warn] zsh-syntax-highlighting not found via Homebrew or system paths"

# Cleanup
unset -m _bm_prefixes _bm_source_first