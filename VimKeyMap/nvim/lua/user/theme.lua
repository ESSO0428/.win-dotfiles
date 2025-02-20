vim.cmd("hi lualine_a_normal guifg=#16161e guibg=#7aa2f7")
vim.cmd("hi lualine_b_normal guifg=#7aa2f7 guibg=#3b4261")
vim.cmd("hi lualine_c_normal guifg=#a9b1d6 guibg=#16161e")
vim.cmd("hi TreesitterContext guibg=#16161e")

-- Reference : https://github.com/sindrets/diffview.nvim/issues/241
vim.cmd("exec 'hi FoldColumn guibg=none guifg=' . synIDattr(synIDtrans(hlID('Folded')), 'fg', 'gui')")
vim.cmd("hi Folded guifg=#7aa2f7 guibg=#3b4261")
vim.cmd("hi NormalNC ctermbg=none guibg=none")
vim.cmd("hi NormalFloat ctermbg=none guibg=none")
vim.cmd("hi BufferLineBufferSelected guifg=#3ab6f0")
vim.cmd("hi BufferLineTabSelected guifg=#3ab6f0")
vim.cmd("hi BufferLineNumbersSelected cterm=bold,italic gui=bold,italic guifg=#3ab6f0")
vim.cmd("hi LineNr guifg=#71839b")
vim.cmd("hi CursorLineNr cterm=bold gui=bold guifg=#dbc074")
vim.cmd("hi DiffAdd gui=none guifg=none guibg=#2C6468")
vim.cmd("hi DiffChange gui=none guifg=none guibg=#272D43")
vim.cmd("hi DiffText gui=none guifg=none guibg=#4A5B80")
vim.cmd("hi DiffDelete gui=none guifg=none guibg=#5F3D4D")
vim.cmd("hi DiffviewDiffAddAsDelete gui=none guifg=none guibg=#5F3D4D")
vim.cmd("hi DiffviewDiffDelete gui=none guifg=#3B4252 guibg=none")

-- Left panel
-- "DiffChange:DiffAddAsDelete",
-- "DiffText:DiffDeleteText",
vim.cmd("hi DiffAddAsDelete gui=none guifg=none guibg=#5F3D4D")
vim.cmd("hi DiffDeleteText gui=none guifg=none guibg=#5A1D1D")

-- Right panel
-- "DiffChange:DiffAdd",
-- "DiffText:DiffAddText",
vim.cmd("hi DiffAddText gui=none guifg=none guibg=#2C6468")
