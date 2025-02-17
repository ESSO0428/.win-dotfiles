-- This module contains a number of default definitions
-- NOTE: 與 treesitter regex 不兼融，請避免 TSInstall regex
local rainbow_delimiters = require("rainbow-delimiters")

---@class rainbow_delimiters
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = rainbow_delimiters.strategy["global"],
		vim = rainbow_delimiters.strategy["local"],
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
pcall(function()
	require("nvim-dap-repl-highlights").setup()
end)
require("nvim-treesitter.install").compilers = { "clang", "gcc" }
vim.api.nvim_create_autocmd("FileType", {
	pattern = "mysql",
	callback = function(args)
		vim.treesitter.start(args.buf, "sql")
		vim.bo[args.buf].syntax = "on" -- only if additional legacy syntax is needed
	end,
})
local ft = require("Comment.ft")
ft.set("mysql", "-- %s")
