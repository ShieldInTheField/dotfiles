# GraVimy 

A modular Neovim config.

## Quick start
- Symlink via Stow from repo root: `stow nvim` (expects repo at `~/dotfiles`; adjusts `~/.config/nvim`).
- Open a project: `nvim .`
- Let Lazy.nvim install plugins automatically. If it stalls, run `:Lazy sync`.
- Install tools via `:Mason` (LSPs/formatters/debuggers).

## Requirements
- Neovim v0.11+
- `git` in PATH
- Build tools: `make` (Telescope FZF), C/C++ compiler (Treesitter/DAP builds)
- Optional: a Nerd Font (e.g., JetBrainsMono Nerd Font) for icons
- For easiest linking, Stow + XDG layout from the root README (`zsh/.zshenv` sets XDG paths)

## Key concepts
- **Lazy.nvim**: `:Lazy` opens UI; `:Lazy sync` installs/updates; `:Lazy clean` removes unused.
- **Mason**: `:Mason` opens UI; `i` install, `u` update, `X` uninstall tools.
- **LSP**: auto for C/C++ (clangd), Python (pyright), Lua (lua_ls), Rust (rust-analyzer).
- **Formatting**: Conform with black/clang-format/stylua/rustfmt/jq/prettier. Auto on save; manual `<leader>F`.
- **Debugging**: nvim-dap + dap-ui; Mason installs `codelldb`/`python` adapters on demand.

## Core keymaps
- Leader = `space`
- Save/quit: `<leader>w` / `<leader>q`
- Clear search: `<leader>h`
- Windows: `<C-h/j/k/l>`
- Telescope: `<leader>ff` files, `<leader>fg` live grep, `<leader>fb` buffers, `<leader>fh` help
- Trouble diagnostics: `<leader>xx` toggle, `<leader>xq` quickfix list
- Formatting: `<leader>F`
- LSP (when attached): `gd` definition, `K` hover, `gr` references, `<leader>rn` rename, `<leader>ca` code action, `<leader>f` LSP format
- Comments: `gc` motions/lines (Comment.nvim)
- DAP: `<F5>` continue, `<F9>` breakpoint, `<F10>` step over, `<F11>` step in, `<S-F11>` step out, `<leader>du` toggle UI
- File manager: `<leader>e` opens Oil (`-` up, `.` show hidden, `q` quit)
- Hints: start typing `<leader>` to see which-key popup

## Language notes
- **Rust**: Rustaceanvim: `K` hover actions, `<leader>rr` runnables, `<leader>ri` toggle inlay hints.
- **Python**: Pyright + Black. To add Ruff, install `ruff-lsp` in `:Mason` and add to `ensure_installed` in `plugins/lsp.lua`.

## Theme
- Current: Kanagawa (set in `plugins/init.lua`).
- Try live: `:colorscheme <TAB>` to cycle installed themes. Persist by editing `plugins/init.lua` and setting `vim.cmd.colorscheme("name")`.

## Managing plugins/tools
- Plugins: `:Lazy` → `s` sync/update, `x` clean.
- Tools: `:Mason` to install/update/uninstall LSPs/formatters/DAPs.

## Troubleshooting
- Missing plugins: `:Lazy sync`
- Missing tools: `:Mason` and install
- Treesitter errors: `:TSUpdate` (Lazy will manage)
- Undo file errors: handled automatically in `core/options.lua`

## Licensing note
- Plugins are fetched from upstream via Lazy.nvim; they keep their original licenses.


