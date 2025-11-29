local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- dashboard.section.header.val = {
--   "   _   _           _           ",
--   "  | \\ | | ___   __| | ___ _ __ ",
--   "  |  \\| |/ _ \\ / _` |/ _ \\ '__|",
--   "  | |\\  | (_) | (_| |  __/ |   ",
--   "  |_| \\_|\\___/ \\__,_|\\___|_|   ",
-- }

dashboard.section.header.val = {
  "Shield in the field's",
  "       GraVimy       ",
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
  dashboard.button("g", "  Live grep", ":Telescope live_grep<CR>"),
  dashboard.button("o", "  Open dir", ":Oil<CR>"),
  dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

dashboard.section.footer.val = "Follow the white rabbit..."

local top_padding = math.max(2, math.floor(vim.fn.winheight(0) * 0.2))
dashboard.config.layout = {
  { type = "padding", val = top_padding },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  dashboard.section.footer,
}

alpha.setup(dashboard.config)
