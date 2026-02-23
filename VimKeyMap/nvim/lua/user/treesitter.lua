---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
  strategy = {
    [""] = "rainbow-delimiters.strategy.global",
    vim = "rainbow-delimiters.strategy.local",
  },
  query = {
    [""] = "rainbow-delimiters",
    lua = "rainbow-blocks",
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
vim.api.nvim_create_autocmd("User", {
  pattern = "FileOpened",
  callback = function()
    require("nvim-treesitter.install").compilers = { "clang", "gcc" }
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "mysql",
  callback = function(args)
    vim.treesitter.start(args.buf, "sql")
    -- vim.bo[args.buf].syntax = 'on' -- only if additional legacy syntax is needed
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql" },
  once = true,
  callback = function()
    local ft = require "Comment.ft"
    ft.set("mysql", "-- %s")
  end,
})
