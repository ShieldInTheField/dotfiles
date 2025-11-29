# ~/.config/zsh/.zshrc

# Delegate to init.zsh (the real loader)
if [ -r "${ZDOTDIR:-$HOME/.config/zsh}/init.zsh" ]; then
  source "${ZDOTDIR:-$HOME/.config/zsh}/init.zsh"
fi
