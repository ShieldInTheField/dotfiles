# 10-paths.zsh — construct PATH deterministically

path=(
  # ---- User bins (highest priority) ----
  $HOME/.local/bin
  $HOME/local/bin
  $HOME/bin

  # ---- Language managers / runtimes ----
  $HOME/.nvm/versions/node/v22.16.0/bin
  # macOS python/pnpm locations
  $HOME/Library/pnpm
  $HOME/Library/Python/3.13/bin
  /Library/Frameworks/Python.framework/Versions/3.13/bin
  # Linux-ish equivalents
  # $HOME/.local/share/pnpm
  # /usr/lib/pnpm
  # $HOME/.local/bin/python3
  # $HOME/.local/share/python
  
  # $HOME/.cargo/bin        # uncomment if you want Rust cargo installed tools here
  # $HOME/go/bin            # uncomment if you use Go

  # ---- Vendor toolchains ----
  # macOS specific
  /Applications/ArmGNUToolchain/14.2.rel1/arm-none-eabi/bin
  $HOME/Keil-Embedded-Tools/cmsis-toolbox/bin
  /usr/local/mysql/bin

  # ---- Homebrew / Linuxbrew ----
  # In order to use Homebrew's version instead of the system version, this comes before Systems defaults.
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /home/linuxbrew/.linuxbrew/bin
  /home/linuxbrew/.linuxbrew/sbin

  # ---- System defaults ----
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
)

# Drop macOS-only paths when not on Darwin
if [[ $(uname) != Darwin ]]; then
  path=(${path:#/Applications/*})
  path=(${path:#/Library/*})
  path=(${path:#$HOME/Library/*})
fi

# Drop brew-only paths if the directories do not exist (keeps macOS users intact)
for _maybe in /opt/homebrew/bin /opt/homebrew/sbin; do
  [[ -d $_maybe ]] || path=(${path:#$_maybe})
done

# Deduplicate while preserving order
typeset -U path
export PATH
