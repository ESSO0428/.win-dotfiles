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
