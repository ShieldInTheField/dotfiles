# 05-xdg.zsh — program-specific XDG mappings
# Base XDG vars + ZDOTDIR are set in ~/.zshenv

: ${XDG_CONFIG_HOME:=$HOME/.config}
: ${XDG_CACHE_HOME:=$HOME/.cache}
: ${XDG_DATA_HOME:=$HOME/.local/share}
: ${XDG_STATE_HOME:=$HOME/.local/state}

# ---------- Common tools ----------
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
# Avoid ripgrep warning if config is absent
if [[ -r "$XDG_CONFIG_HOME/ripgrep/ripgreprc" ]]; then
  export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
fi

# ---------- Node / npm ----------
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# ---------- Rust ----------
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# ---------- Python managers ----------
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"   # used by 70-pyenv.zsh if present
export PIPX_HOME="$XDG_DATA_HOME/pipx"
export PIPX_BIN_DIR="$HOME/.local/bin"

# ---------- Git ----------
export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
export GIT_IGNORE_GLOBAL="$XDG_CONFIG_HOME/git/ignore"

# ---------- fzf ----------
# Keep interactive history under state; append to any existing opts.
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS }--history=$XDG_STATE_HOME/fzf/history"

# ---------- WezTerm ----------
export WEZTERM_CONFIG_FILE="$XDG_CONFIG_HOME/wezterm/wezterm.lua"

# ---------- Ensure key dirs exist ----------
mkdir -p \
  "$XDG_CONFIG_HOME/git" \
  "$XDG_CONFIG_HOME/npm" \
  "$XDG_CONFIG_HOME/wget" \
  "$XDG_STATE_HOME/less" \
  "$XDG_STATE_HOME/fzf"
