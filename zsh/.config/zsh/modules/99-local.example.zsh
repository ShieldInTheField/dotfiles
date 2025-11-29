# 99-local.example.zsh — template for per-host/private overrides
# Copy to 99-local.zsh (ignored by git) and customize as needed.

emulate -L zsh

# Only for interactive shells with a TTY
[[ -o interactive ]] || return 0
[[ -t 1 ]] || return 0

# --- Feature toggles (override here as needed) ---
# export DISABLE_BREW_ENV=1     # make 60-brew.zsh no-op (if you add the guard there)
# export ZSH_DIAG=1             # module load tracing (init.zsh respects this)

# --- One-time startup banner (optional) ---
if [[ -z ${__ZSH_LOCAL_BANNER_SHOWN:-} ]]; then
  if command -v cowsay >/dev/null 2>&1; then
    cowsay -t "Welcome back:)"
  fi
  typeset -g __ZSH_LOCAL_BANNER_SHOWN=1
fi

# --- Place per-host overrides below ---
# case "$HOST" in
#   work-mac) path=($HOME/work/bin $path); export PATH ;;
#   lab-box) export SAS_DIR="$HOME/path/to/sas" ;;
# esac

# Example: SSH-specific prompt hint
# if [[ -n ${SSH_CONNECTION:-} ]]; then
#   export ZSH_SSH_MARKER=1
# fi
