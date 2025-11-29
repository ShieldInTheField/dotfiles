require("trouble").setup({})

local map = vim.keymap.set
local opts = { silent = true }
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts)
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", opts)
