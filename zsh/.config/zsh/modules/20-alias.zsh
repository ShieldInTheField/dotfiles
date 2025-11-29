# 20-alias.zsh: Aliases

# --- ls/eza: pick best available, keep flags simple ---
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias ll='eza -l --git --group-directories-first'
else
  alias ls='ls -F'
  alias ll='ls -laF'
fi

# --- grep: colored if supported ---
alias grep='grep --color=auto'

# --- tar shortcuts ---
alias untar='tar -xvf'
alias targz='tar -czvf'

# --- networking ---
alias ip='ipconfig 2>/dev/null || ip -c a 2>/dev/null || ifconfig'

# --- python/pip ---
alias python='python3'
alias pip='pip3'

# --- C/C++ convenience ---
alias clang++='clang++ -std=c++17'

# --- bat/batcat ---
if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
elif command -v batcat >/dev/null 2>&1; then
  alias cat='batcat'
fi

# --- zsh shortcuts ---
# alias zshconfig="mate ~/.zshrc" # left commented as in your file
# alias ohmyzsh="mate ~/.oh-my-zsh"
