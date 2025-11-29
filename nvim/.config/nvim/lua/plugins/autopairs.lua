-- nvim-autopairs with cmp integration
local npairs = require("nvim-autopairs")
npairs.setup({})

local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
