local map = function(keys, func, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, keys, func, { desc = "LSP: " .. desc })
end
vim.api.nvim_set_keymap(
	"n",
	"<leader>rw",
	':lua require("user.integrated.WindowsTerminal").find_and_edit_terminal_settings()<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>rc",
	"<cmd>e $HOME/AppData/Local/nvim/lua/config.lua<cr>",
	{ noremap = true, silent = true }
)

vim.keymap.set(
	"x",
	"<leader>/",
	"<Plug>(comment_toggle_linewise_visual)",
	{ desc = "Comment toggle linewise (visual)" }
)
vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment toggle current line" })

-- Bufferline
map("<c-j>", "<cmd>BufferLineCyclePrev<cr>", "Bufferline Prev Buffer")
map("<c-l>", "<cmd>BufferLineCycleNext<cr>", "Bufferline Next Buffer")
map("<a-j>", "<cmd>BufferLineMovePrev<cr>", "Bufferline Move Buffer to Prev")
map("<a-l>", "<cmd>BufferLineMoveNext<cr>", "Bufferline Move Buffer to Next")
