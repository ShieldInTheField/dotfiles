-- ========================================================================
-- lua/plugins/init.lua — Plugin management via lazy.nvim
-- ========================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core essentials
  { "nvim-lua/plenary.nvim", lazy = false, priority = 900 },     -- foundational, load before everything else
  { "nvim-tree/nvim-web-devicons", priority = 850 }, -- icon support before UI

  -- UI & Theme
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000,
    config = function()
      require("kanagawa").setup({})
      vim.cmd.colorscheme("kanagawa")
    end },
  { "nvim-lualine/lualine.nvim", priority = 800,
    config = function()
      require("lualine").setup({ options = { theme = "kanagawa" } })
    end
  },

  -- Treesitter (syntax)
  { "nvim-treesitter/nvim-treesitter", priority = 700,
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function() require("plugins.treesitter") end },
  { "HiPhish/rainbow-delimiters.nvim", priority = 675,
    config = function() require("plugins.rainbow") end },

  -- Telescope (finder/grep)
  { "nvim-telescope/telescope.nvim", priority = 650,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
    },
    config = function() require("plugins.telescope") end },

  -- Git
  { "lewis6991/gitsigns.nvim", priority = 600,
    config = function() require("gitsigns").setup() end },

  -- LSP Support
  { "neovim/nvim-lspconfig", priority = 500,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function() require("plugins.lsp") end },
  { "folke/trouble.nvim", priority = 490,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugins.trouble") end },

  -- Debugging
  { "mfussenegger/nvim-dap", priority = 480,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
      "nvim-neotest/nvim-nio",
    },
    config = function() require("plugins.dap") end },

  -- Completion
  { "hrsh7th/nvim-cmp", priority = 400,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function() require("plugins.completion") end },
  { "windwp/nvim-autopairs", priority = 390,
    config = function() require("plugins.autopairs") end },

  -- Formatting / linting
  { "stevearc/conform.nvim", priority = 300,
    config = function() require("plugins.formatting") end },

  -- Editing UX
  { "folke/which-key.nvim", priority = 250,
    config = function() require("plugins.whichkey") end },
  { "numToStr/Comment.nvim", priority = 245,
    config = function() require("plugins.comment") end },
  { "lukas-reineke/indent-blankline.nvim", priority = 240,
    config = function() require("plugins.indentline") end },
  { "stevearc/dressing.nvim", priority = 230 },
  { "rcarriga/nvim-notify", priority = 220,
    config = function()
      vim.notify = require("notify")
    end },

  -- Startup dashboard
  { "goolord/alpha-nvim", priority = 1001,
    config = function() require("plugins.alpha") end },

  -- File management
  { "stevearc/oil.nvim", priority = 210,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugins.oil") end },

  -- Rust extras
  { "mrcjkb/rustaceanvim", version = "^4", ft = { "rust" },
    config = function() require("plugins.rust") end },
})
