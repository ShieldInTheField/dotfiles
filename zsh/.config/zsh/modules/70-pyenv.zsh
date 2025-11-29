# 70-pyenv.zsh — enable pyenv if present
# (comment out if using Conda/Mamba instead)

emulate -L zsh

if command -v pyenv >/dev/null 2>&1; then
  # Ensure pyenv root is under XDG if not already set
  : ${XDG_DATA_HOME:=$HOME/.local/share}
  export PYENV_ROOT="${PYENV_ROOT:-$XDG_DATA_HOME/pyenv}"
  mkdir -p "$PYENV_ROOT"

  # Initialize pyenv
  eval "$(pyenv init - zsh)"
fi