-- ========================================================================
-- lua/core/options.lua — Basic editor settings
-- ========================================================================

local opt = vim.opt
local g = vim.g

-- General
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.signcolumn = "yes"

-- Tabs & indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Appearance
opt.wrap = false
opt.splitbelow = true
opt.splitright = true
opt.cursorlineopt = "number"  -- highlight only the line number, not the full line

-- Performance
opt.updatetime = 300
opt.timeoutlen = 400

-- Misc
g.mapleader = " "

-- Completion options
opt.completeopt = { "menuone", "noselect" }

-- Undo options
opt.undofile = true
local undodir = vim.fn.stdpath("state") .. "/undo"
opt.undodir = undodir
pcall(vim.fn.mkdir, undodir, "p") -- ensure undo dir exists
