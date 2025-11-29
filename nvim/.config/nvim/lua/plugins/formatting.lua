-- ========================================================================
-- lua/plugins/formatting.lua — Code formatting
-- ========================================================================
local mason_registry = require("mason-registry")

local ensure = { "black", "clang-format", "stylua", "jq", "prettier", "rustfmt" }
for _, tool in ipairs(ensure) do
  local ok, pkg = pcall(mason_registry.get_package, tool)
  if ok and not pkg:is_installed() then pkg:install() end
end

require("conform").setup({
  formatters_by_ft = {
    python = { "black" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    json = { "jq" },
    markdown = { "prettier" },
    rust = { "rustfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- Format file
vim.keymap.set("n", "<leader>F", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })
