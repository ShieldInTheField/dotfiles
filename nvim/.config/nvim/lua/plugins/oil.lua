require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open parent directory" })
