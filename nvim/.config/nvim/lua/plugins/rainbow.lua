-- rainbow-delimiters configuration (defaults are fine)
local rd = require("rainbow-delimiters")

vim.g.rainbow_delimiters = {
  strategy = {
    [""] = rd.strategy["global"],
    vim = rd.strategy["local"],
  },
  query = {
    [""] = "rainbow-delimiters",
  },
  highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
  },
}
