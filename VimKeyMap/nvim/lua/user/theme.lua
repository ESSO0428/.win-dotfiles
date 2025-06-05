-- setup lunar colorscheme
require("user.core.lunar").setup()

-- transparent window
vim.cmd "hi Normal ctermbg=none guibg=none"
vim.cmd "hi SignColumn ctermbg=none guibg=none"
vim.cmd "hi WinBarNC cterm=bold guifg=NvimLightGrey4 guibg=none"
vim.cmd "exec 'hi FoldColumn guibg=none guifg=' . synIDattr(synIDtrans(hlID('Folded')), 'fg', 'gui')"
vim.cmd "hi NormalNC ctermbg=none guibg=none"
vim.cmd "hi MsgArea ctermbg=none guibg=none"
vim.cmd "hi TelescopeNormal ctermbg=none guibg=none"
vim.cmd "hi NormalFloat ctermbg=none guibg=none"
vim.cmd "hi FloatBorder ctermbg=none guibg=none guifg=#3d59a1"
vim.cmd "hi Float ctermbg=none guibg=none"
vim.cmd "hi NvimFloat ctermbg=none guibg=none"
vim.cmd "hi WhichKeyFloat ctermbg=none guibg=none"
vim.cmd "hi NvimTreeNormal ctermbg=none guibg=none"
vim.cmd "hi NvimTreeNormalNC ctermbg=none guibg=none"
-- vim.cmd("hi WinSeparator cterm=bold gui=bold guifg=#000000")
vim.cmd "hi NvimTreeWinSeparator ctermbg=none guibg=none"
vim.cmd "hi Navbuddy ctermbg=none guibg=none"
vim.cmd "hi WindowPickerStatusLine ctermfg=15 guifg=#ededed guibg=#e35e4f"
vim.cmd "hi WindowPickerStatusLineNC ctermfg=15 ctermbg=4 gui=bold guifg=#ededed guibg=#4493c8"
vim.cmd "hi WindowPickerWinBar ctermfg=15 guifg=#ededed guibg=#e35e4f"
vim.cmd "hi WindowPickerWinBarNC ctermfg=15 ctermbg=4 gui=bold guifg=#ededed guibg=#4493c8"

-- Utils
vim.cmd "hi @include.python guifg=#c586c0"
vim.cmd "hi pythonInclude guifg=#c586c0"
vim.cmd "hi @keyword.import guifg=#c586c0"
vim.cmd "hi Keyword cterm=italic gui=italic guifg=#9d7cd8"
vim.cmd "hi @Keyword cterm=italic gui=italic guifg=#9d7cd8"
vim.cmd "hi @keyword.import guifg=#c586c0"
vim.cmd "hi link @keyword.operator Keyword"
vim.cmd "hi @variable guifg=#9cdcfe"
vim.cmd "hi @conditional.python guifg=#c586c0"
vim.cmd "hi @exception.python guifg=#c586c0"
vim.cmd "hi @lsp.type.decorator.python guifg=none"
vim.cmd "hi @lsp.type.class.python guifg=#4ec9b0"
vim.cmd "hi link @lsp.type.namespace.python @type.python"
vim.cmd "hi link @lsp.mod.readonly.python Special"
vim.cmd "hi @method.call.python guifg=#daccaa"
vim.cmd "hi @function.method.call.python guifg=#daccaa"
vim.cmd "hi link @lsp.type.function.python @method.call.python"
vim.cmd "hi link @lsp.type.method.python @method.call.python"
vim.cmd "hi link @lsp.type.parameter.python @parameter.python"
vim.cmd "hi @function.python guifg=#daccaa"
vim.cmd "hi @function.call.python guifg=#daccaa"
vim.cmd "hi @field.python guifg=#d19a66"
vim.cmd "hi @boolean.python guifg=#3794FF"
vim.cmd "hi link @constant.builtin.python @boolean.python"
vim.cmd "hi @operator guifg=#ffffff"
vim.cmd "hi @text.reference guifg=#3794ff"
vim.cmd "hi link @spell.markdown Normal"
vim.cmd "hi @markup.strong cterm=bold gui=bold guifg=#daccaa"
vim.cmd "hi @punctuation.special.markdown guifg=#9d7cd8"
vim.cmd "hi link @text.title.2 Title"
vim.cmd "hi link @text.title.2.marker Title"
vim.cmd "hi link markdownH2Delimiter Title"
vim.cmd "hi link @text.title.3 Title"
vim.cmd "hi link @text.title.3.marker Title"
vim.cmd "hi link markdownH3Delimiter Title"
vim.cmd "hi link @text.title.4 Title"
vim.cmd "hi link @text.title.4.marker Title"
vim.cmd "hi link markdownH4Delimiter Title"
vim.cmd "hi link @text.title.5 Title"
vim.cmd "hi link @text.title.5.marker Title"
vim.cmd "hi link markdownH5Delimiter Title"
vim.cmd "hi link @text.title.4 Title"
vim.cmd "hi link @text.title.4.marker Title"
vim.cmd "hi link markdownH4Delimiter Title"
vim.cmd "hi @number.python guifg=#b5cea8"
vim.cmd "hi @float.python guifg=#b5cea8"
vim.cmd "hi @string.python guifg=#ce9178"
vim.cmd "hi @parameter.python guifg=#68b2c8"
vim.cmd "hi @field.python guifg=#4ec9b0"
vim.cmd "hi @type.python guifg=#4ec9b0"
vim.cmd "hi @constant.python guifg=#4fceff"
vim.cmd "hi LspInlayHint guifg=#a59669 guibg=#2d2d2d"
vim.cmd "hi TailwindConceal guifg=#38BDF8"

