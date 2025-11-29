# 75-virtualenvwrapper.zsh — enable virtualenvwrapper

emulate -L zsh

# Skip if already loaded
type mkvirtualenv >/dev/null 2>&1 && return 0

# XDG home for virtualenvs
: ${XDG_DATA_HOME:=$HOME/.local/share}
export WORKON_HOME="${WORKON_HOME:-$XDG_DATA_HOME/virtualenvs}"
mkdir -p "$WORKON_HOME"

# Choose Python: prefer pyenv's current python, else a system python3, else Python.org path on macOS
if command -v pyenv >/dev/null 2>&1; then
  export VIRTUALENVWRAPPER_PYTHON="${VIRTUALENVWRAPPER_PYTHON:-$(pyenv which python 2>/dev/null)}"
elif command -v python3 >/dev/null 2>&1; then
  export VIRTUALENVWRAPPER_PYTHON="${VIRTUALENVWRAPPER_PYTHON:-$(command -v python3)}"
else
  # macOS Python.org fallback; harmless on Linux if unused
  export VIRTUALENVWRAPPER_PYTHON="${VIRTUALENVWRAPPER_PYTHON:-/Library/Frameworks/Python.framework/Versions/3.13/bin/python3}"
fi

# Try to locate virtualenvwrapper.sh via Python first
local _vew_sh=""
if [ -n "$VIRTUALENVWRAPPER_PYTHON" ]; then
  _vew_sh="$("$VIRTUALENVWRAPPER_PYTHON" - <<'PY'
import os, inspect
try:
    import virtualenvwrapper
    d = os.path.dirname(inspect.getfile(virtualenvwrapper))
    print(os.path.join(d, "virtualenvwrapper.sh"))
except Exception:
    pass
PY
)"
fi

# Fall back to common locations
for p in "$_vew_sh" \
         "/Library/Frameworks/Python.framework/Versions/3.13/bin/virtualenvwrapper.sh" \
         "/opt/homebrew/bin/virtualenvwrapper.sh" \
         "/usr/local/bin/virtualenvwrapper.sh" \
         "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" \
         "/usr/bin/virtualenvwrapper.sh"
do
  if [ -n "$p" ] && [ -r "$p" ]; then
    export VIRTUALENVWRAPPER_SCRIPT="$p"
    source "$p"
    break
  fi
done

unset _vew_sh p
