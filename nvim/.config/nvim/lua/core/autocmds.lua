-- ========================================================================
-- lua/core/autocmds.lua — Useful automatic commands
-- ========================================================================

local api = vim.api

-- Highlight yanked text
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Hybrid reload: reload core + safely sync Lazy.nvim plugins
api.nvim_create_user_command("ReloadConfig", function()
  -- 1. Reload your own Lua modules (core/*)
  for name, _ in pairs(package.loaded) do
    if name:match("^core") then
      package.loaded[name] = nil
    end
  end

  require("core")

  -- 2. Trigger Lazy.nvim sync for safe plugin state refresh
  local ok, lazy = pcall(require, "lazy")
  if ok then
    if type(lazy.sync) == "function" then
      lazy.sync() -- official safe API
      vim.notify("🔄 Core reloaded & Lazy plugins synced", vim.log.levels.INFO)
    else
      vim.cmd("Lazy sync") -- fallback to command
      vim.notify("🔄 Core reloaded & Lazy plugins synced (:Lazy sync)", vim.log.levels.INFO)
    end
  else
    vim.notify("⚠️ Lazy.nvim not found — only core reloaded", vim.log.levels.WARN)
  end
end, {})