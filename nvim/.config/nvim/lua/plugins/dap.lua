local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup({
  ensure_installed = { "codelldb", "python" },
  automatic_setup = true,
})

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

local map = vim.keymap.set
local opts = { silent = true }
map("n", "<F5>", dap.continue, opts)
map("n", "<F9>", dap.toggle_breakpoint, opts)
map("n", "<F10>", dap.step_over, opts)
map("n", "<F11>", dap.step_into, opts)
map("n", "<S-F11>", dap.step_out, opts)
map("n", "<leader>du", dapui.toggle, opts)
