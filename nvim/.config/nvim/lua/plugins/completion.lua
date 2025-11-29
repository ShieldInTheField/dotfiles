-- ========================================================================
-- lua/plugins/completion.lua — Completion setup (nvim-cmp)
-- ========================================================================

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.config").setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  window = {
  completion = cmp.config.window.bordered(),
  documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
  format = function(entry, vim_item)
    vim_item.menu = ({
      nvim_lsp = "[LSP]",
      luasnip = "[Snip]",
      buffer = "[Buf]",
      path = "[Path]",
    })[entry.source.name]
    return vim_item
  end,
  },
})

-- --- Command-line completion setup ---
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "path" }, { name = "cmdline" } },
})

