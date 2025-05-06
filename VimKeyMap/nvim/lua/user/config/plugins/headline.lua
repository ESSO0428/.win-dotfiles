-- vim.cmd "hi Headline1 guibg=#1e2718"
-- vim.cmd "hi Headline2 guibg=#21262d"
vim.cmd("hi Headline1 guibg=#2d421f gui=italic")

vim.cmd("hi Headline2 guibg=#505429 gui=italic")

-- vim.cmd "hi CodeBlock guibg=#1c1c1c"
vim.cmd("hi Dash guifg=#D19A66 gui=bold")

-- orgmode link
vim.cmd("hi @org.hyperlink guifg=#3794FF gui=underline")
vim.cmd("hi link @markup.list.markdown Identifier")
vim.cmd("hi! link markdownOrderedListMarker Identifier")
vim.cmd("hi @markup.link.label.markdown_inline guifg=#3794FF gui=underline")
vim.cmd("hi markdownLinkText guifg=#3794FF gui=underline")
vim.cmd("hi link @org.bullet @markup.list.markdown")
vim.cmd("hi link @org.checkbox.org Identifier")

vim.cmd("hi link @text.title.1 Title")
vim.cmd("hi link @text.title.2 Constant")
vim.cmd("hi link @text.title.3 Identifier")
vim.cmd("hi link @text.title.4 Statement")
vim.cmd("hi link @text.title.5 PreProc")
vim.cmd("hi link @text.title.6 Type")

vim.cmd("hi link markdownH1Delimiter Title")
vim.cmd("hi link markdownH2Delimiter Constant")
vim.cmd("hi link markdownH3Delimiter Identifier")
vim.cmd("hi link markdownH4Delimiter Statement")
vim.cmd("hi link markdownH5Delimiter PreProc")
vim.cmd("hi link markdownH6Delimiter Type")

vim.cmd("hi! link @markup.heading.1.markdown Title")
vim.cmd("hi! link @markup.heading.2.markdown Title")
vim.cmd("hi! link @markup.heading.3.markdown Identifier")
vim.cmd("hi! link @markup.heading.4.markdown Statement")
vim.cmd("hi! link @markup.heading.5.markdown PreProc")
vim.cmd("hi! link @markup.heading.6.markdown Type")

require("headlines").setup({
	markdown = {
		query = vim.treesitter.query.parse(
			"markdown",
			[[
        (atx_heading [
            (atx_h1_marker)
            (atx_h2_marker)
            (atx_h3_marker)
            (atx_h4_marker)
            (atx_h5_marker)
            (atx_h6_marker)
        ] @headline)

        (fenced_code_block) @codeblock
      ]]
		),
		-- headline_highlights = {
		--   "Headline1",
		--   "Headline2"
		-- },
		headline_highlights = false,
		bullet_highlights = {
			"@text.title.1.marker.markdown",
			"@text.title.2.marker.markdown",
			"@text.title.3.marker.markdown",
			"@text.title.4.marker.markdown",
			"@text.title.5.marker.markdown",
			"@text.title.6.marker.markdown",
		},
		bullets = { "◉", "○", "✸", "✿" },
		fat_headlines = false,
		codeblock_hi = "CodeBlock",
		fat_headline_upper_string = "▃",
		fat_headline_lower_string = "▀",
	},
	org = {
		headline_highlights = {
			"Headline1",
			"Headline2",
		},
		bullets = {},
		dash_string = "—",
		fat_headlines = false,
		fat_headline_upper_string = "▃",
		fat_headline_lower_string = "▀",
	},
})
-- vim.api.nvim_create_autocmd('BufRead', {
--   pattern = '*.md',
--   group = vim.api.nvim_create_augroup('markdown_header_custom', { clear = true }),
--   callback = function()
--     vim.cmd([[
--       syntax match markdownHeader1 /^\s*#\ze\s/ conceal cchar=◉
--       syntax match markdownHeader2 /^\s*##\ze\s/ conceal cchar=○
--       syntax match markdownHeader3 /^\s*###\ze\s/ conceal cchar=✸
--       syntax match markdownHeader4 /^\s*####\ze\s/ conceal cchar=✿
--     ]])
--   end
-- })
