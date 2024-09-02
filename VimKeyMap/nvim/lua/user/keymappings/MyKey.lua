vim.api.nvim_set_keymap('n', '<leader>rw', ':lua require("user.integrated.WindowsTerminal").find_and_edit_terminal_settings()<CR>', { noremap = true, silent = true })
