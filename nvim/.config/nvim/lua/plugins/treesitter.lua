-- ========================================================================
-- lua/plugins/treesitter.lua — Treesitter setup
-- ========================================================================

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua", "python", "c", "cpp", "bash", "json", "yaml", "markdown", "vim", "toml", "make", "dockerfile", "gitignore"
  },
  highlight = {
  enable = true,
  additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      node_decremental = "grm",
    },
  },
  autotag = { enable = true },      -- auto-close HTML/XML tags
})
