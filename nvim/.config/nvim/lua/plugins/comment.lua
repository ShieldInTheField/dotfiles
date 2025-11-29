vim.g.skip_ts_context_commentstring_module = true

local ts_cc = require("ts_context_commentstring")
ts_cc.setup({})

require("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
