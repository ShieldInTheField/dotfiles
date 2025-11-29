# 00-env.zsh — options, history, locale, editor

# ---- Shell options (history behavior) ----
setopt append_history         # append to $HISTFILE, don't overwrite
setopt hist_ignore_dups       # skip immediate duplicates
setopt share_history          # share history across sessions
setopt inc_append_history     # append as commands are entered
setopt hist_reduce_blanks     # trim superfluous spaces
setopt hist_verify            # edit history lines before running
setopt extended_history       # store timestamps & durations in history

# ---- History file (XDG) ----
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

mkdir -p "${HISTFILE:h}" # ensure history directory exists

# ---- Locale & editor ----
export LANG="${LANG:-en_US.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-en_US.UTF-8}"  # ensure UTF-8 handling
export EDITOR="${EDITOR:-nvim}"

# ----- Ghostty CLI symlink -----
# (On Linux this path doesn't exist so it checks and does nothing.)
if [[ -x "/Applications/Ghostty.app/Contents/MacOS/ghostty" ]]; then
  mkdir -p "$HOME/.local/bin"
  ln -sf "/Applications/Ghostty.app/Contents/MacOS/ghostty" "$HOME/.local/bin/ghostty"
fi