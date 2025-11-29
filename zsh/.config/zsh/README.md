# Modular Zsh config

## Load flow
- `~/.zshenv` (tracked as `zsh/.zshenv`): sets XDG vars, `ZDOTDIR`, and creates XDG directories. Loaded by every zsh (login and non-login).
- `$ZDOTDIR/.zshrc` (symlinked to `zsh/.config/zsh/.zshrc`): tiny shim that sources `init.zsh`.
- `$ZDOTDIR/init.zsh`: discovers the `modules/` directory and sources modules in lexical order (`*.zsh`), skipping example/template files (`*.example.zsh`).

## Because I wanted
- XDG everywhere: configs under `~/.config`, cache under `~/.cache`, state under `~/.local/state`, data under `~/.local/share`.
- Small, predictable modules: each file does one thing and is easy to override.
- Safe-by-default: history under XDG, completion cache under XDG, optional local overrides are untracked.

## Modules (in load order)
- `00-env.zsh`: shell options, history location/size, locale, default editor, Ghostty symlink helper.
- `05-xdg.zsh`: program-specific XDG variables and directory creation.
- `10-paths.zsh`: builds `PATH` deterministically (user bins, language runtimes, vendor toolchains, Brew/Linuxbrew, system). Drops macOS-only paths on non-Darwin.
- `20-alias.zsh`: common aliases
- `30-functions.zsh`: sets up autoloaded user functions and completion path.
- `40-completions.zsh`: `compinit` with XDG cache, fixes insecure dirs.
- `50-plugins.zsh`: loads zsh-syntax-highlighting (and autosuggestions if enabled) from Homebrew/system paths.
- `60-brew.zsh`: Homebrew env for headers/pkg-config (macOS only).
- `70-pyenv.zsh`: enables pyenv if present.
- `75-virtualenvwrapper.zsh`: optional virtualenvwrapper if present.
- `80-fzf.zsh`: fzf keybindings if installed.
- `90-starship.zsh`: initializes starship prompt if installed.
- `99-local.zsh`: user-specific overrides (ignored by git); template at `99-local.example.zsh`.

## Editing and personalizing
- PATH/toolchains: edit `modules/10-paths.zsh` to add/remove runtimes or vendor tools.
- Aliases: add to `modules/20-alias.zsh`.
- Plugins: enable autosuggestions in `modules/50-plugins.zsh` (uncomment), or add other sourced plugins there.
- pyenv/virtualenvwrapper: keep or remove `70-pyenv.zsh` / `75-virtualenvwrapper.zsh` based on your Python workflow.
- Prompt: adjust `starship/.config/starship.toml`; disable starship via `STARSHIP_DISABLED=1` before starting zsh.
- Local host tweaks: copy `modules/99-local.example.zsh` to `99-local.zsh` and customize (kept untracked by `.gitignore`).
- Greeting message: see `functions/clear` and `99-local.example.zsh`.

## Notes
- The setup assumes XDG paths; use the provided `.zshenv` or export the same XDG vars if you reuse modules elsewhere.
- If you don’t use Homebrew on Linux, `60-brew.zsh` is skipped. The PATH module already includes Linuxbrew paths; comment out unused entries for a leaner PATH.
- ⚠️ **Important:** Avoid using **`exec zsh`** with this configuration. Instead, use the built-in **`reload`** command. Running `exec zsh` can silently deactivate an active virtual environment while the prompt still displays it as active, leading to an inconsistent shell state. The `reload` command prevents this issue.