vim.cmd "hi lualine_a_normal guifg=#16161e guibg=#7aa2f7"
vim.cmd "hi lualine_b_normal guifg=#7aa2f7 guibg=#3b4261"
vim.cmd "hi lualine_c_normal guifg=#a9b1d6 guibg=#16161e"
vim.cmd "hi TreesitterContext guibg=#16161e"

vim.cmd "hi Folded guifg=#7aa2f7 guibg=#3b4261"
vim.cmd "hi NormalNC ctermbg=none guibg=none"
vim.cmd "hi BufferLineBufferSelected guifg=#3ab6f0"
vim.cmd "hi BufferLineTabSelected guifg=#3ab6f0"
vim.cmd "hi BufferLineNumbersSelected cterm=bold,italic gui=bold,italic guifg=#3ab6f0"
vim.cmd "hi LineNr guifg=#71839b"
vim.cmd "hi CursorLineNr cterm=bold gui=bold guifg=#dbc074"

-- Left panel
-- "DiffChange:DiffAddAsDelete",
-- "DiffText:DiffDeleteText",
vim.cmd "hi DiffAddAsDelete gui=none guifg=none guibg=#5F3D4D"
vim.cmd "hi DiffDeleteText gui=none guifg=none guibg=#5A1D1D"

-- Right panel
-- "DiffChange:DiffAdd",
-- "DiffText:DiffAddText",
vim.cmd "hi DiffAddText gui=none guifg=none guibg=#2C6468"

-- transparent window
vim.cmd "hi BufferLineBufferSelected guifg=#3ab6f0"

vim.cmd "hi BufferLineTabSelected guifg=#3ab6f0"
vim.cmd "hi BufferLineNumbersSelected cterm=bold,italic gui=bold,italic guifg=#3ab6f0"
vim.cmd "hi LineNr guifg=#71839b"
vim.cmd "hi CursorLineNr cterm=bold gui=bold guifg=#dbc074"
vim.cmd "hi IlluminatedWord guibg=none"
vim.cmd "hi illuminatedCurWord guibg=none"
vim.cmd "hi IlluminatedWordWrite guibg=none"
vim.cmd "hi IlluminatedWordRead guibg=none"
vim.cmd "hi IlluminatedWordText guibg=none"
vim.cmd "hi DiagnosticUnderlineError guifg=#c0caf5"

vim.cmd "hi IndentBlanklineContextChar guifg=#A184FE gui=nocombine" -- #737aa2

vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"

-- Utils
vim.cmd "hi Todo cterm=bold gui=bold guifg=#71839b guibg=none"
vim.cmd "au BufEnter *.md setlocal syntax=markdown"

vim.cmd "hi Whitespace guifg=#504945"

-- Utils
vim.cmd "hi Comment guifg=#71839b"

-- Reference : https://github.com/sindrets/diffview.nvim/issues/241
vim.cmd "hi DiffAdd gui=none guifg=none guibg=#2C6468"
vim.cmd "hi DiffChange gui=none guifg=none guibg=#272D43"
vim.cmd "hi DiffText gui=none guifg=none guibg=#4A5B80"
vim.cmd "hi DiffDelete gui=none guifg=none guibg=#5F3D4D"
vim.cmd "hi DiffviewDiffAddAsDelete gui=none guifg=none guibg=#5F3D4D"
vim.cmd "hi DiffviewDiffDelete gui=none guifg=#3B4252 guibg=none"

-- Left panel
-- "DiffChange:DiffAddAsDelete",
-- "DiffText:DiffDeleteText",
vim.cmd "hi DiffAddAsDelete gui=none guifg=none guibg=#5F3D4D"
vim.cmd "hi DiffDeleteText gui=none guifg=none guibg=#5A1D1D"

-- Right panel
-- "DiffChange:DiffAdd",
-- "DiffText:DiffAddText",
vim.cmd "hi DiffAddText gui=none guifg=none guibg=#2C6468"

-- Stolen from Akinsho
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=200}",
})
