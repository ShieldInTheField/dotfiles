# 60-brew.zsh — Homebrew integration

emulate -L zsh

# Only apply on macOS (Homebrew/Linuxbrew paths can differ on Linux)
[[ $(uname) == "Darwin" ]] || return 0

# Discover likely prefixes (macOS ARM, Intel, Linuxbrew)
local -a _brew_prefixes
for p in /opt/homebrew /usr/local "$HOME/.linuxbrew"; do
  [[ -d $p ]] && _brew_prefixes+=("$p")
done
(( ${#_brew_prefixes} )) || return 0

# Helper: prepend a directory to a colon-separated var if the dir exists and isn't already listed
_prepend_colon() {
  local var="$1" dir="$2"
  [[ -d $dir ]] || return 0
  local cur
  cur="${(P)var}"       # indirect expansion to get current value
  if [[ -z $cur ]]; then
    typeset -gx -- "$var=$dir"
  else
    case ":$cur:" in
      (*":$dir:"*) ;;                 # already present
      (*) typeset -gx -- "$var=$dir:$cur" ;;
    esac
  fi
}

# Wire pkg-config + compiler flags for each present prefix
local prefix
for prefix in $_brew_prefixes; do
  _prepend_colon PKG_CONFIG_PATH "$prefix/lib/pkgconfig"
  _prepend_colon PKG_CONFIG_PATH "$prefix/share/pkgconfig"

  [[ -d "$prefix/include" ]] && export CPPFLAGS="-I$prefix/include ${CPPFLAGS:-}"
  [[ -d "$prefix/lib"     ]] && export LDFLAGS="-L$prefix/lib ${LDFLAGS:-}"
done

# Cleanup
unset -f _prepend_colon
unset _brew_prefixes prefix
