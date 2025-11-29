local telescope = require("telescope")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local themes = require("telescope.themes")

local has_fd = vim.fn.executable("fd") == 1
local find_command
if has_fd then
  find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
elseif vim.fn.executable("rg") == 1 then
  find_command = { "rg", "--files", "--hidden", "--glob", "!.git/**", "--no-config" }
end

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg", "--hidden", "--glob", "!.git/**", "--no-heading",
      "--with-filename", "--line-number", "--column", "--smart-case", "--no-config",
    },
    find_command = find_command,
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
})

pcall(telescope.load_extension, "fzf")

local builtin = require("telescope.builtin")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function live_multigrep()
  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end
      local pieces = vim.split(prompt, "  ") -- separate pattern and glob with double space
      local args = { "rg" }
      if pieces[1] and pieces[1] ~= "" then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end
      if pieces[2] and pieces[2] ~= "" then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end
      return vim.tbl_flatten({
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden", "--glob", "!.git/**", "--no-config" },
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep({}),
    cwd = vim.uv.cwd(),
  })

  pickers.new({}, themes.get_ivy({
    debounce = 100,
    prompt_title = "Multi Grep (pattern  ␠␠  glob)",
    finder = finder,
    previewer = conf.grep_previewer({}),
    sorter = require("telescope.sorters").empty(),
  })):find()
end

map("n", "<leader>ff", function() builtin.find_files({ hidden = true, follow = true }) end, opts)
map("n", "<leader>fg", live_multigrep, opts)
map("n", "<leader>fb", builtin.buffers, opts)
map("n", "<leader>fh", builtin.help_tags, opts)
