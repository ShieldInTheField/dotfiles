-- rustaceanvim basic config
vim.g.rustaceanvim = {
  tools = {
    hover_actions = { replace_builtin_hover = true },
  },
  server = {
    on_attach = function(client, bufnr)
      local map = vim.keymap.set
      local opts = { buffer = bufnr }
      map("n", "K", function() vim.cmd("RustLsp hover actions") end, opts)
      map("n", "<leader>rr", function() vim.cmd("RustLsp runnables") end, opts)
      map("n", "<leader>ri", function() vim.cmd("RustLsp inlay hints toggle") end, opts)
    end,
  },
}
