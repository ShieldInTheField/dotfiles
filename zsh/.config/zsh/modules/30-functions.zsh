# 30-functions.zsh — autoload user functions

emulate -L zsh
setopt extended_glob null_glob

: ${XDG_CONFIG_HOME:=$HOME/.config}
: ${XDG_DATA_HOME:=$HOME/.local/share}

# Directories
USER_FUNC_DIR="$XDG_CONFIG_HOME/zsh/functions"           # one file per function (no leading '_')
USER_SITE_FUNCS="$XDG_DATA_HOME/zsh/site-functions"      # completion functions (filenames start with '_')

# Ensure they exist
mkdir -p "$USER_FUNC_DIR" "$USER_SITE_FUNCS"

# Put dirs at the front so defs win if names collide
fpath=("$USER_FUNC_DIR" "$USER_SITE_FUNCS" $fpath)

# Autoload ONLY regular function files (exclude completion files starting with '_')
# - extended_glob lets one to use ^_* to mean “not starting with '_'”
# - (.) regular files; (t) take basename; null_glob prevents errors if empty
autoload -Uz "$USER_FUNC_DIR"/^_*(.N:t) 2>/dev/null