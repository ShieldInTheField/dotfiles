-- ~/.config/nvim/lua/plugins/lsp.lua
-- Mason + LSP setup (Neovim 0.11)

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- 1) Install/ensure LSP servers
mason.setup()
-- Add ruff_lsp here once your mason-lspconfig version exposes it
local ensure_servers = { "pyright", "lua_ls", "clangd", "rust_analyzer" }
mason_lspconfig.setup({
  ensure_installed = ensure_servers,
  automatic_installation = true,
})

-- 2) Shared capabilities + on_attach
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then capabilities = cmp_lsp.default_capabilities(capabilities) end

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  local map = vim.keymap.set
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
end

-- 3) Diagnostics UI
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
})

-- 4) Server-specific setup via handlers (with fallback if setup_handlers is missing)
local server_settings = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
}

local function setup_server(server)
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
  if server_settings[server] then
    opts = vim.tbl_deep_extend("force", opts, server_settings[server])
  end
  lspconfig[server].setup(opts)
end

if mason_lspconfig.setup_handlers then
  mason_lspconfig.setup_handlers({
    function(server) setup_server(server) end,
  })
else
  -- Fallback for older mason-lspconfig without setup_handlers
  for _, server in ipairs(ensure_servers) do
    setup_server(server)
  end
end
